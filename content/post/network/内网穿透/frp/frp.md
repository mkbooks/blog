---
title: "通过FRP实现内网穿透"
author: "陈金鑫"
description : "基于Docker通过FRP实现内网穿透"
lastmod: 2023-02-20T10:00:00+08:00
date: 2023-02-20T10:00:00+08:00
categories : [              
    "网络"
]
tags : [                    
    "FRP"
]
---
1. 安装 Docker。
    1. Ubuntu
        1. sudo apt install docker.io -y
    2. CentOS
        1. sudo yum update
        2. sudo yum install -y yum-utils
        3. sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
        4. sudo yum install -y docker-ce docker-ce-cli containerd.io
        5. sudo systemctl start docker
        6. sudo docker run hello-world
    3. 普通用户执行权限添加
        1. sudo groupadd docker
        2. sudo usermod -aG docker ${USER}
    4. 更新并激活组权限
        1. newgrp docker
2. 服务端
    1. 下载 FRP 镜像。
        1. docker pull snowdreamtech/frps
    2. 创建配置文件
        1. vim /home/sammy/frp/frps.ini
    3. 创建 FRP 容器。
        1. docker run -d --restart always --network host --name frps -v /home/sammy/frp/frps.ini:/etc/frp/frps.ini snowdreamtech/frps
    4. 控制面板
        1. http://${public_ip}:7500/
3. 客户端
    1. 下载 FRP 镜像。
        1. docker pull snowdreamtech/frpc
    2. 创建配置文件
        1. vim /home/sammy/frp/frpc.ini
    3. 创建 FRP 容器。
        1. docker run -d --restart always --network host --name frpc -v /home/sammy/frp/frpc.ini:/etc/frp/frpc.ini snowdreamtech/frpc
4. 测试
    1. ssh
        1. ssh root@${public_ip} -p 2288
    2. nginx
        1. http://${public_ip}:8080/
    3. k8s-dashboard
        1. https://${public_ip}:1113/
