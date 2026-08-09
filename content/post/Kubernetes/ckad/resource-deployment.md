---
title: "CKAD 常用资源：Deployment"
author: "陈金鑫"
description : "Deployment 的 YAML 模板和 CKAD 常考字段解析"
lastmod: 2026-08-09T12:06:00+08:00
date: 2026-08-09T12:06:00+08:00
tags : ["kubernetes", "ckad", "Deployment"]
categories : ["kubernetes"]

---

`Deployment` 用来管理无状态应用副本和滚动更新。CKAD 常考创建 Deployment、修改镜像、扩缩容、回滚、暴露 Service。

## YAML 模板

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
  namespace: dev
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  strategy:
    type: RollingUpdate
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.25
        ports:
        - containerPort: 80
```

## 常考字段解析

- `spec.replicas`：副本数。
- `spec.selector.matchLabels`：Deployment 管理哪些 Pod。
- `spec.template.metadata.labels`：Pod 模板标签，必须匹配 selector。
- `spec.template.spec.containers`：真正的 Pod 容器模板。
- `spec.strategy.type`：滚动更新策略，常见 `RollingUpdate`。

## 常用命令

```bash
k create deployment nginx-deployment -n dev --image=nginx:1.25 --replicas=3
k scale deployment nginx-deployment -n dev --replicas=5
k set image deployment/nginx-deployment nginx=nginx:1.26 -n dev
k rollout status deployment/nginx-deployment -n dev
k rollout history deployment/nginx-deployment -n dev
k rollout undo deployment/nginx-deployment -n dev
k expose deployment nginx-deployment -n dev --port=80 --target-port=80
```

## 易错点

- `selector.matchLabels` 和 `template.metadata.labels` 不一致会创建失败。
- `set image` 里的容器名不是 Deployment 名，而是 `containers[].name`。
- `Deployment` 排障先看 Pod，再看 ReplicaSet 和 rollout 状态。
