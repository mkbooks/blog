---
title: "CKAD 复习：网络题压缩模板"
author: "陈金鑫"
description : "把 CKAD 中 Service、Ingress、NetworkPolicy 和网络排障压缩成少量模板"
lastmod: 2026-08-09T11:30:00+08:00
date: 2026-08-09T11:30:00+08:00
tags : [
    "kubernetes",
    "ckad",
    "Service",
    "Ingress",
    "NetworkPolicy",
]
categories : [
    "kubernetes"
]

---

网络题只围绕 3 个资源：`Service` 找 Pod，`Ingress` 找 Service，`NetworkPolicy` 限制 Pod 流量。排障时顺着这条链查：客户端 -> Service -> Endpoints -> Pod labels -> containerPort。

## 1. Service：selector 必须匹配 Pod label

ClusterIP 是默认类型，内部访问用它。

```yaml
apiVersion: v1
kind: Service
metadata:
  name: internal-app
  namespace: networking
spec:
  type: ClusterIP
  selector:
    app: backend
  ports:
  - port: 80
    targetPort: 8080
```

NodePort 暴露到节点端口：

```yaml
apiVersion: v1
kind: Service
metadata:
  name: public-web
  namespace: networking
spec:
  type: NodePort
  selector:
    app: web
  ports:
  - port: 80
    targetPort: 80
    nodePort: 30080
```

用命令从 Deployment 暴露 Service：

```bash
k expose deployment web-frontend -n networking \
  --name=public-web \
  --type=NodePort \
  --port=80 \
  --target-port=80
```

## 2. Service 排障：看 Endpoints

Service 不通时优先查 selector 和 endpoint。

```bash
k get svc web-service -n troubleshooting -o wide
k describe svc web-service -n troubleshooting
k get endpoints web-service -n troubleshooting
k get pod -n troubleshooting --show-labels
```

如果 `ENDPOINTS` 为空，通常是 Service selector 和 Pod label 不匹配：

```bash
# 方案 1：改 Service selector
k patch svc web-service -n troubleshooting -p '{"spec":{"selector":{"app":"web"}}}'

# 方案 2：给 Pod/Deployment 模板补 label
k label pod <pod> app=web -n troubleshooting
```

临时测试：

```bash
k run tmp --restart=Never --rm -i --image=busybox -- wget -O- web-service:80
```

## 3. Ingress：host/path -> service/port

Ingress 只是七层路由，后端必须是 Service。

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: api-ingress
  namespace: networking
spec:
  rules:
  - host: api.example.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: api-service
            port:
              number: 80
```

检查：

```bash
k get ingress -n networking
k describe ingress api-ingress -n networking
```

## 4. NetworkPolicy：选择目标 Pod，再写允许来源

题型：“只允许 label 为 `tier=frontend` 的 Pod 访问 label 为 `app=web` 的 Pod 的 80 端口”。

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-traffic
  namespace: networking
spec:
  podSelector:
    matchLabels:
      app: web
  policyTypes:
  - Ingress
  ingress:
  - from:
    - podSelector:
        matchLabels:
          tier: frontend
    ports:
    - protocol: TCP
      port: 80
```

记忆点：

- `spec.podSelector` 选被保护的目标 Pod。
- `ingress.from.podSelector` 选允许进来的来源 Pod。
- 一旦 Pod 被 NetworkPolicy 选中，未显式允许的流量会被拒绝。

## 5. 自定义列输出

Killer Shell 常出现“输出特定列到文件”：

```bash
k get ns > /opt/course/1/namespaces
k get pod -A -o custom-columns='NS:.metadata.namespace,NAME:.metadata.name,IMAGE:.spec.containers[*].image'
k get svc -A -o wide
```

## 考场压缩记忆

- Service：`selector` 找 Pod，`port` 是 Service 端口，`targetPort` 是容器端口。
- Ingress：`host/path` 找 Service，不直接找 Pod。
- NetworkPolicy：先选“被保护目标”，再写“允许来源”。
- 排障固定看：`svc -> endpoints -> pod labels -> logs/events`。
