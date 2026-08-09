---
title: "CKAD 常用字段：SecurityContext"
author: "陈金鑫"
description : "SecurityContext 的 YAML 模板和 CKAD 常考字段解析"
lastmod: 2026-08-09T12:25:00+08:00
date: 2026-08-09T12:25:00+08:00
tags : ["kubernetes", "ckad", "SecurityContext"]
categories : ["kubernetes"]

---

`SecurityContext` 是 Pod 或 Container 的安全字段。CKAD 常考非 root、禁止提权、只读根文件系统、capabilities。

## YAML 模板

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: secure-pod
  namespace: security
spec:
  securityContext:
    runAsNonRoot: true
    runAsUser: 1000
    runAsGroup: 3000
    fsGroup: 2000
  containers:
  - name: app
    image: nginx
    securityContext:
      allowPrivilegeEscalation: false
      readOnlyRootFilesystem: true
      capabilities:
        drop: ["ALL"]
        add: ["NET_BIND_SERVICE"]
```

## 常考字段解析

- Pod 级 `securityContext`：影响 Pod 内所有容器的默认安全上下文。
- Container 级 `securityContext`：只影响单个容器，优先级更高。
- `runAsNonRoot`：要求非 root 运行。
- `runAsUser/runAsGroup`：指定用户和组 ID。
- `fsGroup`：挂载卷文件所属组。
- `allowPrivilegeEscalation`：是否允许提权。
- `readOnlyRootFilesystem`：根文件系统只读。
- `capabilities.drop/add`：删除或增加 Linux capability。

## 常用命令

```bash
k get pod secure-pod -n security -o yaml | grep -A20 securityContext
k exec secure-pod -n security -- id
k describe pod secure-pod -n security
```

## 易错点

- Pod 级和容器级都能写 `securityContext`，位置不同。
- `readOnlyRootFilesystem: true` 可能导致应用写临时文件失败，需要配合 volume。
