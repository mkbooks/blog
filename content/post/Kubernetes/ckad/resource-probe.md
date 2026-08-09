---
title: "CKAD 常用字段：Probe"
author: "陈金鑫"
description : "Liveness、Readiness、Startup Probe 的 YAML 模板和 CKAD 常考字段解析"
lastmod: 2026-08-09T12:24:00+08:00
date: 2026-08-09T12:24:00+08:00
tags : ["kubernetes", "ckad", "Probe"]
categories : ["kubernetes"]

---

`Probe` 是容器字段，不是独立资源。CKAD 常考 HTTP、TCP、exec 三种探针，以及 liveness/readiness 的区别。

## YAML 模板

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
    livenessProbe:
      httpGet:
        path: /healthz
        port: 80
      initialDelaySeconds: 10
      periodSeconds: 15
      failureThreshold: 3
    readinessProbe:
      tcpSocket:
        port: 80
      periodSeconds: 10
    startupProbe:
      exec:
        command: ["sh", "-c", "test -f /tmp/started"]
      failureThreshold: 30
      periodSeconds: 5
```

## 常考字段解析

- `livenessProbe`：判断容器是否活着，失败会重启容器。
- `readinessProbe`：判断是否可以接流量，失败会从 Service endpoints 移除。
- `startupProbe`：给慢启动应用更多启动时间，成功前会屏蔽其他探针。
- `httpGet.path/port`：HTTP 探测路径和端口。
- `tcpSocket.port`：只检查端口是否可连接。
- `exec.command`：在容器内执行命令。
- `periodSeconds`：检查间隔。
- `failureThreshold`：失败多少次后判定失败。

## 常用命令

```bash
k describe pod health-pod -n workloads
k get endpoints -n workloads
k logs health-pod -n workloads
```

## 易错点

- liveness 失败会重启，readiness 失败不会重启。
- `port` 可以写数字，也可以写容器端口名。
