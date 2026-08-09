---
title: "CKAD 常用资源：Ingress"
author: "陈金鑫"
description : "Ingress 的 YAML 模板和 CKAD 常考字段解析"
lastmod: 2026-08-09T12:18:00+08:00
date: 2026-08-09T12:18:00+08:00
tags : ["kubernetes", "ckad", "Ingress"]
categories : ["kubernetes"]

---

`Ingress` 提供 HTTP/HTTPS 七层路由。CKAD 常考 host、path、pathType、backend service。

## YAML 模板

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

## 常考字段解析

- `spec.rules[].host`：域名匹配。
- `paths[].path`：URL 路径。
- `paths[].pathType`：常用 `Prefix` 或 `Exact`。
- `backend.service.name`：后端 Service 名称。
- `backend.service.port.number`：后端 Service 端口，不是容器端口。

## 常用命令

```bash
k create ingress api-ingress -n networking --rule='api.example.com/=api-service:80'
k get ingress -n networking
k describe ingress api-ingress -n networking
```

## 易错点

- Ingress 后端指向 Service，不直接指向 Pod。
- `port.number` 是 Service 的 `port`。
- 集群需要 Ingress Controller，资源存在不代表外部一定可访问。
