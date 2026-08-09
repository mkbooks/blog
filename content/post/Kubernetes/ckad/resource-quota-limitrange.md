---
title: "CKAD 常用资源：ResourceQuota 与 LimitRange"
author: "陈金鑫"
description : "ResourceQuota 和 LimitRange 的 YAML 模板与 CKAD 常考字段解析"
lastmod: 2026-08-09T12:16:00+08:00
date: 2026-08-09T12:16:00+08:00
tags : ["kubernetes", "ckad", "ResourceQuota", "LimitRange"]
categories : ["kubernetes"]

---

`ResourceQuota` 限制命名空间总量，`LimitRange` 限制单个 Pod 或 Container 的默认值和范围。CKAD 出现频率不高，但属于常用资源。

## YAML 模板

```yaml
apiVersion: v1
kind: ResourceQuota
metadata:
  name: compute-quota
  namespace: dev
spec:
  hard:
    requests.cpu: "1"
    requests.memory: 1Gi
    limits.cpu: "2"
    limits.memory: 2Gi
    pods: "10"
---
apiVersion: v1
kind: LimitRange
metadata:
  name: container-limits
  namespace: dev
spec:
  limits:
  - type: Container
    default:
      cpu: 200m
      memory: 256Mi
    defaultRequest:
      cpu: 100m
      memory: 128Mi
    max:
      cpu: "1"
      memory: 1Gi
    min:
      cpu: 50m
      memory: 64Mi
```

## 常考字段解析

- `ResourceQuota.spec.hard`：命名空间资源硬限制。
- `requests.cpu/memory`：所有 Pod requests 总和限制。
- `limits.cpu/memory`：所有 Pod limits 总和限制。
- `LimitRange.spec.limits[].type`：常用 `Container`。
- `default`：容器未写 limits 时默认值。
- `defaultRequest`：容器未写 requests 时默认值。

## 常用命令

```bash
k get quota,limitrange -n dev
k describe quota compute-quota -n dev
k describe limitrange container-limits -n dev
```

## 易错点

- `ResourceQuota` 是 namespace 级资源，必须放在目标 namespace。
- 开了 ResourceQuota 后，Pod 不写 requests/limits 可能被拒绝。
