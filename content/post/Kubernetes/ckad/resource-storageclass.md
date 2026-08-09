---
title: "CKAD 常用资源：StorageClass"
author: "陈金鑫"
description : "StorageClass 的 YAML 模板和 CKAD 常考字段解析"
lastmod: 2026-08-09T12:22:00+08:00
date: 2026-08-09T12:22:00+08:00
tags : ["kubernetes", "ckad", "StorageClass"]
categories : ["kubernetes"]

---

`StorageClass` 描述存储供应方式。CKAD 常考 `kubernetes.io/no-provisioner` 和 `WaitForFirstConsumer`。

## YAML 模板

```yaml
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: fast-storage
provisioner: kubernetes.io/no-provisioner
volumeBindingMode: WaitForFirstConsumer
reclaimPolicy: Retain
```

## 常考字段解析

- `provisioner`：供应器，静态本地存储常用 `kubernetes.io/no-provisioner`。
- `volumeBindingMode`：绑定模式，`WaitForFirstConsumer` 会等 Pod 调度时再绑定。
- `reclaimPolicy`：动态创建 PV 的回收策略。
- `allowVolumeExpansion`：是否允许扩容，题目要求时再加。

## 常用命令

```bash
k get sc
k describe sc fast-storage
k apply -f storageclass.yaml
```

## 易错点

- StorageClass 是集群级资源，不能写 namespace。
- PVC 的 `storageClassName` 必须和 StorageClass 名称一致。
