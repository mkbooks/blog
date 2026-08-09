---
title: "CKAD 常用资源：DaemonSet"
author: "陈金鑫"
description : "DaemonSet 的 YAML 模板和 CKAD 常考字段解析"
lastmod: 2026-08-09T12:10:00+08:00
date: 2026-08-09T12:10:00+08:00
tags : ["kubernetes", "ckad", "DaemonSet"]
categories : ["kubernetes"]

---

`DaemonSet` 保证每个匹配节点上运行一个 Pod，常用于日志、监控、节点代理。CKAD 不算最高频，但属于常见工作负载资源。

## YAML 模板

```yaml
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: node-logger
  namespace: kube-system
spec:
  selector:
    matchLabels:
      app: node-logger
  template:
    metadata:
      labels:
        app: node-logger
    spec:
      containers:
      - name: logger
        image: busybox
        command: ["sh", "-c", "while true; do date; sleep 30; done"]
```

## 常考字段解析

- `spec.selector.matchLabels`：选择 DaemonSet 管理的 Pod。
- `spec.template.metadata.labels`：必须匹配 selector。
- `spec.template.spec.nodeSelector`：限制只在部分节点运行。
- `spec.template.spec.tolerations`：允许调度到带污点的节点。

## 常用命令

```bash
k get daemonset -A
k describe daemonset node-logger -n kube-system
k rollout status daemonset/node-logger -n kube-system
k get pod -n kube-system -l app=node-logger -o wide
```

## 易错点

- DaemonSet 不写 `replicas`，副本数由节点数量决定。
- selector 和 template labels 仍然必须一致。
