---
title: "CKAD 常用资源：ClusterRole 与 ClusterRoleBinding"
author: "陈金鑫"
description : "ClusterRole 和 ClusterRoleBinding 的 YAML 模板与 CKAD 常考字段解析"
lastmod: 2026-08-09T12:15:00+08:00
date: 2026-08-09T12:15:00+08:00
tags : ["kubernetes", "ckad", "RBAC", "ClusterRole", "ClusterRoleBinding"]
categories : ["kubernetes"]

---

`ClusterRole` 定义集群级权限，`ClusterRoleBinding` 把权限绑定到整个集群范围。CKAD 常考允许某用户读取所有 Pod。

## YAML 模板

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: pod-reader
rules:
- apiGroups: [""]
  resources: ["pods"]
  verbs: ["get", "list", "watch"]
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: read-pods
subjects:
- kind: User
  name: jane
  apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: ClusterRole
  name: pod-reader
  apiGroup: rbac.authorization.k8s.io
```

## 常考字段解析

- `ClusterRole.metadata.namespace`：不能写，ClusterRole 是集群级资源。
- `ClusterRoleBinding.metadata.namespace`：不能写，ClusterRoleBinding 也是集群级资源。
- `subjects[].kind`：用户用 `User`，服务账号用 `ServiceAccount`。
- `roleRef.kind`：这里通常是 `ClusterRole`。

## 常用命令

```bash
k create clusterrole pod-reader --verb=get,list,watch --resource=pods
k create clusterrolebinding read-pods --clusterrole=pod-reader --user=jane
k auth can-i list pods --as=jane
```

## 易错点

- 只想授权某个 namespace 时，用 RoleBinding 绑定 ClusterRole 也可以限制范围。
- 集群级资源不要加 `-n`。
