---
title: "Quick Start"
author: "陈金鑫"              # 文章作者
description : "Quick Start"    # 文章描述信息
date: 2022-08-01T19:52:18+08:00
lastmod: 2020-08-06         # 文章修改日期
tags : [                    # 文章所属标签
    "博客",
]
categories : [              # 文章所属标签
    "博客",
]

---
# Step 1: Install Hugo
```
# Ubuntu 系统
sudo apt update
sudo apt install hugo
```
验证您的新安装:
```
hugo version
```
```
Output
hugo v0.101.0-9f74196ce611cdf6d355bfb99fd8eba5c68ef7f8+extended linux/amd64 BuildDate=2022-06-28T10:02:18Z VendorInfo=snap
```
# Step 2: Create a New Site
```
hugo new site quickstart
```
这个命令会创建一个名为 quickstart 的目录，这就是博客的根目录。目录结构如下：
```
├── archetypes
│   └── default.md
├── config.toml         # 博客站点的配置文件
├── content             # 博客文章所在目录
├── data                
├── layouts             # 网站布局
├── static              # 一些静态内容
└── themes              # 博客主题
```
# Step 3: Add a Theme
首先，从 GitHub 下载主题并将其添加到站点的主题目录中：
```
cd quickstart
git init
git submodule add https://github.com/theNewDynamic/gohugo-theme-ananke.git themes/ananke
```
然后，将主题添加到站点配置中：
```
echo theme = \"ananke\" >> config.toml
```
# Step 4: Add Some Content
```
hugo new posts/my-first-post.md
```
如果需要，可以编辑新创建的内容文件，它将以如下内容开头：
```
---
title: "My First Post"
date: 2019-03-26T08:47:11+01:00
draft: true
---
```
# Step 5: Start the Hugo server
现在，启动启用草稿的 Hugo 服务器：
```
hugo server -D
# 可以在其它机器访问
hugo server --bind="0.0.0.0" -D

# 可以在其它机器访问, -p 修改端口
hugo server --bind="0.0.0.0" -p 80 -D
```
在 http://114.132.247.115:1313/ 导航到您的新站点。
# 第 6 步：自定义主题
在文本编辑器中打开 config.toml：
```
baseURL = "https://example.org/"
languageCode = "en-us"
title = "My New Hugo Site"
theme = "ananke"
```
# 第 7 步：构建静态页面
```
hugo -D
```

