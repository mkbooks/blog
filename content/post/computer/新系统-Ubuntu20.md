---
title: "安装新系统-Ubuntu"           # 文章标题
author: "陈金鑫"              # 文章作者
description : "安装新系统后需要做的操作"    # 文章描述信息
lastmod: 2022-12-05T20:00:00+08:00        # 文章修改日期
date: 2022-12-05T20:00:00+08:00
tags : [                    # 文章所属标签
    "Ubuntu"
]
categories : [              # 文章所属标签
    "Ubuntu"
]

---
## 系统
ubuntu20.04
```
$ uname -a
Linux cjx 5.15.0-56-generic #62-Ubuntu SMP Tue Nov 22 19:54:14 UTC 2022 x86_64 x86_64 x86_64 GNU/Linux
```
## 系统设置
### 设置网络
#### 火狐
1. 登陆同步服务
2. 设置 SwitchyOmega（使用内网其他可以上网的机器）

### 设置输入法
#### 搜狗输入法
1. [下载](https://shurufa.sogou.com/linux)
2. [安装](https://shurufa.sogou.com/linux/guide)

### 设置上网
#### Qv2ray
1. https://github.com/v2fly/v2ray-core/releases
    1. `unzip v2ray-linux-64.zip`
2. https://github.com/Qv2ray/Qv2ray/releases
    1. `sudo chmod +x ./Qv2ray-refs.tags.v1.99.6-linux.AppImage`
    2. `sudo ./Qv2ray-refs.tags.v1.99.6-linux.AppImage`

如果报错：
```
dlopen(): error loading libfuse.so.2

AppImages require FUSE to run. 
You might still be able to extract the contents of this AppImage 
if you run it with the --appimage-extract option. 
See https://github.com/AppImage/AppImageKit/wiki/FUSE 
for more information
```
安装：`sudo apt install libfuse2`

3. 首选项 -> 内核设置

4. 设置服务器

    0. `sudo v2ray url`
    1. [搬瓦工](https://bwh1.net/index.php)
    2. [腾讯云](https://cloud.tencent.com/)
    3. [阿里云](https://www.aliyun.com)
    4. [谷歌云](https://cloud.google.com/)

5. SwitchyOmega.auto switch.规则列表设置: https://raw.githubusercontent.com/gfwlist/gfwlist/master/gfwlist.txt
#### chrome 浏览器
1. [下载](https://www.google.com/intl/zh-CN/chrome/)
2. 安装: `sudo dpkg -i `

## 安装软件

### vscode

### IDEA

### PyCharm

