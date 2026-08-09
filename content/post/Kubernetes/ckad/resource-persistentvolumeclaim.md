---
title: "CKAD 常用资源：PersistentVolumeClaim"
author: "陈金鑫"
description : "PersistentVolumeClaim 的 YAML 模板和 CKAD 常考字段解析"
lastmod: 2026-08-09T12:21:00+08:00
date: 2026-08-09T12:21:00+08:00
tags : ["kubernetes", "ckad", "PersistentVolumeClaim"]
categories : ["kubernetes"]

---

`PersistentVolumeClaim` 简称 PVC，是命名空间里的存储申请。Pod 通常通过 PVC 使用 PV。

## YAML 模板

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pvc-app
  namespace: storage-test
spec:
  accessModes:
  - ReadWriteOnce
  storageClassName: fast-storage
  resources:
    requests:
      storage: 500Mi
```

## Pod 使用模板

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: pvc-pod
  namespace: storage-test
spec:
  containers:
  - name: app
    image: busybox
    command: ["sh", "-c", "echo hello > /data/hello.txt && sleep 3600"]
    volumeMounts:
    - name: app-data
      mountPath: /data
  volumes:
  - name: app-data
    persistentVolumeClaim:
      claimName: pvc-app
```

## 常考字段解析

- `spec.accessModes`：要和 PV 支持的模式兼容。
- `spec.storageClassName`：指定 StorageClass，也可为空字符串禁用动态供应。
- `resources.requests.storage`：申请容量。
- `volumes[].persistentVolumeClaim.claimName`：Pod 引用 PVC 名称。

## 常用命令

```bash
k get pvc -n storage-test
k describe pvc pvc-app -n storage-test
k get pv
```

## 易错点

- PVC 是 namespace 级资源，Pod 必须和 PVC 在同一 namespace。
- PVC 申请容量不能大于可绑定 PV 的容量。
