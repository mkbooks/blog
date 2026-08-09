---
title: "CKAD 常用资源：ConfigMap"
author: "陈金鑫"
description : "ConfigMap 的 YAML 模板和 CKAD 常考字段解析"
lastmod: 2026-08-09T12:11:00+08:00
date: 2026-08-09T12:11:00+08:00
tags : ["kubernetes", "ckad", "ConfigMap"]
categories : ["kubernetes"]

---

`ConfigMap` 保存非敏感配置。CKAD 常考创建 ConfigMap，并让 Pod 通过环境变量或文件挂载使用。

## YAML 模板

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: app-config
  namespace: configuration
data:
  APP_ENV: production
  LOG_LEVEL: info
  app.conf: |
    server.port=8080
    feature.enabled=true
```

## Pod 使用模板

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: config-pod
  namespace: configuration
spec:
  containers:
  - name: app
    image: nginx
    envFrom:
    - configMapRef:
        name: app-config
    volumeMounts:
    - name: config
      mountPath: /etc/app
  volumes:
  - name: config
    configMap:
      name: app-config
```

## 常考字段解析

- `data`：键值都按字符串处理。
- `envFrom.configMapRef.name`：把 ConfigMap 所有 key 注入为环境变量。
- `env[].valueFrom.configMapKeyRef`：只引用一个 key。
- `volumes[].configMap.name`：把 ConfigMap 挂载成文件。

## 常用命令

```bash
k create configmap app-config -n configuration --from-literal=APP_ENV=production --from-literal=LOG_LEVEL=info
k create configmap app-config -n configuration --from-file=app.conf
k describe cm app-config -n configuration
k get cm app-config -n configuration -o yaml
```

## 易错点

- ConfigMap 不适合保存密码，密码用 Secret。
- 通过 volume 挂载时，每个 key 会变成一个文件名。
