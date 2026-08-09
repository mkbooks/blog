---
title: "CKAD 常用资源：NetworkPolicy"
author: "陈金鑫"
description : "NetworkPolicy 的 YAML 模板和 CKAD 常考字段解析"
lastmod: 2026-08-09T12:19:00+08:00
date: 2026-08-09T12:19:00+08:00
tags : ["kubernetes", "ckad", "NetworkPolicy"]
categories : ["kubernetes"]

---

`NetworkPolicy` 控制 Pod 间网络访问。CKAD 高频题型是“只允许某些 Pod 访问某些 Pod 的某个端口”。

## YAML 模板

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-frontend
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

## 常考字段解析

- `spec.podSelector`：选择被保护的目标 Pod。
- `policyTypes`：`Ingress` 控制入站，`Egress` 控制出站。
- `ingress[].from[].podSelector`：允许哪些来源 Pod。
- `ingress[].from[].namespaceSelector`：允许哪些命名空间里的来源。
- `ports[].port`：允许访问的目标端口。

## 常用命令

```bash
k get netpol -n networking
k describe netpol allow-frontend -n networking
k get pod -n networking --show-labels
k run tmp --restart=Never --rm -i --image=busybox -- wget -O- web-service:80
```

## 易错点

- `podSelector` 是目标 Pod，不是来源 Pod。
- Pod 一旦被 NetworkPolicy 选中，未允许的流量会被拒绝。
- NetworkPolicy 是否生效取决于集群 CNI 是否支持。
