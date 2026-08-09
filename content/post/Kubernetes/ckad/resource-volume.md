---
title: "CKAD 常用资源：Volume"
author: "陈金鑫"
description : "Pod Volume 的 YAML 模板和 CKAD 常考字段解析"
lastmod: 2026-08-09T12:23:00+08:00
date: 2026-08-09T12:23:00+08:00
tags : ["kubernetes", "ckad", "Volume"]
categories : ["kubernetes"]

---

`Volume` 不是独立 API 资源，而是 Pod 里的字段。CKAD 常考 `emptyDir`、`configMap`、`secret`、`persistentVolumeClaim`。

## YAML 模板

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: volume-pod
  namespace: workloads
spec:
  containers:
  - name: app
    image: busybox
    command: ["sh", "-c", "sleep 3600"]
    volumeMounts:
    - name: cache
      mountPath: /cache
    - name: config
      mountPath: /etc/config
    - name: secret
      mountPath: /etc/secret
      readOnly: true
    - name: data
      mountPath: /data
  volumes:
  - name: cache
    emptyDir: {}
  - name: config
    configMap:
      name: app-config
  - name: secret
    secret:
      secretName: app-secret
  - name: data
    persistentVolumeClaim:
      claimName: pvc-app
```

## 常考字段解析

- `volumeMounts[].name`：必须匹配 `volumes[].name`。
- `volumeMounts[].mountPath`：容器内挂载路径。
- `volumeMounts[].readOnly`：只读挂载，Secret 常用。
- `emptyDir`：Pod 生命周期内临时目录，多容器共享。
- `configMap.name`：挂载 ConfigMap 为文件。
- `secret.secretName`：挂载 Secret 为文件。
- `persistentVolumeClaim.claimName`：挂载 PVC。

## 常用命令

```bash
k describe pod volume-pod -n workloads
k exec -it volume-pod -n workloads -- ls -l /etc/config
k exec -it volume-pod -n workloads -- cat /etc/secret/password
```

## 易错点

- `volumeMounts` 在容器下，`volumes` 在 Pod spec 下。
- ConfigMap/Secret/PVC 必须和 Pod 在同一 namespace。
