---
title: "CKAD 常用资源：ServiceAccount"
author: "陈金鑫"
description : "ServiceAccount 的 YAML 模板和 CKAD 常考字段解析"
lastmod: 2026-08-09T12:13:00+08:00
date: 2026-08-09T12:13:00+08:00
tags : ["kubernetes", "ckad", "ServiceAccount"]
categories : ["kubernetes"]

---

`ServiceAccount` 是 Pod 在集群内访问 Kubernetes API 时使用的身份。CKAD 常和 RBAC、Secret、Pod spec 一起考。

## YAML 模板

```yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: app-sa
  namespace: security
automountServiceAccountToken: false
```

## Pod 使用模板

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: sa-pod
  namespace: security
spec:
  serviceAccountName: app-sa
  containers:
  - name: nginx
    image: nginx
```

## 常考字段解析

- `metadata.name`：Pod 通过 `serviceAccountName` 引用。
- `automountServiceAccountToken`：是否自动挂载 API token。
- `spec.serviceAccountName`：Pod 字段，不是 ServiceAccount 字段。

## 常用命令

```bash
k create sa app-sa -n security
k get sa -n security
k describe sa app-sa -n security
k auth can-i list pods -n security --as=system:serviceaccount:security:app-sa
```

## 易错点

- ServiceAccount 自身不代表权限，权限来自 RoleBinding 或 ClusterRoleBinding。
- `serviceAccountName` 写在 Pod 的 `spec` 下。
