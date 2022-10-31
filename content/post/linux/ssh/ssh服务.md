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
## 修改ssh登录端口
```
$ vi /etc/ssh/sshd_config

#Port 22
#修改为：
Port 8848 #这里修改为你想要设置的端口,以 8848 为例
```
### 修改防火墙配置
```
$ vi /etc/sysconfig/iptabels
```
添加以下规则
```
-A INPUT -m state --state NEW -m tcp -p tcp --dport 60022 -j ACCEPT
```
刷新iptables并重启ssh服务
```
$ systemctl restart iptables.service
$ systemctl restart sshd.service
```
## 禁止 ssh 口令登录
更改ssh配置
```
$ vi /etc/ssh/sshd_config
```
```
#PasswordAuthentication yes 改为
PasswordAuthentication no
```
编辑保存完成后，重启ssh服务使得新配置生效，然后就无法使用口令来登录ssh了
```
$ systemctl restart sshd.service
```
