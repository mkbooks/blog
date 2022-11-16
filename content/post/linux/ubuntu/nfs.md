---
title: "NFS"           # 文章标题
author: "陈金鑫"              # 文章作者
description : "在 Ubuntu 系统下安装 NFS 服务端"    # 文章描述信息
lastmod: 2022-11-16T20:27:00+08:00         # 文章修改日期
date: 2022-11-16T20:27:00+08:00
tags : [                    # 文章所属标签
    "NFS",
    "Ubuntu",
]
categories : [              # 文章所属标签
    "Ubuntu"
]

---

安装
```
sudo apt update
sudo apt install nfs-kernel-server
```
查看版本
```
sudo cat /proc/fs/nfsd/versions
```
创建共享目录
```
sudo mkdir -p /mnt/nfs
```
导出文件系统
```
sudo vim /etc/exports
```
```
/mnt/nfs    *(rw,sync,no_root_squash,no_subtree_check)
```
保存文件并导出共享共享目录
```
sudo exportfs -ra
```
查看当前活动的 export 及其状态
```
sudo exportfs -v
```
查看 nfs 服务状态