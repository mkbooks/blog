---
title: "linux 系统，使用源码安装 Python"           # 文章标题
author: "陈金鑫"              # 文章作者
description : "安装多版本 Python，但是有些版本没有合适的安装包"    # 文章描述信息
lastmod: 2022-08-26        # 文章修改日期
date: 2022-08-26T16:27:18+08:00
categories : [              
    "Python",
]
tags : [                   
    "Python",
    "Linux"
]
---
参考：https://blog.csdn.net/wxhcyy/article/details/107718794
1. 下载安装文件
```
# 链接从官方找
wget https://www.python.org/ftp/python/3.6.8/Python-3.6.8.tar.xz
```
2. 解压
```
export d_path=''
tar xf Python-3.6.8.tar.xz -C $d_path
```
3. 安装
```
cd $d_path
./configure --prefix=$d_path/python3.6.8
make all
make install
```
4. 测试
```
$d_path/python3.6.8/python -V
```