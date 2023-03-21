---
title: "lama 使用"          
author: "陈金鑫"             
description : "lama 使用"   
date: 2023-3-20T20:00:00+08:00           
lastmod: 2023-3-20T20:00:00+08:00        

tags : [                 
    "绘画",
    "AI",
    "lama"
]
categories : [            
    "绘画",
    "AI",
]

---
### 下载镜像
```
docker pull cwq1913/lama-cleaner:gpu-0.33.0
```
### 准备
```
mkdir lama && cd lama
mkdir -p {huggingface_cache,torch_cache}

curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list
sudo apt-get update
sudo apt-get install -y nvidia-docker2
sudo systemctl restart docker
```
### 制作镜像
```
lama$ cat docker_build_triton/Dockerfile.triton 
FROM cwq1913/lama-cleaner:gpu-0.33.0

RUN apt-get update && apt-get install -y --no-install-recommends \
        python3-pip && \
    rm -rf /var/lib/apt/lists/*

RUN pip3 install triton
```
```
docker build -t lama-cleaner-triton -f Dockerfile.triton .
```
### 运行
第一次运行，需要下载很多东西，等待即可
```
docker run -d --restart unless-stopped --name lama-cleaner -p 8184:8184 -v $(pwd)/torch_cache:/root/.cache/torch -v $(pwd)/huggingface_cache:/root/.cache/huggingface --gpus all lama-cleaner-triton lama-cleaner --port=8184 --host=0.0.0.0 --gui
```