---
title: "CKAD 复习：工作负载题压缩模板"
author: "陈金鑫"
description : "把 CKAD 中 Pod、Deployment、Job、CronJob、探针、资源限制压缩成少量模板"
lastmod: 2026-08-09T11:20:00+08:00
date: 2026-08-09T11:20:00+08:00
tags : [
    "kubernetes",
    "ckad",
    "Pod",
    "Deployment",
    "Job",
    "CronJob",
]
categories : [
    "kubernetes"
]

---

CKAD 的工作负载题不用按题背，核心只记 4 个资源：`Pod`、`Deployment`、`Job`、`CronJob`。多数题都是在这 4 个对象上补字段：标签、命令、环境变量、卷、探针、资源限制、滚动更新。

## 1. Pod：单容器和临时测试

能用命令生成的先用命令，复杂字段再 `--dry-run=client -o yaml` 后改。

```bash
# 创建带标签、环境变量、端口的 Pod 模板
k run nginx-pod \
  --image=nginx \
  --restart=Never \
  --labels="app=web,env=prod" \
  --env="APP_ENV=production" \
  --port=80 \
  --dry-run=client -o yaml > pod.yaml

k apply -f pod.yaml

# 一次性临时容器：常用于测 Service、DNS、HTTP
k run tmp \
  --restart=Never \
  --rm -i \
  --image=busybox \
  -- wget -O- frontend-svc:80
```

常见改法：

```bash
k get pod -n <ns> --show-labels
k label pod nginx-pod tier=frontend -n <ns>
k annotate pod nginx-pod owner=ckad -n <ns>
k logs nginx-pod -n <ns>
k exec -it nginx-pod -n <ns> -- sh
```

## 2. 多容器 Pod：共享 emptyDir

多容器、sidecar logging、initContainer 题都可以从这个结构变形。

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: sidecar-pod
  namespace: workloads
spec:
  initContainers:
  - name: init
    image: busybox
    command: ["sh", "-c", "echo init > /work/app.log"]
    volumeMounts:
    - name: work
      mountPath: /work
  containers:
  - name: app
    image: nginx
    volumeMounts:
    - name: work
      mountPath: /var/log/app
  - name: sidecar
    image: busybox
    command: ["sh", "-c", "tail -f /var/log/app/app.log"]
    volumeMounts:
    - name: work
      mountPath: /var/log/app
  volumes:
  - name: work
    emptyDir: {}
```

记忆点：两个容器要共享数据，只要 `volumeMounts[].name` 指向同一个 `volumes[].name`。

## 3. Deployment：副本、镜像、暴露、回滚

Deployment 是 Pod 模板外面套一层副本控制，考试里经常要求创建、修镜像、看 rollout、暴露 Service。

```bash
# 创建 3 副本 Deployment
k create ns dev
k create deployment nginx-deployment -n dev --image=nginx:latest --replicas=3

# 改镜像并观察滚动更新
k set image deployment/nginx-deployment nginx=nginx:1.25 -n dev
k rollout status deployment/nginx-deployment -n dev
k rollout history deployment/nginx-deployment -n dev

# 回滚
k rollout undo deployment/nginx-deployment -n dev

# 暴露成 ClusterIP Service
k expose deployment nginx-deployment -n dev --name=nginx-svc --port=80 --target-port=80
```

如果题目从 Pod 改成 Deployment：

```bash
k get pod old-pod -o yaml > deploy.yaml
```

然后把 `kind: Pod` 改成 `kind: Deployment`，补 `spec.replicas`、`spec.selector.matchLabels`、`spec.template.metadata.labels`、`spec.template.spec`。最容易错的是 selector 和 template labels 不一致。

## 4. 探针和资源限制：只补容器字段

探针、requests、limits 都在 `spec.containers[]` 下面。

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: health-pod
  namespace: workloads
spec:
  containers:
  - name: nginx
    image: nginx
    ports:
    - containerPort: 80
    resources:
      requests:
        cpu: 100m
        memory: 128Mi
      limits:
        cpu: 200m
        memory: 256Mi
    livenessProbe:
      httpGet:
        path: /healthz
        port: 80
      periodSeconds: 15
    readinessProbe:
      tcpSocket:
        port: 80
      periodSeconds: 10
```

快速 patch Deployment 里的资源限制：

```bash
k patch deployment broken-deployment -n troubleshooting --type='json' -p='[
  {"op":"add","path":"/spec/template/spec/containers/0/resources","value":{"requests":{"cpu":"100m","memory":"128Mi"},"limits":{"cpu":"200m","memory":"256Mi"}}}
]'
```

## 5. Job 和 CronJob：一次执行与定时执行

`Job` 负责完成一次，`CronJob` 负责按时间创建 Job。命令字段背一个形式就够了。

```yaml
apiVersion: batch/v1
kind: Job
metadata:
  name: hello-job
  namespace: workloads
spec:
  activeDeadlineSeconds: 30
  template:
    spec:
      restartPolicy: Never
      containers:
      - name: hello
        image: busybox
        command: ["sh", "-c", "echo hello && sleep 5"]
```

```yaml
apiVersion: batch/v1
kind: CronJob
metadata:
  name: log-cleaner
  namespace: workloads
spec:
  schedule: "0 * * * *"
  concurrencyPolicy: Forbid
  jobTemplate:
    spec:
      template:
        spec:
          restartPolicy: OnFailure
          containers:
          - name: cleaner
            image: busybox
            command: ["sh", "-c", "rm -rf /var/log/*.log"]
```

## 高频检查命令

```bash
k get pod,deploy,job,cronjob -n <ns>
k describe pod <pod> -n <ns>
k logs <pod> -n <ns> [-c <container>]
k get events -n <ns> --sort-by=.lastTimestamp
k rollout status deployment/<deploy> -n <ns>
```

## 考场压缩记忆

- Pod：容器本体，背 `containers / volumeMounts / volumes`。
- Deployment：Pod 外面加 `replicas / selector / template`。
- Job：Pod 外面加 `template`，必须有 `restartPolicy`。
- CronJob：Job 外面加 `schedule / jobTemplate`。
- 探针、资源限制、env、securityContext 都贴在 `containers[]` 上。
