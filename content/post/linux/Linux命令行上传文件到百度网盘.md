---
title: "Linux命令行上传文件到百度网盘"           # 文章标题
author: "陈金鑫"              # 文章作者
description : "Linux命令行上传文件到百度网盘"    # 文章描述信息
lastmod: 2022-09-07T14:18:00+08:00     # 文章修改日期
date: 2022-09-07T14:18:00+08:00
categories : [              # 文章所属标签
    "Linux"
]
tags : [                    # 文章所属标签
    "Linux",
    "网盘"
]
---
> 参考: https://www.jianshu.com/p/dc7e86b171cb

## 安装软件工具
```
pip install requests
pip install bypy
```
## 授权登陆
执行 bypy info，显示下边信息，根据提示，通过浏览器访问下边灰色的https链接，如果此时百度网盘账号正在登陆，会出现长串授权码，复制。
```
[root@yu~]# bypy info
Please visit:   # 访问下边这个连接，复制授权码
https://openapi.baidu.com/oauth/2.0/authorize?scope=basic+netdisk&redirect_uri=oob&response_type=code&client_id=q8WE4EpCsau1oS0MplgMKNBn
And authorize this app
Paste the Authorization Code here within 10 minutes.
Press [Enter] when you are done    # 提示在下边粘贴授权码
```
在下边图示位置粘贴授权码，耐心等待一会即可
```
Press [Enter] when you are done
2d2416c9e27c5b19f14da97c82daf18e
Authorizing, please be patient, it may take upto 300 seconds...
Quota: 14.020TB
Used: 5.497TB
```
授权成功。

## 测试上传和同步本地文件到云盘
由于百度PCS API权限限制，程序只能存取百度云端/apps/bypy目录下面的文件和目录。我们可以通过：
```
[root@yu~]# bypy list
/apps/bypy ($t $f $s $m $d):
```
把本地当前目录下的文件同步到百度云盘：
```
bypy upload
```
把云盘上的内容同步到本地:
```
bypy downdir
```
比较本地当前目录和云盘根目录，看是否一致，来判断是否同步成功：
```
bypy compare
```
