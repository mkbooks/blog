---
title: "CKAD 常用资源：Namespace"
author: "陈金鑫"
description : "Namespace 的 YAML 模板和 CKAD 常考字段解析"
lastmod: 2026-08-09T12:00:00+08:00
date: 2026-08-09T12:00:00+08:00
tags : [
    "kubernetes",
    "ckad",
    "Namespace",
]
categories : [
    "kubernetes"
]

---

`Namespace` 用来隔离命名空间级资源。CKAD 里常见要求是创建命名空间、在指定命名空间创建资源、列出所有命名空间并写入文件。

## YAML 模板

```yaml
apiVersion: v1
kind: Namespace
metadata:
  name: dev
  labels:
    env: dev
```

## 常考字段解析

- `metadata.name`：命名空间名称，很多题后续资源都必须放到这里。
- `metadata.labels`：给 `NetworkPolicy`、配额或选择器使用，考试偶尔要求补标签。

## 常用命令

```bash
k create ns dev
k get ns
k get ns > /opt/course/1/namespaces
k config set-context --current --namespace=dev
```

## 易错点

- `Namespace` 本身不是 namespaced 资源，不能写 `metadata.namespace`。
- 创建资源时忘记 `-n <namespace>` 是 CKAD 高频失分点。
