---
title: "git http方式免密提交"           # 文章标题
author: "陈金鑫"              # 文章作者
description : "git http方式免密提交"    # 文章描述信息
lastmod: 2022-08-26        # 文章修改日期
date: 2022-08-26T14:36:18+08:00
tags : [                    # 文章所属标签
    "git",
]
categories : [              # 文章所属标签
    "git",
]

---
转载：https://juejin.cn/post/6844903602968854542

## 设置记住密码（默认15分钟）
可以将你的密码缓存下来，只用输一次密码，以后都可以不用输入了。缺点就是密码都明文保存在 `~/.git-credential` 文件中。
```
git config --global credential.helper cache
```
如果想自己设置时间，可以使用以下命令：
```
git config credential.helper 'cache --timeout=3600'
```
这样就设置一个小时之后失效

## 长期存储密码：
```
git config --global credential.helper store
```
增加远程地址的时候带上密码也是可以的。(推荐)
```
http://yourname:password@git.oschina.net/name/project.git
```
补充：使用客户端也可以存储密码。
## 如果你正在使用ssh而且想体验https带来的高速，那么你可以这样做：
切换到项目目录下 ：
```
cd project/
```
移除远程ssh方式的仓库地址
```
git remote rm origin
```
复制代码增加https远程仓库地址
```
git remote add origin http://yourname:password@git.oschina.net/name/project.git
```
