---
title: "设置 favicon 图标"           # 文章标题
author: "陈金鑫"              # 文章作者
description : "Hugo 框架，hugo-theme-stack 主题"    # 文章描述信息
lastmod: 2022-11-11T22:24:00+08:00         # 文章修改日期
date: 2022-11-11T22:24:00+08:00
tags : [                    # 文章所属标签
    "图片",
    "博客"
]
categories : [              # 文章所属标签
    "图片"
]

---
1. 修改 config.yaml

添加 favicon 的值，这里使用网络图片
```
params:
    mainSections:
        - post
    featuredImageField: image
    rssFullContent: true
    favicon: https://chenjinxin.cn/images/favicon.png
```

2. 测试

访问博客
