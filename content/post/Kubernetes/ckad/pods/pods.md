---
title: "pods"           # 文章标题
author: "陈金鑫"              # 文章作者
description : "pods"    # 文章描述信息
lastmod: 2026-08-09T10:39:00+08:00         # 文章修改日期
date: 2026-08-09T10:39:00+08:00
tags : [                    # 文章所属标签
    "kubernetes",
    "ckad",
    "Pod",
]
categories : [              # 文章所属标签
    "kubernetes"
]

---

## 创建 Pod 模版

```bash
# 创建 Pod 模版: 启动 nginx 容器，设置 镜像、标签、环境变量、端口，使用 --dry-run=client 生成 yaml 文件
k run nginx --image=nginx --restart=Never --labels="version=v1,env=prod" --env="DNS_DOMAIN=example.com" --env="POD_NAMESPACE=default" --port=80 --dry-run=client -o yaml > pod.yaml
```

```bash
# 创建临时容器：用 busybox 镜像，访问 frontend 服务的 80 端口，使用 wget 命令获取内容，容器运行结束后自动删除
k run tmp --restart=Never --rm -i --image=busybox -i -- wget -O- frontend:80
```
