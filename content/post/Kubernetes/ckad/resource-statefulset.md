---
title: "CKAD 常用资源：StatefulSet"
author: "陈金鑫"
description : "StatefulSet 的 YAML 模板和 CKAD 常考字段解析"
lastmod: 2026-08-09T12:09:00+08:00
date: 2026-08-09T12:09:00+08:00
tags : ["kubernetes", "ckad", "StatefulSet"]
categories : ["kubernetes"]

---

`StatefulSet` 用于有稳定网络标识和稳定存储的应用。CKAD 出现频率不如 Deployment，但存储综合题可能会考。

## YAML 模板

```yaml
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: web
  namespace: state
spec:
  serviceName: web
  replicas: 2
  selector:
    matchLabels:
      app: web
  template:
    metadata:
      labels:
        app: web
    spec:
      containers:
      - name: nginx
        image: nginx
        ports:
        - containerPort: 80
        volumeMounts:
        - name: data
          mountPath: /usr/share/nginx/html
  volumeClaimTemplates:
  - metadata:
      name: data
    spec:
      accessModes: ["ReadWriteOnce"]
      resources:
        requests:
          storage: 500Mi
```

## 常考字段解析

- `spec.serviceName`：关联 headless Service 名称，用于稳定 DNS。
- `spec.replicas`：副本数，Pod 名称会是 `web-0`、`web-1`。
- `spec.selector.matchLabels`：必须匹配 Pod 模板标签。
- `volumeClaimTemplates`：为每个 Pod 自动创建独立 PVC。
- `volumeMounts[].name`：要匹配 `volumeClaimTemplates[].metadata.name`。

## 常用命令

```bash
k get statefulset,pod,pvc -n state
k scale statefulset web -n state --replicas=3
k describe statefulset web -n state
k rollout status statefulset/web -n state
```

## 易错点

- StatefulSet 通常需要一个同名或指定名的 headless Service。
- 删除 StatefulSet 不一定删除 PVC，存储可能会保留。
