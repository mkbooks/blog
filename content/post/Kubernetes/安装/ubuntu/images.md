---
title: "kubernetes 镜像"           # 文章标题
author: "陈金鑫"              # 文章作者
description : "kubernetes 镜像"    # 文章描述信息
lastmod: 2022-11-18T23:22:00+08:00        # 文章修改日期
date: 2022-11-18T23:22:00+08:00
tags : [                    # 文章所属标签
    "kubernetes",
    "docker"
]
categories : [              # 文章所属标签
    "kubernetes"
]

---
# 查看需要哪些镜像：
```
kubeadm config images list
```
# 批量下载
```
kubeadm config images list |sed -e 's/^/docker pull /g' -e 's#k8s.gcr.io#registry.aliyuncs.com/google_containers#g' |sh -x
```
# 批量重命名镜像
```
docker images |grep registry.aliyuncs.com |awk '{print "docker tag ",$1":"$2,$1":"$2}' |sed -e 's#registry.aliyuncs.com/google_containers#k8s.gcr.io#2' |sh -x
```
# 删除 mirrorgooglecontainers 的镜像
```
docker images |grep registry.aliyuncs.com/google_containers |awk '{print "docker rmi ", $1":"$2}' |sh -x
```
## 手动从 coredns 官方镜像下载 coredns
```
docker pull coredns/coredns:3.8
docker tag coredns/coredns:3.8 k8s.gcr.io/coredns:3.8
docker rmi coredns/coredns:3.8
```

# 生成 kubeadm 配置文件
```
kubeadm config print init-defaults > kubeadm.conf
```
```
vi kubeadm.conf
```
```
imageRepository: registry.aliyuncs.com/google_containers
kubernetesVersion: v1.25.14
nodeRegistration:
  taints:
  - effect: PreferNoSchedule
    key: node-role.kubernetes.io/master
localAPIEndpoint:
  advertiseAddress: 10.0.135.30
networking:
  dnsDomain: cluster.local
  podSubnet: 192.168.0.0/16
  serviceSubnet: 172.18.0.0/16
```
## 更多 kubeadm 配置文件参数
```
kubeadm config print-defaults
```
## 查看需要哪些镜像：
```
kubeadm config images list --config kubeadm.conf
```
## 先拉镜像
```
kubeadm config images pull --config kubeadm.conf
```
## 指定配置文件 init
```
kubeadm init --config /root/kubeadm.conf
```
## 查看 kubernetes 文件
```
ls /etc/kubernetes
```
