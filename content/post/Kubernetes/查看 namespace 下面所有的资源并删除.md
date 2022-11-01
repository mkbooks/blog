---
title: "查看 namespace 下面所有的资源并删除"           # 文章标题
author: "陈金鑫"              # 文章作者
description : "查看 namespace 下面所有的资源并删除"    # 文章描述信息
lastmod: 2022-11-1T10:03:18+08:00        # 文章修改日期
date: 2022-11-1T10:03:18+08:00
tags : [                    # 文章所属标签
    "K8S",
    "云原生"
]
categories : [              # 文章所属标签
    "云原生"
]
keywords : [                # 文章关键词
    "K8S",
    "云原生"
]

---
转载: https://blog.csdn.net/Man_In_The_Night/article/details/109184175


查看 namespace 下面所有的资源
```
kubectl api-resources -o name --verbs=list --namespaced | xargs -n 1 kubectl get --show-kind --ignore-not-found -n {namespace}
```

删除 namespace 下面所有的资源
```
kubectl delete all --all -n {namespace}
```

有时候删除资源会出现长时间处于 terminating 状态，可以使用 --force --grace-period=0
```
kubectl delete po xxx --force --grace-period=0 
```

有时候删除 namespace ，会出现长时间处于 terminating 状态，即使使用 --force --grace-period=0 ，仍然处于 terminating 状态，可以使用原生接口删除
```
# 获取namespace的详情信息
$ kubectl  get ns rdbms  -o json > rdbms.json

# 查看napespace定义的json配置
## 删除掉spec部分即可
$ cat rdbms.json
{
    "apiVersion": "v1",
    "kind": "Namespace",
    "metadata": {
        "annotations": {
            "kubectl.kubernetes.io/last-applied-configuration": "{\"apiVersion\":\"v1\",\"kind\":\"Namespace\",\"metadata\":{\"annotations\":{},\"name\":\"rdbms\"}}\n"
        },
        "creationTimestamp": "2019-10-14T12:17:44Z",
        "deletionTimestamp": "2019-10-14T12:30:27Z",
        "name": "rdbms",
        "resourceVersion": "8844754",
        "selfLink": "/api/v1/namespaces/rdbms",
        "uid": "29067ddf-56d7-4cce-afa3-1fbdbb221ab1"
    },
    "spec": {
        "finalizers": [
            "kubernetes"
        ]
    },
    "status": {
        "phase": "Terminating"
    }
}

# 使用http接口进行删除
$ curl -k -H "Content-Type:application/json" -X PUT --data-binary @rdbms.json https://x.x.x.x:6443/api/v1/namespaces/rdbms/finalize
{
  "kind": "Namespace",
  "apiVersion": "v1",
  "metadata": {
    "name": "rdbms",
    "selfLink": "/api/v1/namespaces/rdbms/finalize",
    "uid": "29067ddf-56d7-4cce-afa3-1fbdbb221ab1",
    "resourceVersion": "8844754",
    "creationTimestamp": "2019-10-14T12:17:44Z",
    "deletionTimestamp": "2019-10-14T12:30:27Z",
    "annotations": {
      "kubectl.kubernetes.io/last-applied-configuration": "{\"apiVersion\":\"v1\",\"kind\":\"Namespace\",\"metadata\":{\"annotations\":{},\"name\":\"rdbms\"}}\n"
    }
  },
  "spec": {

  },
  "status": {
    "phase": "Terminating"
  }

# 再次查看namespace发现已经被删除了
$ kubectl  get ns  | grep rdb
```

如果在这些命令后 Pod 仍处于 Unknown 状态，请使用以下命令从集群中删除 Pod:
```
kubectl patch pod <pod> -p '{"metadata":{"finalizers":null}}'
```
