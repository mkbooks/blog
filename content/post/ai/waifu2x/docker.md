---
title: "waifu2x 使用"          
author: "陈金鑫"             
description : "waifu2x 使用"   
date: 2023-3-21T20:00:00+08:00           
lastmod: 2023-3-21T20:00:00+08:00        

tags : [                 
    "绘画",
    "AI",
    "waifu2x"
]
categories : [            
    "绘画",
    "AI",
]

---
### 下载镜像
```
docker pull nagadomi/waifu2x:latest
```
### 运行
```
mkdir waifu2x && cd waifu2x
docker run --gpus all -p 8812:8812 nagadomi/waifu2x:latest th web.lua
```
