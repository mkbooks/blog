---
title: "CKAD 常用资源：Role 与 RoleBinding"
author: "陈金鑫"
description : "Role 和 RoleBinding 的 YAML 模板与 CKAD 常考字段解析"
lastmod: 2026-08-09T12:14:00+08:00
date: 2026-08-09T12:14:00+08:00
tags : ["kubernetes", "ckad", "RBAC", "Role", "RoleBinding"]
categories : ["kubernetes"]

---

`Role` 定义命名空间内权限，`RoleBinding` 把权限绑定给用户、组或 ServiceAccount。公式：先写权限，再写绑定。

## YAML 模板

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: pod-reader
  namespace: security
rules:
- apiGroups: [""]
  resources: ["pods"]
  verbs: ["get", "list", "watch"]
---
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: read-pods
  namespace: security
subjects:
- kind: ServiceAccount
  name: app-sa
  namespace: security
roleRef:
  kind: Role
  name: pod-reader
  apiGroup: rbac.authorization.k8s.io
```

## 常考字段解析

- `rules[].apiGroups`：核心资源如 Pod、Service 写空字符串 `""`。
- `rules[].resources`：资源复数名，如 `pods`、`services`。
- `rules[].verbs`：动作，如 `get`、`list`、`watch`、`create`、`delete`。
- `subjects[].kind`：`User`、`Group` 或 `ServiceAccount`。
- `roleRef`：绑定到哪个 Role，创建后不能直接修改。

## 常用命令

```bash
k create role pod-reader -n security --verb=get,list,watch --resource=pods
k create rolebinding read-pods -n security --role=pod-reader --serviceaccount=security:app-sa
k auth can-i list pods -n security --as=system:serviceaccount:security:app-sa
```

## 易错点

- Role 只在自己的 namespace 生效。
- ServiceAccount subject 需要写 namespace。
