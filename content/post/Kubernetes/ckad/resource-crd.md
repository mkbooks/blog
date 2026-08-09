---
title: "CKAD 常用资源：CustomResourceDefinition"
author: "陈金鑫"
description : "CRD 的 YAML 模板和 CKAD 常考字段解析"
lastmod: 2026-08-09T12:26:00+08:00
date: 2026-08-09T12:26:00+08:00
tags : ["kubernetes", "ckad", "CRD"]
categories : ["kubernetes"]

---

`CustomResourceDefinition` 简称 CRD，用来扩展 Kubernetes API。CKAD 偶尔考创建简单 CRD，重点是 group、names、version、schema。

## YAML 模板

```yaml
apiVersion: apiextensions.k8s.io/v1
kind: CustomResourceDefinition
metadata:
  name: backups.data.example.com
spec:
  group: data.example.com
  scope: Namespaced
  names:
    plural: backups
    singular: backup
    kind: Backup
    shortNames:
    - bkp
  versions:
  - name: v1alpha1
    served: true
    storage: true
    schema:
      openAPIV3Schema:
        type: object
        properties:
          spec:
            type: object
            properties:
              source:
                type: string
              destination:
                type: string
```

## 自定义资源示例

```yaml
apiVersion: data.example.com/v1alpha1
kind: Backup
metadata:
  name: daily-backup
  namespace: default
spec:
  source: /data
  destination: s3://bucket/path
```

## 常考字段解析

- `metadata.name`：必须是 `<plural>.<group>`。
- `spec.group`：API group。
- `spec.scope`：`Namespaced` 或 `Cluster`。
- `names.plural`：资源复数名，kubectl 查询使用。
- `names.kind`：资源 Kind。
- `versions[].name`：版本名。
- `versions[].served`：是否提供该版本 API。
- `versions[].storage`：是否作为存储版本。
- `openAPIV3Schema`：字段结构校验。

## 常用命令

```bash
k apply -f crd.yaml
k get crd backups.data.example.com
k api-resources | grep -i backup
k get backups -A
```

## 易错点

- CRD 是集群级资源，不写 namespace。
- `metadata.name` 要和 `plural/group` 对上。
k get backups -A
```

## 易错点

- CRD 是集群级资源，不能写 namespace。
- `metadata.name` 必须和 `plural.group` 一致。