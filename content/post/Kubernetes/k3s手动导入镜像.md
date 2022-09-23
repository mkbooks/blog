---
title: "k3s手动导入镜像"           # 文章标题
author: "陈金鑫"              # 文章作者
description : "k3s手动导入镜像"    # 文章描述信息
lastmod: 2020-08-19        # 文章修改日期
date: 2022-08-19T17:36:18+08:00
tags : [                    # 文章所属标签
    "K3S",
    "云原生",
    "镜像"
]
categories : [              # 文章所属标签
    "云原生"
]
---
准备镜像文件

导入
```
sudo k3s ctr images import pause.tar.gz
```
查看
```
crictl images|grep pause
```