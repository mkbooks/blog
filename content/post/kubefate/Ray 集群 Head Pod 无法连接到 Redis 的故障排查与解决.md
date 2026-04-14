---
title: "Ray 集群 Head Pod 无法连接到 Redis 的故障排查与解决"
date: 2026-03-28T22:00:00+08:00
lastmod: 2026-04-14T10:00:00+08:00
draft: false
description: "排查 KubeRay 中 Ray Head Pod 因 Redis 连接失败导致无法就绪的问题，提供网络测试方法和解决方案"
categories: ["Kubernetes", "Ray", "故障排查"]
tags: ["Ray", "KubeRay", "Redis", "Kubernetes", "网络排查", "Base64"]
author: "陈金鑫"
---

## 📌 问题现象

在 Kubernetes 环境中部署的 Ray 集群（使用 KubeRay Operator）出现 Head Pod 运行异常：

- Pod 状态为 `Running`，但 `Ready` 状态为 `False`
- 容器的 **Liveness** 和 **Readiness** 探针持续失败
- 业务服务无法正常使用

通过 `kubectl describe pod` 查看，发现探针命令执行失败：

```bash
Liveness probe failed: 
Readiness probe failed:
```

探针内部检查了两个 Ray 健康端点：
- `http://localhost:52365/api/local_raylet_healthz`
- `http://localhost:8265/api/gcs_healthz`

## 🔍 初步排查

### 1. 查看 Head 容器日志

```bash
kubectl logs -n ray <pod-name> -c ray-serve-head
```

日志中反复出现以下错误：

```
[2026-03-28 22:09:05,274 E 1 1] (ray_init) redis_context.cc:386: Failed to connect to Redis due to: RedisError: Could not establish connection to Redis 192.168.16.188:6379 (context.err = 1).. Will retry in 500ms.
```

**关键信息**：Ray Head 无法连接到外部 Redis `192.168.16.188:6379`，导致初始化一直卡在重试阶段，健康端点始终无法就绪。

### 2. 环境变量检查

从 `describe pod` 输出中看到相关环境变量：

```yaml
Environment:
  RAY_REDIS_ADDRESS:   192.168.16.188:6379
  REDIS_PASSWORD:      <set to the key 'pwd' in secret 'redis-secret'>
```

说明 Ray 被配置为使用外部 Redis，并需要密码认证。

## 🧩 故障原因定位

根本原因是 **Ray Head Pod 与 Redis 服务之间的网络不通**，具体可能包括：

- Redis 服务未运行或未暴露正确端口
- 防火墙/安全组阻止了 Pod 所在节点对 Redis IP:Port 的访问
- 网络策略（NetworkPolicy）限制了跨命名空间或跨集群的流量
- 配置的 Redis 地址错误（例如 IP 已变更）

## 🛠 排查步骤

### 1. 测试 Pod 到 Redis 的网络连通性

进入 Head 容器：

```bash
kubectl exec -it -n ray <pod-name> -c ray-serve-head -- bash
```

使用多种命令测试（根据容器内可用工具选择）：

#### ✅ 使用 `nc` (netcat)
```bash
nc -zv 192.168.16.188 6379
```

#### ✅ 使用 `telnet`
```bash
telnet 192.168.16.188 6379
```

#### ✅ 使用 `curl`
```bash
curl -v telnet://192.168.16.188:6379
```

#### ✅ 使用 `wget`
```bash
wget --timeout=2 --tries=1 -O- 192.168.16.188:6379
```

#### ✅ 使用 Bash 内置 `/dev/tcp`
```bash
timeout 2 bash -c "echo >/dev/tcp/192.168.16.188/6379" && echo "Port open" || echo "Port closed"
```

如果以上命令均显示连接超时或拒绝，则确认网络不通。

### 2. 从集群其他 Pod 测试

启动一个临时调试 Pod：

```bash
kubectl run test-conn --image=busybox --restart=Never -it --rm -- nc -zv 192.168.16.188 6379
```

### 3. 检查 Redis 服务本身

- 确认 Redis 是否正在运行：`systemctl status redis` 或查看对应 Kubernetes Service/Deployment
- 检查 Redis 监听地址：是否绑定了 `0.0.0.0` 或正确的内网 IP
- 检查密码是否正确：从 Secret 中解码验证

