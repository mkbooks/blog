---
title: "停止deployment不删除"           # 文章标题
author: "陈金鑫"              # 文章作者
description : "停止deployment不删除"    # 文章描述信息
lastmod: 2023-02-10T13:00:00+08:00        # 文章修改日期
date: 2023-02-10T13:00:00+08:00
tags : [                    # 文章所属标签
    "Kubernetes",
    "云原生"
]
categories : [              # 文章所属标签
    "云原生"
]
keywords : [                # 文章关键词
    "Kubernetes",
    "云原生"
]

---

将 `replicas` 设为 0
```
k scale --replicas=0 deployment/deployment_name
```
