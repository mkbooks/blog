---
title: "python 清理包"           # 文章标题
author: "陈金鑫"              # 文章作者
description : "python 清理包"    # 文章描述信息
lastmod: 2020-08-08         # 文章修改日期
date: 2022-08-08T18:13:18+08:00
tags : [                    # 文章所属标签
    "Python",
    "包管理",
]
categories : [              # 文章所属标签
    "Python",
]

---
pip freeze > test.txt

pip uninstall -r test.txt -y

pip install -r requirements.txt