---
title: "CKAD 常用资源：Secret"
author: "陈金鑫"
description : "Secret 的 YAML 模板和 CKAD 常考字段解析"
lastmod: 2026-08-09T12:12:00+08:00
date: 2026-08-09T12:12:00+08:00
tags : ["kubernetes", "ckad", "Secret"]
categories : ["kubernetes"]

---

`Secret` 保存敏感配置。CKAD 常考 generic Secret、环境变量引用、volume 挂载。

## YAML 模板

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: db-credentials
  namespace: configuration
type: Opaque
stringData:
  username: admin
  password: securepass
```

## Pod 使用模板

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: secure-pod
  namespace: configuration
spec:
  containers:
  - name: mysql
    image: mysql:5.7
    env:
    - name: DB_USER
      valueFrom:
        secretKeyRef:
          name: db-credentials
          key: username
    - name: DB_PASSWORD
      valueFrom:
        secretKeyRef:
          name: db-credentials
          key: password
    volumeMounts:
    - name: db-secret
      mountPath: /etc/db-secret
      readOnly: true
  volumes:
  - name: db-secret
    secret:
      secretName: db-credentials
```

## 常考字段解析

- `type: Opaque`：通用 Secret 类型。
- `stringData`：明文写入，apiserver 会转成 `data` 的 base64。
- `data`：需要自己写 base64 编码后的值。
- `secretKeyRef.name/key`：引用指定 Secret 的指定 key。
- `volumes[].secret.secretName`：挂载 Secret 为文件。

## 常用命令

```bash
k create secret generic db-credentials -n configuration --from-literal=username=admin --from-literal=password=securepass
k describe secret db-credentials -n configuration
k get secret db-credentials -n configuration -o yaml
k get secret db-credentials -n configuration -o jsonpath='{.data.username}' | base64 -d
```

## 易错点

- YAML 中 `data` 必须 base64；想写明文用 `stringData`。
- Secret 挂载成 volume 时默认只读。
