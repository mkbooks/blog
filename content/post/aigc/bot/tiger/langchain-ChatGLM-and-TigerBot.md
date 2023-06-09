---
title: "langchain-ChatGLM-and-TigerBot"
author: "陈金鑫"
description : "langchain-ChatGLM-and-TigerBot"
lastmod: 2023-06-09T10:00:00+08:00
date: 2023-06-09T10:00:00+08:00
categories : [              
    "AIGC"
]
tags : [                    
    "AIGC",
    "TigerBot",
    "langchain"
]
---
## 下载项目
```
git clone https://github.com/wordweb/langchain-ChatGLM-and-TigerBot.git
cd langchain-ChatGLM-and-TigerBot/
```
## Docker 部署
为了能让容器使用主机GPU资源，需要在主机上安装 [NVIDIA Container Toolkit](https://github.com/NVIDIA/nvidia-container-toolkit)。具体安装步骤如下：
```shell
sudo apt-get update
sudo apt-get install -y nvidia-container-toolkit-base
sudo systemctl daemon-reload 
sudo systemctl restart docker
```
安装完成后，可以使用以下命令编译镜像和启动容器：
```
docker build -f Dockerfile-cuda -t chatglm-cuda-tigerbot:latest .
```
### 使用离线模型
text2vec-large-chinese
```
cjx@cjx:/ssd2/huggingface/GanymedeNil/text2vec-large-chinese$ ll
总计 1272280
drwxrwxr-x 2 cjx cjx       4096  6月  9 20:46 ./
drwxrwxr-x 3 cjx cjx       4096  6月  9 20:45 ../
-rw-rw-r-- 1 cjx cjx        821  6月  9 20:46 config.json
-rw-rw-r-- 1 cjx cjx         69  6月  9 20:46 eval_results.txt
-rw-rw-r-- 1 cjx cjx       1477  6月  9 20:45 .gitattributes
-rw-rw-r-- 1 cjx cjx 1302223089  3月  7 11:34 pytorch_model.bin
-rw-rw-r-- 1 cjx cjx        317  6月  9 20:46 README.md
-rw-rw-r-- 1 cjx cjx        125  6月  9 20:46 special_tokens_map.json
-rw-rw-r-- 1 cjx cjx        514  6月  9 20:46 tokenizer_config.json
-rw-rw-r-- 1 cjx cjx     439387  6月  9 20:46 tokenizer.json
-rw-rw-r-- 1 cjx cjx     109540  6月  9 20:46 vocab.txt
```
ChatGLM-6B
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
TigerResearch
```
cjx@cjx:/ssd2/huggingface/TigerResearch/tigerbot-7b-sft$ ll
总计 15824908
drwxrwxr-x 2 cjx cjx       4096  6月  9 20:35 ./
drwxrwxr-x 3 cjx cjx       4096  6月  9 20:09 ../
-rw-rw-r-- 1 cjx cjx        765  6月  9 20:10 config.json
-rw-rw-r-- 1 cjx cjx        132  6月  9 20:10 generation_config.json
-rw-rw-r-- 1 cjx cjx       1528  6月  9 20:10 .gitattributes
-rw-rw-r-- 1 cjx cjx 9974654870  6月  7 19:14 pytorch_model-00001-of-00002.bin
-rw-rw-r-- 1 cjx cjx 6215469038  6月  7 18:53 pytorch_model-00002-of-00002.bin
-rw-rw-r-- 1 cjx cjx      31898  6月  9 20:10 pytorch_model.bin.index.json
-rw-rw-r-- 1 cjx cjx       2123  6月  9 20:10 README.md
-rw-rw-r-- 1 cjx cjx        190  6月  9 20:10 special_tokens_map.json
-rw-rw-r-- 1 cjx cjx        289  6月  9 20:10 tokenizer_config.json
-rw-rw-r-- 1 cjx cjx   14500838  6月  9 20:11 tokenizer.json
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
docker run --gpus all -d \
  --name chatglm-tigerbot \
  -p 7861:7860 \
  -v /ssd2/huggingface/GanymedeNil/text2vec-large-chinese:/chatGLM/model/text2vec-large-chinese \
  -v /ssd2/github/THUDM/ChatGLM-6B/chatglm-6b:/chatGLM/model/chatglm-6b \
  -v /ssd2/huggingface/TigerResearch/tigerbot-7b-sft:/chatGLM/model/TigerBot \
  chatglm-cuda-tigerbot:latest
```
