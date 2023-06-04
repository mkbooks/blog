---
title: "docker部署langchain-ChatGLM"
author: "陈金鑫"
description : "docker部署langchain-ChatGLM"
lastmod: 2023-06-04T10:00:00+08:00
date: 2023-06-04T10:00:00+08:00
categories : [              
    "AIGC"
]
tags : [                    
    "AIGC",
    "ChatGLM",
]
---
## 下载项目
```
git clone https://github.com/imClumsyPanda/langchain-ChatGLM
cd langchain-ChatGLM
git fetch --all
git checkout v0.1.14
```
## docker 部署
在主机上安装 NVIDIA Container Toolkit
```
sudo apt-get update
sudo apt-get install -y nvidia-container-toolkit-base
sudo systemctl daemon-reload 
sudo systemctl restart docker
```
### 联网使用
#### 编译镜像
```
docker build -f Dockerfile-cuda -t chatglm-cuda:latest .
```
#### 启动容器
```
docker run --gpus all -d --name chatglm -p 7860:7860  chatglm-cuda:latest
```
### 使用离线模型
```
cjx@cjx:/ssd2/github/THUDM/ChatGLM-6B/chatglm-6b$ ll
总计 13105340
drwxrwxr-x  3 cjx cjx       4096  5月 22 14:55 ./
drwxrwxr-x 10 cjx cjx       4096  5月 22 15:18 ../
-rw-rw-r--  1 cjx cjx        773  5月 22 14:43 config.json
-rw-rw-r--  1 cjx cjx       4276  5月 22 14:43 configuration_chatglm.py
drwxrwxr-x  8 cjx cjx       4096  5月 22 14:43 .git/
-rw-rw-r--  1 cjx cjx       1477  5月 22 14:43 .gitattributes
-rw-rw-r--  1 cjx cjx    2706249  5月 22 14:44 ice_text.model
-rw-rw-r--  1 cjx cjx      11336  5月 22 14:44 LICENSE
-rw-rw-r--  1 cjx cjx      57620  5月 22 14:43 modeling_chatglm.py
-rw-rw-r--  1 cjx cjx       2354  5月 22 14:44 MODEL_LICENSE
-rw-rw-r--  1 cjx cjx 1740651802  5月 22 14:53 pytorch_model-00001-of-00008.bin
-rw-rw-r--  1 cjx cjx 1879731432  5月 22 14:53 pytorch_model-00002-of-00008.bin
-rw-rw-r--  1 cjx cjx 1980385902  5月 22 14:53 pytorch_model-00003-of-00008.bin
-rw-rw-r--  1 cjx cjx 1913294120  5月 22 14:53 pytorch_model-00004-of-00008.bin
-rw-rw-r--  1 cjx cjx 1879722289  5月 22 14:53 pytorch_model-00005-of-00008.bin
-rw-rw-r--  1 cjx cjx 1879731496  5月 22 14:53 pytorch_model-00006-of-00008.bin
-rw-rw-r--  1 cjx cjx 1074103621  5月 22 14:50 pytorch_model-00007-of-00008.bin
-rw-rw-r--  1 cjx cjx 1069286123  5月 22 14:50 pytorch_model-00008-of-00008.bin
-rw-rw-r--  1 cjx cjx      33416  5月 22 14:43 pytorch_model.bin.index.json
-rw-rw-r--  1 cjx cjx      15054  5月 22 14:43 quantization.py
-rw-rw-r--  1 cjx cjx       6087  5月 22 14:43 README.md
-rw-rw-r--  1 cjx cjx      13822  5月 22 14:43 test_modeling_chatglm.py
-rw-rw-r--  1 cjx cjx      17047  5月 22 14:43 tokenization_chatglm.py
-rw-rw-r--  1 cjx cjx        441  5月 22 14:43 tokenizer_config.json
```
#### 修改配置
configs/model_config
```
# 如果你需要加载本地的model，指定这个参数  ` --no-remote-model`，或者下方参数修改为 `True`
# NO_REMOTE_MODEL = False
NO_REMOTE_MODEL = True
```
#### 编译镜像
```
docker build -f Dockerfile-cuda -t chatglm-cuda:latest .
```
#### 启动容器
配置好模型路径，然后此repo挂载到Container
```
docker run --gpus all -d --name chatglm -p 7860:7860 -v /ssd2/github/THUDM/ChatGLM-6B/chatglm-6b:/chatGLM/model/chatglm-6b  chatglm-cuda:latest
```

