---
title: "ssh服务"           # 文章标题
author: "陈金鑫"              # 文章作者
description : "ssh服务"    # 文章描述信息
date: 2022-09-13T14:44:00+08:00
lastmod: 2022-09-13T14:44:00+08:00        # 文章修改日期
categories : [              # 文章所属标签
    "Linux"
]
tags : [                    # 文章所属标签
    "Linux",
    "ssh",
]

---
## 更新源
```
sudo apt-get update
```
## 安装ssh服务
```
sudo apt-get install openssh-server
```
## 验证SSH服务
```
sudo systemctl status ssh
```
## 创建密钥
```
ssh-keygen 
```
