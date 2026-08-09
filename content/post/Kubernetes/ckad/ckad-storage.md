---
title: "CKAD 复习：存储题压缩模板"
author: "陈金鑫"
description : "把 CKAD 中 emptyDir、PV、PVC、StorageClass 和 Pod 挂载压缩成少量模板"
lastmod: 2026-08-09T11:35:00+08:00
date: 2026-08-09T11:35:00+08:00
tags : [
    "kubernetes",
    "ckad",
    "PersistentVolume",
    "PersistentVolumeClaim",
    "StorageClass",
]
categories : [
    "kubernetes"
]

---

存储题记 4 个层次：`emptyDir` 是 Pod 内共享临时目录，`PV` 是集群里的真实存储，`PVC` 是命名空间里的申请单，`Pod volumes` 把 PVC 挂进去。

## 1. emptyDir：多容器共享临时目录

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: shared-volume-pod
  namespace: storage-test
spec:
  containers:
  - name: writer
    image: busybox
    command: ["sh", "-c", "while true; do date >> /data/app.log; sleep 5; done"]
    volumeMounts:
    - name: data
      mountPath: /data
  - name: reader
    image: busybox
    command: ["sh", "-c", "tail -f /data/app.log"]
    volumeMounts:
    - name: data
      mountPath: /data
  volumes:
  - name: data
    emptyDir: {}
```

## 2. PV：集群级真实存储

hostPath 类型 PV 常用于模拟题。

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

## 3. StorageClass：动态或延迟绑定策略

无动态 provisioner 的本地模拟题常用 `kubernetes.io/no-provisioner`。

```yaml
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: fast-storage
provisioner: kubernetes.io/no-provisioner
volumeBindingMode: WaitForFirstConsumer
```

## 4. PVC：命名空间里的申请单

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

检查绑定：

```bash
k get pv
k get pvc -n storage-test
k describe pvc pvc-app -n storage-test
```

## 5. Pod 挂载 PVC

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

## 6. StatefulApp 题的最小思路

如果题目要 StatefulSet，先抓 3 个关键字段：`serviceName`、`volumeClaimTemplates`、稳定副本名。

```yaml
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: web
  namespace: state
spec:
  serviceName: web
  replicas: 2
  selector:
    matchLabels:
      app: web
  template:
    metadata:
      labels:
        app: web
    spec:
      containers:
      - name: nginx
        image: nginx
        volumeMounts:
        - name: data
          mountPath: /usr/share/nginx/html
  volumeClaimTemplates:
  - metadata:
      name: data
    spec:
      accessModes: ["ReadWriteOnce"]
      resources:
        requests:
          storage: 500Mi
```

## 考场压缩记忆

- `emptyDir`：Pod 生命周期内临时共享。
- `PV`：集群级，写容量、访问模式、回收策略、后端类型。
- `PVC`：命名空间级，写申请容量、访问模式、StorageClass。
- `Pod`：通过 `volumes.persistentVolumeClaim.claimName` 使用 PVC。
- 绑定失败优先查 `storageClassName`、容量、accessModes。