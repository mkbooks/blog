---
title: "安装 kubernetes(Ubuntu20.04环境)"           # 文章标题
author: "陈金鑫"              # 文章作者
description : "安装 kubernetes"    # 文章描述信息
lastmod: 2022-11-18T22:22:00+08:00        # 文章修改日期
date: 2022-11-18T22:22:00+08:00
tags : [                    # 文章所属标签
    "kubernetes"
]
categories : [              # 文章所属标签
    "kubernetes"
]

---
# 环境
- 操作系统: Ubuntu20.04
- cpu 架构: x86
- kubernetes 版本: v1.22.16

# 基础环境设置
## 添加 sudo 权限
```
sudo visudo
```
```
%sudo ALL=(ALL:ALL) NOPASSWD:ALL
```
```
sudo -i
```
## 关闭 Swap
```
swapoff -a
vi /etc/fstab
```
remove the line with swap keyword
## 设置 iptables
```
cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
br_netfilter
EOF
```
```
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
```
```
sysctl --system
```

# 安装基础软件
## 更新
```
sudo apt-get update
```
## 安装 docker 
```
sudo apt install docker.io -y
```
### 设置 docker
```
vi /etc/docker/daemon.json
```
```
{
  "exec-opts": ["native.cgroupdriver=systemd"]
}
```
```
systemctl daemon-reload
systemctl restart docker
```
### 添加普通用户
```
sudo usermod -aG docker ${USER}
```
## 安装 apt-transport-https ca-certificates curl
```
apt-get install -y apt-transport-https ca-certificates curl
```
## 安装 kubeadm
### 添加库
```
curl -s https://mirrors.aliyun.com/kubernetes/apt/doc/apt-key.gpg | sudo apt-key add -
```
```
tee /etc/apt/sources.list.d/kubernetes.list <<-'EOF'
deb https://mirrors.aliyun.com/kubernetes/apt kubernetes-xenial main
EOF
```
### 更新源
```
apt-get update
```
### 安装 kubelet, kubeadm, kubectl
#### 查看版本
```
apt-cache madison kubectl|grep 1.22
```
```
apt-get install -y kubelet=1.22.16-00 kubeadm=1.22.16-00 kubectl=1.22.16-00
apt-mark hold kubelet kubeadm kubectl
```
## kubeadm init
```
kubeadm init \
 --image-repository registry.aliyuncs.com/google_containers \
 --kubernetes-version v1.22.16 \
 --pod-network-cidr=192.168.0.0/16
```
如果用 containerd 的话
```
kubeadm init \
--image-repository registry.aliyuncs.com/google_containers \
--kubernetes-version v1.22.16 \
--pod-network-cidr=192.168.0.0/16 \
--cri-socket /run/containerd/containerd.sock
```

# 使用
普通用户
```
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```
root 用户
```
export KUBECONFIG=/etc/kubernetes/admin.conf
```

## 取消节点污点
```
kubectl taint nodes --all node-role.kubernetes.io/master-
kubectl taint nodes --all node-role.kubernetes.io/control-plane- node-role.kubernetes.io/master-

```
## 安装 calico cni plugin
[https://docs.projectcalico.org/getting-started/kubernetes/quickstart](https://docs.projectcalico.org/getting-started/kubernetes/quickstart)
```
kubectl create -f https://docs.projectcalico.org/manifests/tigera-operator.yaml
kubectl create -f https://docs.projectcalico.org/manifests/custom-resources.yaml
```
## 添加节点
master
```
kubeadm token create --print-join-command
kubeadm token list
```
node
```
kubeadm join --token <token> <control-plane-host>:<control-plane-port> --discovery-token-ca-cert-hash sha256:<hash>
```