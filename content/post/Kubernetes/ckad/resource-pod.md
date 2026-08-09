---
title: "CKAD 常用资源：Pod"
author: "陈金鑫"
description : "Pod 的 YAML 模板和 CKAD 常考字段解析"
lastmod: 2026-08-09T12:05:00+08:00
date: 2026-08-09T12:05:00+08:00
tags : ["kubernetes", "ckad", "Pod"]
categories : ["kubernetes"]

---

`Pod` 是 CKAD 最核心资源。大多数题不是单独考 Pod，就是把 Pod 模板嵌在 `Deployment`、`Job`、`CronJob`、`StatefulSet` 里。

## YAML 模板

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx-pod
  namespace: dev
  labels:
    app: nginx
    tier: web
spec:
  restartPolicy: Always
  containers:
  - name: nginx
    image: nginx:1.25
    imagePullPolicy: IfNotPresent
    ports:
    - containerPort: 80
    env:
    - name: APP_ENV
      value: prod
    resources:
      requests:
        cpu: 100m
        memory: 128Mi
      limits:
        cpu: 200m
        memory: 256Mi
    livenessProbe:
      httpGet:
        path: /
        port: 80
      periodSeconds: 10
    readinessProbe:
      tcpSocket:
        port: 80
      periodSeconds: 5
```

## 常考字段解析

- `metadata.namespace`：资源所在命名空间，命令里常用 `-n` 指定。
- `metadata.labels`：给 `Service`、`NetworkPolicy`、查询命令选择 Pod。
- `spec.containers[].name`：容器名，`logs -c`、`exec -c`、`set image` 都会用到。
- `spec.containers[].image`：镜像名，排障题常考镜像错误。
- `spec.containers[].ports[].containerPort`：容器监听端口，常和 Service 的 `targetPort` 对应。
- `spec.restartPolicy`：Pod 默认 `Always`；Job/CronJob 模板里常用 `Never` 或 `OnFailure`。
- `resources.requests/limits`：调度和限制资源，常考 CPU、内存格式。
- `livenessProbe`：存活检查，失败会重启容器。
- `readinessProbe`：就绪检查，失败时不会接入 Service endpoints。

## 常用命令

```bash
k run nginx-pod --image=nginx --restart=Never -n dev
k run nginx-pod --image=nginx --restart=Never --dry-run=client -o yaml > pod.yaml
k get pod -n dev --show-labels
k describe pod nginx-pod -n dev
k logs nginx-pod -n dev
k exec -it nginx-pod -n dev -- sh
```

## 易错点

- 单独 Pod 使用 `--restart=Never` 生成模板；不加时容易变成默认行为混淆。
- 多容器 Pod 查日志要加 `-c <container>`。
- `readinessProbe` 失败会导致 Service 没有可用 endpoint。
