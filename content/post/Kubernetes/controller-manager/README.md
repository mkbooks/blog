---
title: "Controller Manager"
author: "陈金鑫"
description : "Controller Manager"
lastmod: 2023-02-12T21:29:00+08:00
date: 2023-02-12T21:29:00+08:00
tags : [ 
    "Kubernetes",
    "云原生",
    "Controller Manager"
]
categories : [
    "Kubernetes",
    "云原生",
    "Controller Manager"
]
keywords : [
    "Kubernetes",
    "云原生",
    "Controller Manager"
]

---
# 查看 "Controller Manager" 的帮助
```
k8s@k8s:~/101$ ks get pod
NAME                          READY   STATUS    RESTARTS       AGE
coredns-7f6cbbb7b8-6zd49      1/1     Running   11 (15d ago)   64d
coredns-7f6cbbb7b8-7kshr      1/1     Running   11 (15d ago)   64d
etcd-k8s                      1/1     Running   11 (15d ago)   64d
kube-apiserver-k8s            1/1     Running   11 (15d ago)   64d
kube-controller-manager-k8s   1/1     Running   11 (15d ago)   64d
kube-proxy-m9kgw              1/1     Running   11 (15d ago)   64d
kube-scheduler-k8s            1/1     Running   11 (15d ago)   64d
k8s@k8s:~/101$ ks exec -it kube-controller-manager-k8s -- kube-controller-manager -h
The Kubernetes controller manager is a daemon that embeds
```