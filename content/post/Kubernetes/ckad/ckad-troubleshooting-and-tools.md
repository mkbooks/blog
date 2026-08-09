---
title: "CKAD 复习：排障、Helm、CRD 与镜像工具"
author: "陈金鑫"
description : "把 CKAD 中排障、Helm、CRD、OCI/Docker 和常用输出命令压缩成速查模板"
lastmod: 2026-08-09T11:40:00+08:00
date: 2026-08-09T11:40:00+08:00
tags : [
    "kubernetes",
    "ckad",
    "troubleshooting",
    "Helm",
    "CRD",
]
categories : [
    "kubernetes"
]

---

排障题不要凭感觉改，先按固定链路收证据：`get` 看状态，`describe` 看事件，`logs` 看应用，`rollout` 看发布，`endpoints` 看 Service 是否选中 Pod。

## 1. Deployment 启动失败

```bash
k get deploy,pod -n troubleshooting -o wide
k describe deployment broken-deployment -n troubleshooting
k describe pod -l app=broken-app -n troubleshooting
k logs -l app=broken-app -n troubleshooting --all-containers=true
k get events -n troubleshooting --sort-by=.lastTimestamp
```

常见修法：

```bash
# 镜像错
k set image deployment/broken-deployment nginx=nginx:1.19 -n troubleshooting

# 资源限制缺失或过低
k patch deployment broken-deployment -n troubleshooting --patch '{"spec":{"template":{"spec":{"containers":[{"name":"nginx","resources":{"requests":{"cpu":"100m","memory":"128Mi"},"limits":{"cpu":"200m","memory":"256Mi"}}}]}}}}'

# 观察发布结果
k rollout status deployment/broken-deployment -n troubleshooting
k rollout history deployment/broken-deployment -n troubleshooting
```

## 2. Service 不通

```bash
k get svc web-service -n troubleshooting -o wide
k describe svc web-service -n troubleshooting
k get endpoints web-service -n troubleshooting
k get pod -n troubleshooting --show-labels
k run tmp --restart=Never --rm -i --image=busybox -- wget -O- web-service:80
```

判断：

- `endpoints` 为空：selector 和 Pod label 不匹配。
- `endpoints` 有 IP 但访问失败：检查 `targetPort`、容器监听端口、NetworkPolicy。
- 只有某个 Pod 失败：看该 Pod 的 logs/events。

## 3. 常用输出与定位

```bash
# 所有命名空间资源概览
k get pod -A -o wide
k get deploy,svc,ingress,netpol -A

# 自定义列
k get pod -A -o custom-columns='NS:.metadata.namespace,NAME:.metadata.name,NODE:.spec.nodeName,IMAGE:.spec.containers[*].image'

# JSONPath
k get pod nginx -o jsonpath='{.spec.containers[*].image}'

# 排序事件
k get events -A --sort-by=.lastTimestamp
```

## 4. Helm 基础题

Helm 题通常是添加仓库、安装 chart、升级、回滚、卸载。

```bash
k create ns web
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update

helm install nginx bitnami/nginx -n web --set replicaCount=2
helm list -n web
helm status nginx -n web

helm upgrade nginx bitnami/nginx -n web --set replicaCount=3
helm history nginx -n web
helm rollback nginx 1 -n web
helm uninstall nginx -n web
```

## 5. CRD 最小模板

CRD 题只要能写出 group、kind、plural、version、schema。

```yaml
apiVersion: apiextensions.k8s.io/v1
kind: CustomResourceDefinition
metadata:
  name: backups.data.example.com
spec:
  group: data.example.com
  scope: Namespaced
  names:
    plural: backups
    singular: backup
    kind: Backup
    shortNames:
    - bkp
  versions:
  - name: v1alpha1
    served: true
    storage: true
    schema:
      openAPIV3Schema:
        type: object
        properties:
          spec:
            type: object
            properties:
              source:
                type: string
              destination:
                type: string
```

## 6. OCI/Docker 基础

如果题目要求处理镜像归档或 Dockerfile，记住最短路径：

```bash
cat > Dockerfile <<'EOF'
FROM nginx:alpine
COPY index.html /usr/share/nginx/html/
EXPOSE 80
EOF

docker build -t ckad-nginx:latest .
docker save ckad-nginx:latest -o /tmp/ckad-nginx.tar
docker load -i /tmp/ckad-nginx.tar
```

OCI 归档类题：

```bash
docker pull nginx:latest
docker save nginx:latest -o /tmp/nginx-image.tar
mkdir -p /root/oci-images
tar -xf /tmp/nginx-image.tar -C /root/oci-images
```

## 考场压缩记忆

- 排障先证据后修改：`get -> describe -> logs -> events`。
- Deployment 修复后必须 `rollout status`。
- Service 题核心看 `endpoints`。
- Helm 固定顺序：`repo add/update -> install -> list/status -> upgrade/rollback`。
- CRD 固定骨架：`group + names + versions + schema`。