---
title: "iptables"           # 文章标题
author: "陈金鑫"              # 文章作者
description : "iptables"    # 文章描述信息
lastmod: 2022-08-25        # 文章修改日期
date: 2022-08-25T1:38:18+08:00
tags : [                    # 文章所属标签
    "Linux",
    "网络"
]
categories : [              # 文章所属标签
    "Linux",
    "网络"
]
keywords : [                # 文章关键词
    "Linux",
    "网络"
]

next: http://changxiangyu.cn/2022/08/%E4%BF%AE%E6%94%B9%E5%8D%9A%E5%AE%A2%E4%B8%BB%E9%A2%98/      # 下一篇博客地址
prev: http://changxiangyu.cn/2020/08/%E5%9C%A8-ubuntu20.04-%E5%BB%BA%E8%AE%BE-openvpn/  # 上一篇博客地址
---
```
专线两端IP：
A：10.246.1.173
B：10.246.1.174

A出口伪IP：88.88.44.3（回程IP）
A入口伪IP：88.88.43.8
ANAT内部IP：10.23.80.228-230

B中心服务器伪NAT内部IP：10.252.3.88/29

配置方法：
sudo ip addr add 10.252.3.88/29 dev ens1f1 #添加伪NATIP
sudo route add 88.88.43.8 gw 10.246.1.173 #出口网关
sudo route add 88.88.44.3 gw 10.246.1.173 #入口网关
sudo iptables -t nat -A PREROUTING -i ens1f1 -d 10.252.3.88 -j DNAT --to 88.88.44.3
sudo iptables -t nat -I POSTROUTING -d 88.88.43.8 -o ens1f1  -j SNAT --to-source 10.252.3.88
```
