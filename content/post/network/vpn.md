---
title: "终端设置特定IP段走路由"           # 文章标题
author: "陈金鑫"              # 文章作者
description : "终端设置特定IP段走路由"    # 文章描述信息
date: 2022-09-08T11:02:00+08:00
lastmod: 2022-09-08T11:02:00+08:00        # 文章修改日期
categories : [              # 文章所属标签
    "网络"
]
tags : [                    # 文章所属标签
    "Linux",
    "网络",
    "vpn"
]

---
## create config
```bash
pptpsetup --create vpn --server vpn.bjklb.com --username ai-lijinxin --password 123
pptpsetup --create vpn --server 111.198.75.20 --username ai-lijinxin --password 123
```
## connect
```bash
pon vpn
```
then will create a network device named `ppp0`
## route
route for target like `10.0.1.0` to `ppp0`
```
ip route add 10.0.1.0/24 dev ppp0
```
## disconnect
```bash
poff vpn
```
