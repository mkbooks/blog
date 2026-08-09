---
title: "CKAD 常用资源：PersistentVolume"
author: "陈金鑫"
description : "PersistentVolume 的 YAML 模板和 CKAD 常考字段解析"
lastmod: 2026-08-09T12:20:00+08:00
date: 2026-08-09T12:20:00+08:00
tags : ["kubernetes", "ckad", "PersistentVolume"]
categories : ["kubernetes"]

---

`PersistentVolume` 简称 PV，是集群级存储资源。CKAD 常考 hostPath PV、容量、访问模式、回收策略。

## YAML 模板

```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv-storage
spec:
  capacity:
    storage: 1Gi
  accessModes:
  - ReadWriteOnce
  persistentVolumeReclaimPolicy: Retain
  storageClassName: fast-storage
  hostPath:
    path: /mnt/data
```

## 常考字段解析

- `spec.capacity.storage`：PV 容量。
- `spec.accessModes`：访问模式，常见 `ReadWriteOnce`。
- `persistentVolumeReclaimPolicy`：回收策略，常见 `Retain`、`Delete`。
- `storageClassName`：绑定 StorageClass，需和 PVC 对应。
- `hostPath.path`：节点本地路径，模拟题常用。

## 常用命令

```bash
k get pv
k describe pv pv-storage
k apply -f pv.yaml
```

## 易错点

- PV 是集群级资源，不能写 namespace。
- PVC 绑定失败时查容量、accessModes、storageClassName 是否匹配。
