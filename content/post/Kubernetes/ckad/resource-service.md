---
title: "CKAD 常用资源：Service"
author: "陈金鑫"
description : "Service 的 YAML 模板和 CKAD 常考字段解析"
lastmod: 2026-08-09T12:17:00+08:00
date: 2026-08-09T12:17:00+08:00
tags : ["kubernetes", "ckad", "Service"]
categories : ["kubernetes"]

---

`Service` 为一组 Pod 提供稳定访问入口。CKAD 常考 ClusterIP、NodePort、selector 排障。

## YAML 模板

```yaml
apiVersion: v1
kind: Service
metadata:
  name: web-service
  namespace: networking
spec:
  type: ClusterIP
  selector:
    app: web
  ports:
  - name: http
    protocol: TCP
    port: 80
    targetPort: 8080
```

## NodePort 模板

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

## 常考字段解析

- `spec.type`：常见 `ClusterIP`、`NodePort`、`LoadBalancer`。
- `spec.selector`：匹配 Pod labels，决定 endpoints。
- `ports[].port`：Service 暴露端口。
- `ports[].targetPort`：Pod 容器端口，可以是数字或端口名。
- `ports[].nodePort`：NodePort 类型的节点端口，通常范围 30000-32767。

## 常用命令

```bash
k expose deployment web -n networking --name=web-service --port=80 --target-port=8080
k get svc,endpoints -n networking
k describe svc web-service -n networking
k run tmp --restart=Never --rm -i --image=busybox -- wget -O- web-service:80
```

## 易错点

- Service 不通先看 `endpoints`，为空就是 selector 没匹配到 Pod。
- `port` 是访问 Service 的端口，`targetPort` 是 Pod 里的端口。
