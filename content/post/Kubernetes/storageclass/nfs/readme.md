---
title: "使用 NFS 创建 StorageClass"           # 文章标题
author: "陈金鑫"              # 文章作者
description : "使用 NFS 创建 StorageClass"    # 文章描述信息
lastmod: 2022-11-16T20:46:00+08:00         # 文章修改日期
date: 2022-11-16T20:46:00+08:00
tags : [                    # 文章所属标签
    "NFS",
    "StorageClass",
    "kubernetes",
]
categories : [              # 文章所属标签
    "kubernetes"
]

---
参考: https://github.com/kubernetes-retired/external-storage/tree/master/nfs-client

# 创建目录
```
mkdir -p ~/yamls/storageclass/nfs/test
cd ~/yamls/storageclass/nfs
```
# 创建 yaml 文件
- deployment.yaml
```
# https://github.com/kubernetes-sigs/nfs-subdir-external-provisioner
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nfs-client-provisioner
  labels:
    app: nfs-client-provisioner
  # replace with namespace where provisioner is deployed
  namespace: default  # 与RBAC文件中的namespace保持一致
spec:
  replicas: 1
  strategy:
    type: Recreate
  selector:
    matchLabels:
      app: nfs-client-provisioner
  template:
    metadata:
      labels:
        app: nfs-client-provisioner
    spec:
      serviceAccountName: nfs-client-provisioner
      containers:
        - name: nfs-client-provisioner
        #  image: k8s.gcr.io/sig-storage/nfs-subdir-external-provisioner:v4.0.2
          image: quay.io/external_storage/nfs-client-provisioner:latest
          imagePullPolicy: IfNotPresent
          volumeMounts:
            - name: nfs-client-root
              mountPath: /persistentvolumes
          env:
            - name: PROVISIONER_NAME
              value: k8s-sigs.io/nfs-subdir-external-provisioner  #provisioner名称,确保该名称与 class.yaml文件中的provisioner名称保持一致
            - name: NFS_SERVER
              value: MY_NFS_SERVER_HOST        #NFS Server IP地址
            - name: NFS_PATH
              value: MY_NFS_SERVER_PATH        #NFS挂载卷
      volumes:
        - name: nfs-client-root
          nfs:
            server: MY_NFS_SERVER_HOST         #NFS Server IP地址
            path: MY_NFS_SERVER_PATH           #NFS 挂载卷
```
- class.yaml
```
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: managed-nfs-storage
mountOptions:
  - noresvport
#     - vers=3
provisioner: k8s-sigs.io/nfs-subdir-external-provisioner # or choose another name, must match deployment's env PROVISIONER_NAME'
parameters:
  pathPattern: MY_NFS_SERVER_PATH # waits for nfs.io/storage-path annotation, if not specified will accept as empty string.
  onDelete: delete
  archiveOnDelete: "false"
# allowVolumeExpansion: true   #增加该字段表示允许动态扩容，NFS 暂时不支持
```
- rbac.yaml
```
apiVersion: v1
kind: ServiceAccount
metadata:
  name: nfs-client-provisioner
  # replace with namespace where provisioner is deployed
  namespace: default
---
kind: ClusterRole
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: nfs-client-provisioner-runner
rules:
  - apiGroups: [""]
    resources: ["nodes"]
    verbs: ["get", "list", "watch"]
  - apiGroups: [""]
    resources: ["persistentvolumes"]
    verbs: ["get", "list", "watch", "create", "delete"]
  - apiGroups: [""]
    resources: ["persistentvolumeclaims"]
    verbs: ["get", "list", "watch", "update"]
  - apiGroups: ["storage.k8s.io"]
    resources: ["storageclasses"]
    verbs: ["get", "list", "watch"]
  - apiGroups: [""]
    resources: ["events"]
    verbs: ["create", "update", "patch"]
---
kind: ClusterRoleBinding
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: run-nfs-client-provisioner
subjects:
  - kind: ServiceAccount
    name: nfs-client-provisioner
    # replace with namespace where provisioner is deployed
    namespace: default
roleRef:
  kind: ClusterRole
  name: nfs-client-provisioner-runner
  apiGroup: rbac.authorization.k8s.io
---
kind: Role
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: leader-locking-nfs-client-provisioner
  # replace with namespace where provisioner is deployed
  namespace: default
rules:
  - apiGroups: [""]
    resources: ["endpoints"]
    verbs: ["get", "list", "watch", "create", "update", "patch"]
---
kind: RoleBinding
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: leader-locking-nfs-client-provisioner
  # replace with namespace where provisioner is deployed
  namespace: default
subjects:
  - kind: ServiceAccount
    name: nfs-client-provisioner
    # replace with namespace where provisioner is deployed
    namespace: default
roleRef:
  kind: Role
  name: leader-locking-nfs-client-provisioner
  apiGroup: rbac.authorization.k8s.io
```
- test/claim.yaml
```
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: test-claim
spec:
  storageClassName: managed-nfs-storage
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
      - name: nfs-pvc
        mountPath: "/mnt"
  restartPolicy: "Never"
  volumes:
    - name: nfs-pvc
      persistentVolumeClaim:
        claimName: test-claim  #与PVC名称保持一致
```

# 设置环境变量
```
export MY_NFS_SERVER_HOST="192.168.3.150"
export MY_NFS_SERVER_PATH="/mnt/nfs"
```
## 替换文件中的值
```
cp deployment.yaml deployment.bak
sed -i 's/MY_NFS_SERVER_HOST/'$MY_NFS_SERVER_HOST'/g' deployment.yaml
sed -i 's#MY_NFS_SERVER_PATH#'$MY_NFS_SERVER_PATH'#g' deployment.yaml
sed -i 's#MY_NFS_SERVER_PATH#'$MY_NFS_SERVER_PATH'#g' class.yaml
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
k get pod
NAME                                      READY   STATUS    RESTARTS      AGE
nfs-client-provisioner-5c4dbc6dc5-r2sb5   1/1     Running   0             7s

k get sc
NAME                  PROVISIONER                                   RECLAIMPOLICY   VOLUMEBINDINGMODE   ALLOWVOLUMEEXPANSION   AGE
managed-nfs-storage   k8s-sigs.io/nfs-subdir-external-provisioner   Delete          Immediate           false                  8s
```

## 测试
```
k apply -f test
```
```
ls $MY_NFS_SERVER_PATH
```