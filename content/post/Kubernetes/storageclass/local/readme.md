---
title: "使用 NFS 创建 StorageClass"           # 文章标题
author: "陈金鑫"              # 文章作者
description : "使用 NFS 创建 StorageClass"    # 文章描述信息
lastmod: 2022-11-16T20:35:00+08:00         # 文章修改日期
date: 2022-11-16T20:35:00+08:00
tags : [                    # 文章所属标签
    "StorageClass",
    "kubernetes",
]
categories : [              # 文章所属标签
    "kubernetes"
]

---
# 创建目录
```
mkdir -p ~/yamls/storageclass/local/test
cd ~/yamls/storageclass/local
```
# 创建 yaml 文件
- StorageClass.yaml
```
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  annotations:
    cas.openebs.io/config: |
      - name: StorageType
        value: "hostpath"
      - name: BasePath
        value: "/var/openebs/local/"
    kubectl.kubernetes.io/last-applied-configuration: |
      {"apiVersion":"storage.k8s.io/v1","kind":"StorageClass","metadata":{"annotations":{"cas.openebs.io/config":"- name: StorageType\n  value: \"hostpath\"\n- name: BasePath\n  value: \"/var/openebs/local/\"\n","openebs.io/cas-type":"local","storageclass.beta.kubernetes.io/is-default-class":"true","storageclass.kubesphere.io/supported-access-modes":"[\"ReadWriteOnce\"]"},"name":"local"},"provisioner":"openebs.io/local","reclaimPolicy":"Delete","volumeBindingMode":"WaitForFirstConsumer"}
    openebs.io/cas-type: local
    storageclass.beta.kubernetes.io/is-default-class: "true"
    storageclass.kubesphere.io/supported-access-modes: '["ReadWriteOnce"]'
  creationTimestamp: "2022-11-15T14:04:07Z"
  name: local
  resourceVersion: "430"
  uid: f4c69e41-7ea3-4970-b026-8606c1ef97a5
provisioner: openebs.io/local
reclaimPolicy: Delete
volumeBindingMode: WaitForFirstConsumer
```
- test/claim.yaml
```
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: test-claim
spec:
  storageClassName: local
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: 1Mi
```
- test/pod.yaml
```
kind: Pod
apiVersion: v1
metadata:
  name: test-pod
spec:
  containers:
  - name: test-pod
    image: busybox:latest
    command:
      - "/bin/sh"
    args:
      - "-c"
      - "touch /mnt/SUCCESS && exit 0 || exit 1"   #创建一个SUCCESS文件后退出
    volumeMounts:
      - name: local-pvc
        mountPath: "/mnt"
  restartPolicy: "Never"
  volumes:
    - name: local-pvc
      persistentVolumeClaim:
        claimName: test-claim  #与PVC名称保持一致
```

# 创建
## 下载镜像
```
docker pull busybox:latest
docker pull quay.io/external_storage/nfs-client-provisioner:latest
```
## apply
```
k apply -f .
```
## 检查
```
k get sc
NAME              PROVISIONER        RECLAIMPOLICY   VOLUMEBINDINGMODE      ALLOWVOLUMEEXPANSION   AGE
local (default)   openebs.io/local   Delete          WaitForFirstConsumer   false                  2s
```

## 测试
```
k apply -f test
```
```
ls $MY_NFS_SERVER_PATH
```