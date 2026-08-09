---
title: "CKAD 常用资源：HorizontalPodAutoscaler"
author: "陈金鑫"
description : "HPA 的 YAML 模板和 CKAD 常考字段解析"
lastmod: 2026-08-09T12:26:00+08:00
date: 2026-08-09T12:26:00+08:00
tags : ["kubernetes", "ckad", "HPA"]
categories : ["kubernetes"]

---

`HorizontalPodAutoscaler` 简称 HPA，用于按指标自动扩缩容。CKAD 不是最高频，但命令很短，值得记。

## YAML 模板

```yaml
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: web-hpa
  namespace: workloads
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: web
  minReplicas: 2
  maxReplicas: 10
  metrics:
  - type: Resource
    resource:
      name: cpu
      target:
        type: Utilization
        averageUtilization: 60
```

## 常考字段解析

- `scaleTargetRef`：要扩缩容的目标资源，常见 Deployment。
- `minReplicas`：最小副本数。
- `maxReplicas`：最大副本数。
- `metrics[].resource.name`：指标资源，常见 `cpu`。
- `averageUtilization`：目标平均利用率百分比。

## 常用命令

```bash
k autoscale deployment web -n workloads --min=2 --max=10 --cpu-percent=60
k get hpa -n workloads
k describe hpa web-hpa -n workloads
```

## 易错点

- HPA 依赖 metrics-server；考试如果只要求创建资源，不一定需要指标真实可用。
- 被扩缩容的容器通常需要配置 CPU requests。
