---
title: "CKAD 常用工具：Helm"
author: "陈金鑫"
description : "Helm 在 CKAD 中的常用命令和 values 字段解析"
lastmod: 2026-08-09T12:27:00+08:00
date: 2026-08-09T12:27:00+08:00
tags : ["kubernetes", "ckad", "Helm"]
categories : ["kubernetes"]

---

`Helm` 不是 Kubernetes 资源，但 CKAD 可能考 chart 安装、升级、回滚、查看 release。常见题型是安装 Bitnami Nginx。

## values 示例

```yaml
replicaCount: 2
service:
  type: ClusterIP
  ports:
    http: 80
resources:
  requests:
    cpu: 100m
    memory: 128Mi
  limits:
    cpu: 200m
    memory: 256Mi
```

## 常考命令

```bash
k create ns web
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update

helm search repo bitnami/nginx
helm show values bitnami/nginx
helm install nginx bitnami/nginx -n web --set replicaCount=2
helm list -n web
helm status nginx -n web

helm upgrade nginx bitnami/nginx -n web --set replicaCount=3
helm history nginx -n web
helm rollback nginx 1 -n web
helm uninstall nginx -n web
```

## 常考字段解析

- `release name`：例如 `nginx`，是 Helm 管理实例名。
- `chart`：例如 `bitnami/nginx`，是安装包。
- `namespace`：release 安装位置，命令里用 `-n`。
- `--set key=value`：命令行覆盖 values。
- `-f values.yaml`：使用 values 文件覆盖默认值。

## 易错点

- `helm list` 默认只看当前 namespace，考试要加 `-n <ns>` 或 `-A`。
- release 名和 chart 名不是一回事。
- 修改参数用 `helm upgrade`，不是重新 `install` 同名 release。
