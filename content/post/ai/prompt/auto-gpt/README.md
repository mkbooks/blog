---
title: "使用Auto-GPT"
author: "陈金鑫"
description : "学习使用Auto-GPT" 
lastmod: 2023-04-16T20:48:00+08:00
date: 2023-04-16T20:48:00+08:00
tags : [
    "AI",
    "Prompt",
    "Auto-GPT"
]
categories : [
    "AI",
]

---
# 环境要求
- Python 3.8 or later
- OpenAI GPT-3 API Key(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)
# 安装
## 下载Auto-GPT
```bash
git clone https://github.com/Torantulino/Auto-GPT.git
cd Auto-GPT
```
## 安装依赖
```bash
pip install -r requirements.txt -i https://mirrors.aliyun.com/pypi/simple --trusted-host mirrors.aliyun.com
或
pip install -r requirements.txt -i https://pypi.tuna.tsinghua.edu.cn/simple --trusted-host pypi.tuna.tsinghua.edu.cn
或
pip install -r requirements.txt -i https://pypi.douban.com/simple --trusted-host pypi.douban.com
```
## 运行Redis容器
```bash
docker run -d -p 6379:6379 --name redis redis
```
## 配置
```bash
cp .env.example .env
```
修改.env文件中的配置

- OPENAI_API_KEY: OpenAI GPT-3 API Key
- MEMORY_BACKEND=redis
## 运行
```bash
python -m autogpt
```
