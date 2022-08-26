---
title: "pycharm 项目配置虚拟环境"           # 文章标题
author: "陈金鑫"              # 文章作者
description : "项目已经创建好，后添加虚拟环境"    # 文章描述信息
lastmod: 2022-08-26        # 文章修改日期
date: 2022-08-26T15:04:18+08:00
categories : [              
    "pycharm",
]
tags : [                   
    "虚拟环境"
]

---
File -> Settings -> Project: project_name -> Project Interpreter -> Add... -> Virtualenv Environment -> (配置) -> OK

source project_path/venv/bin/activate

### 命令行
Installation

To install virtualenv via pip run:
```
$ pip3 install virtualenv
```

Usage

Creation of virtualenv:
```
$ virtualenv -p python3 <desired-path>
```

Activate the virtualenv:
```
$ source <desired-path>/bin/activate
```

Deactivate the virtualenv:
```
$ deactivate
```