```bash
kubectl get secret -n ray redis-secret -o jsonpath='{.data.pwd}' | base64 -d
```

### 4. 检查网络策略与安全组

- 如果 Redis 部署在同一个 Kubernetes 集群的不同命名空间，检查 NetworkPolicy 是否允许流量从 `ray` 命名空间流向 Redis 所在命名空间
- 如果 Redis 部署在集群外部的虚拟机或物理机上，检查节点所在的安全组/防火墙是否允许出站到 `192.168.16.188:6379`

## 💡 解决方案

根据排查结果选择对应的修复方式：

### 方案一：修复网络连通性

- **调整安全组/防火墙规则**：允许集群节点 IP 访问 Redis 主机的 6379 端口
- **创建或修改 NetworkPolicy**：允许 `ray` 命名空间的 Pod 访问 Redis 服务
- **使用 Kubernetes Service 名称**：如果 Redis 部署在集群内部，改用 Service 域名（如 `redis-service.namespace.svc.cluster.local`）代替硬编码 IP，避免 IP 变更导致故障

### 方案二：在集群内部署 Redis

如果外部 Redis 网络难以打通，可考虑在 Kubernetes 内重新部署一个 Redis，并通过 Service 暴露给 Ray 使用。

示例 Redis Deployment + Service：

```yaml
apiVersion: v1
kind: Service
metadata:
  name: redis-internal
  namespace: ray
spec:
  selector:
    app: redis
  ports:
    - port: 6379
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: redis
  namespace: ray
spec:
  replicas: 1
  selector:
    matchLabels:
      app: redis
  template:
    metadata:
      labels:
        app: redis
    spec:
      containers:
        - name: redis
          image: redis:7-alpine
          ports:
            - containerPort: 6379
```

然后修改 RayCluster 的 `RAY_REDIS_ADDRESS` 环境变量为 `redis-internal.ray.svc.cluster.local:6379`。

### 方案三：修改 Ray 配置，使用内置 Redis（不推荐生产环境）

Ray 默认会启动一个内置的 Redis 实例，但 KubeRay 通常配置使用外部 Redis 以实现高可用。如果临时调试，可以移除 `RAY_REDIS_ADDRESS` 环境变量，让 Ray 自己启动 Redis。

## ✅ 验证修复

网络修复后，重启 Ray Pod（或等待自动重建），观察日志：

```bash
kubectl logs -n ray <pod-name> -c ray-serve-head --tail=20 -f
```

应看到不再有 Redis 连接失败的错误，最终出现类似 `Ray runtime started` 的日志。随后探针检查成功，Pod 状态变为 `Ready`。

```bash
kubectl get pod -n ray
NAME                                                READY   STATUS    RESTARTS   AGE
bds-xxx-head-xxx                                    2/2     Running   0          2m
```

## 📎 附录：生成无换行的 Base64 编码（用于 Kubernetes Secret）

在配置 Redis 密码或认证 Token 的 Secret 时，常常需要将明文进行 base64 编码，并且要求编码后的字符串不包含换行符，以便直接粘贴到 YAML 中。

### 正确命令：

```bash
# 对字符串编码（-n 去掉末尾换行，-w 0 禁止 base64 换行）
echo -n "your-password" | base64 -w 0
```

示例：

```bash
$ echo -n "mysecret" | base64 -w 0
bXlzZWNyZXQ=
```

### 在 Secret YAML 中使用：

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: redis-secret
type: Opaque
data:
  pwd: bXlzZWNyZXQ=    # 单行，无换行
```

> **注意**：macOS 自带的 base64 不支持 `-w` 选项，可使用 `openssl base64 -A` 替代。

## 📚 总结

遇到 Ray Head Pod 无法就绪的问题时，优先检查容器日志。如果日志中出现 Redis 连接失败，则几乎可以确定是网络或认证问题。通过容器内网络测试工具（`nc`、`telnet`、`curl`、`/dev/tcp` 等）定位具体原因，再根据 Redis 的部署位置选择修复网络连通性、迁移 Redis 或修正地址配置。最终确保 Ray 能成功连接到 Redis 后，集群即可恢复正常。

希望这篇博客能帮助你快速排查和解决 Ray 集群中的 Redis 连接问题。
