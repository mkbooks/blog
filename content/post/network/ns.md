---
title: "ip-netns"           # 文章标题
author: "陈金鑫"              # 文章作者
description : "ip-netns"    # 文章描述信息
lastmod: 2022-08-25        # 文章修改日期
date: 2022-08-25T1:38:18+08:00
tags : [                    # 文章所属标签
    "Linux",
    "网络"
]
categories : [              # 文章所属标签
    "网络"
]

---
A               B                                 C
192.168.10.1    192.168.10.10   192.168.50.10     192.168.50.1

ip netns exec A ip addr add 192.168.30.246/24 dev A-To-br-A-B
ip netns exec B ip addr add 192.168.30.1/24 dev B-To-br-A-B
ip netns exec B ip addr add 192.168.40.1/24 dev B-To-br-B-C
ip netns exec C ip addr add 192.168.40.133/24 dev C-To-br-B-C

ip netns exec B ping 192.168.30.246 -c1
ip netns exec B ping 192.168.40.133 -c1

ip netns exec A ping 192.168.30.246 -c1
ip netns exec A ping 192.168.40.133 -c1

ip netns exec C ping 192.168.30.246 -c1
ip netns exec C ping 192.168.40.133 -c1

ip netns exec A ip route add 192.168.50.0/24 via 192.168.10.10 dev A-To-br-A-B
ip netns exec A ip route add 192.168.40.0/24 via 192.168.30.1 dev A-To-br-A-B

ip netns exec C ip route add 192.168.10.0/24 via 192.168.50.10 dev C-To-br-B-C
ip netns exec C ip route add 192.168.30.0/24 via 192.168.40.1 dev C-To-br-B-C

ip netns exec A ping 192.168.40.133 -c 1
