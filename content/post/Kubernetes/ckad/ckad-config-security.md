---
title: "CKAD 复习：配置与安全题压缩模板"
author: "陈金鑫"
description : "把 CKAD 中 ConfigMap、Secret、ServiceAccount、RBAC、SecurityContext 压缩成少量模板"
lastmod: 2026-08-09T11:25:00+08:00
date: 2026-08-09T11:25:00+08:00
tags : [
    "kubernetes",
    "ckad",
    "ConfigMap",
    "Secret",
    "RBAC",
    "SecurityContext",
]
categories : [
    "kubernetes"
]

---

配置与安全题看起来对象多，其实只记 5 个入口：`ConfigMap`、`Secret`、`ServiceAccount`、`Role/ClusterRole`、`securityContext`。考试常考的是“创建配置，然后让 Pod 用起来”。

## 1. ConfigMap：创建后给 Pod 用

命令创建最快：

```bash
k create ns configuration

k create configmap app-config -n configuration \
  --from-literal=DB_HOST=mysql \
  --from-literal=DB_PORT=3306 \
  --from-literal=APP_ENV=production \
  --from-literal=LOG_LEVEL=info
```

作为环境变量整体注入：

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: config-pod
  namespace: configuration
spec:
  containers:
  - name: nginx
    image: nginx
    envFrom:
    - configMapRef:
        name: app-config
```

作为文件挂载：

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: config-volume-pod
  namespace: configuration
spec:
  containers:
  - name: nginx
    image: nginx
    volumeMounts:
    - name: config
      mountPath: /etc/app
  volumes:
  - name: config
    configMap:
      name: app-config
```

记忆点：`envFrom.configMapRef.name` 变环境变量，`volumes.configMap.name` 变文件。

## 2. Secret：和 ConfigMap 结构几乎一样

```bash
k create secret generic app-secret -n configuration \
  --from-literal=DB_USER=admin \
  --from-literal=DB_PASSWORD=s3cr3t
```

指定 key 映射到环境变量：

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
          name: app-secret
          key: DB_USER
    - name: DB_PASSWORD
      valueFrom:
        secretKeyRef:
          name: app-secret
          key: DB_PASSWORD
```

Secret 挂载成文件：

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: secret-volume-pod
  namespace: configuration
spec:
  containers:
  - name: busybox
    image: busybox
    command: ["sh", "-c", "cat /etc/secret/DB_USER && sleep 3600"]
    volumeMounts:
    - name: secret
      mountPath: /etc/secret
      readOnly: true
  volumes:
  - name: secret
    secret:
      secretName: app-secret
```

## 3. ServiceAccount：Pod 使用身份

```bash
k create ns security
k create serviceaccount app-sa -n security
```

Pod 绑定 ServiceAccount：

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: sa-pod
  namespace: security
spec:
  serviceAccountName: app-sa
  containers:
  - name: app
    image: nginx
```

如果题目要求“不要自动挂载 token”：

```yaml
spec:
  automountServiceAccountToken: false
```

## 4. RBAC：Role/ClusterRole + Binding

只在命名空间内授权，用 `Role` 和 `RoleBinding`：

```bash
k create role pod-reader -n security --verb=get,list,watch --resource=pods
k create rolebinding read-pods -n security --role=pod-reader --serviceaccount=security:app-sa
```

集群级资源或所有命名空间授权，用 `ClusterRole` 和 `ClusterRoleBinding`：

```bash
k create clusterrole pod-reader --verb=get,list,watch --resource=pods
k create clusterrolebinding read-pods --clusterrole=pod-reader --user=jane
```

检查权限：

```bash
k auth can-i list pods -n security --as=system:serviceaccount:security:app-sa
k auth can-i get pods --as=jane
```

## 5. SecurityContext：Pod 级和容器级

常考字段：用户 ID、禁止提权、只读根文件系统、能力控制。

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: secure-context-pod
  namespace: security
spec:
  securityContext:
    runAsNonRoot: true
    runAsUser: 1000
    fsGroup: 2000
  containers:
  - name: app
    image: nginx
    securityContext:
      allowPrivilegeEscalation: false
      readOnlyRootFilesystem: true
      capabilities:
        drop: ["ALL"]
```

## 高频检查命令

```bash
k get cm,secret,sa,role,rolebinding -n <ns>
k describe cm app-config -n <ns>
k describe secret app-secret -n <ns>
k get pod <pod> -n <ns> -o yaml | grep -A20 -E 'env|volume|securityContext|serviceAccountName'
k auth can-i <verb> <resource> -n <ns> --as=<user-or-sa>
```

## 考场压缩记忆

- ConfigMap 和 Secret：创建方式不同，Pod 引用结构类似。
- `envFrom`：全部 key 变环境变量。
- `valueFrom.secretKeyRef/configMapKeyRef`：单个 key 变指定环境变量。
- `volumes.configMap/secret`：配置变文件。
- RBAC 固定公式：`Role/ClusterRole` 定义权限，`Binding` 绑定用户或 ServiceAccount。