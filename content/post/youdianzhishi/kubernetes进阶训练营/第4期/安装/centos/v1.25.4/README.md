---
title: "CentOS7.9下安装kubernetes v1.25.4"
author: "陈金鑫"
description : "安装 kubernetes"
lastmod: 2023-02-19T09:00:00+08:00
date: 2023-02-19T09:00:00+08:00
tags : [                    # 文章所属标签
    "kubernetes"
]
categories : [              # 文章所属标签
    "kubernetes"
]

---
# 环境
- 操作系统: CentOS7.9
- cpu 架构: x86
- kubernetes 版本: v1.25.6

## 系统版本
版本号
```
[root@master ~]# cat /etc/centos-release
CentOS Linux release 7.9.2009 (Core)
```
内核版本
```
[root@master ~]# uname -r
3.10.0-1160.el7.x86_64
```
操作系统位数
```
[root@master ~]# getconf LONG_BIT
64
```

# 环境准备
## 设置 hostname
```
hostnamectl set-hostname master
```
添加到`/etc/hosts`
```
vim /etc/hosts

192.168.122.88  master
```
## 禁用防火墙
```
[root@master ~]# systemctl stop firewalld
[root@master ~]# systemctl disable firewalld
```
## 禁用 SELINUX
```
# 暂时性
[root@master ~]# setenforce 0
# 永久
[root@master ~]# vim /etc/selinux/config
```
> SELINUX=disabled，重新启动系统，使更改生效。
## 开启内核 ipv4 转发
加载 br_netfilter 模块
```
[root@master ~]# modprobe br_netfilter
```
令设置成开机启动
```
vim /etc/rc.d/rc.local
# 添加
for file in /etc/sysconfig/modules/*.modules ; do
[ -x $file ] "# $file
done
```
在 /etc/sysconfig/modules/ 目录下新建如下文件：
```
mkdir -p /etc/sysconfig/modules/
vi /etc/sysconfig/modules/br_netfilter.modules
```
> modprobe br_netfilter

增加权限
```
chmod 755 /etc/sysconfig/modules/br_netfilter.modules
```
重启测试
```
lsmod|grep br_netfilter

br_netfilter 22256 0
bridge 151336 1 br_netfilter
```

创建 `vim /etc/sysctl.d/k8s.conf` 文件，添加如下内容
```
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
# 下面的内核参数可以解决ipvs模式下长连接空闲超时的问题
net.ipv4.tcp_keepalive_intvl = 30
net.ipv4.tcp_keepalive_probes = 10
net.ipv4.tcp_keepalive_time = 600
```
令使修改生效
```
sysctl -p /etc/sysctl.d/k8s.conf
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
## 安装 ipvs
```
cat > /etc/sysconfig/modules/ipvs.modules <<EOF
#!/bin/bash
modprobe -- ip_vs
modprobe -- ip_vs_rr
modprobe -- ip_vs_wrr
modprobe -- ip_vs_sh
modprobe -- nf_conntrack_ipv4
EOF
```
```
chmod 755 /etc/sysconfig/modules/ipvs.modules && bash /etc/sysconfig/modules/ipvs.modules && lsmod | grep -e ip_vs -e nf_conntrack_ipv4
```
output:
```
nf_conntrack_ipv4      15053  0 
nf_defrag_ipv4         12729  1 nf_conntrack_ipv4
ip_vs_sh               12688  0 
ip_vs_wrr              12697  0 
ip_vs_rr               12600  0 
ip_vs                 145458  6 ip_vs_rr,ip_vs_sh,ip_vs_wrr
nf_conntrack          139264  2 ip_vs,nf_conntrack_ipv4
libcrc32c              12644  3 xfs,ip_vs,nf_conntrack
```
安装管理工具ipvsadm：
```
yum install ipset
yum install ipvsadm -y
```
## 同步服务器时间
这里使用 chrony 来进行同步，其他工具也可以：
```
yum install chrony -y
systemctl enable chronyd
systemctl start chronyd
chronyc sources
```
output
```
210 Number of sources = 4
MS Name/IP address         Stratum Poll Reach LastRx Last sample               
===============================================================================
^- ns1.newsnet.li                2   6    17     3  -7556us[-7556us] +/-  148ms
^? ntp6.flashdance.cx            2   6     3     1    +16ms[  +16ms] +/-  161ms
^* 36.110.233.85                 2   6    17     4    -53us[  -10ms] +/-   70ms
^? a.chl.la                      2   6    10     9    -33ms[ -467ms] +/-  174ms
```
查看时间
```
[root@master ~]# date
2023年 02月 19日 星期日 21:44:15 CST
```
## 关闭 swap 分区
```
swapoff -a
```
修改 `/etc/fstab` 文件，注释掉 SWAP 的自动挂载，使用 `free -m` 确认 swap 已经关闭。swappiness 参数调整，修改 `/etc/sysctl.d/k8s.conf` 添加下面一行：
```
vm.swappiness=0
```
执行 `sysctl -p /etc/sysctl.d/k8s.conf` 使修改生效。

当然如果是生产环境使用还可以先对内核参数进行统一的调优。

## 安装 Containerd
### 安装 seccomp 依赖
在节点上安装 seccomp 依赖，需要版本 >2.4，如果有则升级
```
rpm -qa |grep libseccomp
output:
libseccomp-2.3.1-4.el7.x86_64
```
卸载
```
yum remove libseccomp-2.3.1-4.el7.x86_64 -y
```
output
```
...
Running transaction
  正在删除    : chrony-3.4-1.el7.x86_64                                                                                                                         1/2 
  正在删除    : libseccomp-2.3.1-4.el7.x86_64                                                                                                                   2/2 
  验证中      : libseccomp-2.3.1-4.el7.x86_64                                                                                                                   1/2 
  验证中      : chrony-3.4-1.el7.x86_64                                                                                                                         2/2 

删除:
  libseccomp.x86_64 0:2.3.1-4.el7                                                                                                                                   

作为依赖被删除:
  chrony.x86_64 0:3.4-1.el7                                                                                                                                         

完毕！
```
### 重新安装 chrony
```
yum install chrony -y
systemctl enable chronyd
systemctl start chronyd
chronyc sources
```
### 安装 libseccomp
```
wget http://rpmfind.net/linux/centos/8-stream/BaseOS/x86_64/os/Packages/libseccomp-2.5.1-1.el8.x86_64.rpm
yum install libseccomp-2.5.1-1.el8.x86_64.rpm -y
```
验证
```
rpm -qa |grep libseccomp
output:
libseccomp-2.5.1-1.el8.x86_64
```
### 安装 Containerd
下载包
```
# wget https://github.com/containerd/containerd/releases/download/v1.6.18/cri-containerd-cni-1.6.18-linux-amd64.tar.gz
URL 加速
wget https://ghdl.feizhuqwq.cf/https://github.com/containerd/containerd/releases/download/v1.6.10/cri-containerd-1.6.10-linux-amd64.tar.gz
```
解压
```
tar -C / -xzf cri-containerd-1.6.10-linux-amd64.tar.gz
```
将 /usr/local/bin 和 /usr/local/sbin 追加到 PATH 环境变量中：
```
[root@master ~]# echo $PATH
/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/root/bin
```
```
[root@master ~]# containerd -v
containerd github.com/containerd/containerd v1.6.10 770bd0108c32f3fb5c73ae1264f7e503fe7b2661

[root@master ~]# runc -v
runc version 1.1.4
commit: v1.1.4-0-g5fd4c4d1
spec: 1.0.2-dev
go: go1.18.8
libseccomp: 2.5.1
```
### 修改 containerd 默认配置
Containerd 的默认配置文件为 /etc/containerd/config.toml，我们可以通过如下所示的命令生成一个默认的配置：
```
mkdir -p /etc/containerd
containerd config default > /etc/containerd/config.toml
```
对于使用 systemd 作为 init system 的 Linux 的发行版，使用 systemd 作为容器的 cgroup driver 可以确 保节点在资源紧张的情况更加稳定，所以推荐将 containerd 的 cgroup driver 配置为 systemd。

修改前面生成的配置文件 /etc/containerd/config.toml，在plugins."io.containerd.grpc.v1.cri".containerd.runtimes.runc.options 配置块下面将 SystemdCgroup 设置为 true ：
```
[plugins."io.containerd.grpc.v1.cri".containerd.runtimes.runc]
...
  [plugins."io.containerd.grpc.v1.cri".containerd.runtimes.runc.options]
    ...
            SystemdCgroup = true

      [plugins."io.containerd.grpc.v1.cri".containerd.untrusted_workload_runtime]
```
然后再为镜像仓库配置一个加速器，需要在 cri 配置块下面的 registry 配置块下面进行配置 registry.mirrors ：
```
[plugins."io.containerd.grpc.v1.cri"]
  ...
  # sandbox_image = "registry.k8s.io/pause:3.6"
  sandbox_image = "registry.aliyuncs.com/k8sxio/pause:3.8"
  ...
  [plugins."io.containerd.grpc.v1.cri".registry]
    [plugins."io.containerd.grpc.v1.cri".registry.mirrors]
      [plugins."io.containerd.grpc.v1.cri".registry.mirrors."docker.io"]
        endpoint = ["https://bqr1dr1n.mirror.aliyuncs.com"]
```
使配置生效
```
systemctl daemon-reload
systemctl enable containerd --now
```
验证
```
containerd -v

containerd github.com/containerd/containerd v1.6.10 770bd0108c32f3fb5c73ae1264f7e503fe7b2661
```
```
ctr version

Client:
  Version:  v1.6.10
  Revision: 770bd0108c32f3fb5c73ae1264f7e503fe7b2661
  Go version: go1.18.8

Server:
  Version:  v1.6.10
  Revision: 770bd0108c32f3fb5c73ae1264f7e503fe7b2661
  UUID: b2acca82-0694-4df2-890e-93cc9f6c3069
```

```
crictl version

Version:  0.1.0
RuntimeName:  containerd
RuntimeVersion:  v1.6.10
RuntimeApiVersion:  v1
```

## 安装 kubeadm、kubelet、kubectl
使用阿里云的源进行安装
```
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=http://mirrors.aliyun.com/kubernetes/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=0
repo_gpgcheck=0
gpgkey=http://mirrors.aliyun.com/kubernetes/yum/doc/yum-key.gpg
        http://mirrors.aliyun.com/kubernetes/yum/doc/rpm-package-key.gpg
EOF
```
安装 kubeadm、kubelet、kubectl
```
yum makecache fast
# 查看可安装版本
yum list kubectl --showduplicates|grep 1.25

# --disableexcludes 禁掉除了kubernetes之外的别的仓库
yum install -y kubelet-1.25.4 kubeadm-1.25.4 kubectl-1.25.4 --disableexcludes=kubernetes
```

验证+开机自启
```
kubeadm version
kubectl version --client
systemctl enable --now kubelet
```
# 创建成镜像，复制两台做node
## 设置三台机器
hostname
```
hostnamectl set-hostname node1
hostnamectl set-hostname node2
```
重启生效

hosts
```
[root@master ~]# cat /etc/hosts
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6

192.168.122.88  master
192.168.122.221 node1
192.168.122.105 node2
```
# 创建集群
## 修改 kubeadm 配置文件
输出集群初始化默认使用的配置
```
kubeadm config print init-defaults --component-configs KubeletConfiguration > kubeadm.yaml
```
查看需要的镜像
```
[root@master ~]# kubeadm config images list
I0219 23:33:43.205958    4423 version.go:256] remote version is much newer: v1.26.1; falling back to: stable-1.25
registry.k8s.io/kube-apiserver:v1.25.6
registry.k8s.io/kube-controller-manager:v1.25.6
registry.k8s.io/kube-scheduler:v1.25.6
registry.k8s.io/kube-proxy:v1.25.6
registry.k8s.io/pause:3.8
registry.k8s.io/etcd:3.5.5-0
registry.k8s.io/coredns/coredns:v1.9.3
```
预先在各个服务器节点上拉取所 k8s 需要的容器镜像。
```
kubeadm config images pull --config kubeadm.yaml
```
执行错误
```
[root@master ~]# kubeadm config images pull --config kubeadm.yaml
invalid configuration for GroupVersionKind /, Kind=InitConfiguration: kind and apiVersion is mandatory information that must be specified
To see the stack trace of this error execute with --v=5 or higher
```
尝试下面方法
```
[root@master ~]# kubeadm config images pull --image-repository=registry.aliyuncs.com/k8sxio
I0219 23:36:09.944807    4603 version.go:256] remote version is much newer: v1.26.1; falling back to: stable-1.25
[config/images] Pulled registry.aliyuncs.com/k8sxio/kube-apiserver:v1.25.6
[config/images] Pulled registry.aliyuncs.com/k8sxio/kube-controller-manager:v1.25.6
[config/images] Pulled registry.aliyuncs.com/k8sxio/kube-scheduler:v1.25.6
[config/images] Pulled registry.aliyuncs.com/k8sxio/kube-proxy:v1.25.6
[config/images] Pulled registry.aliyuncs.com/k8sxio/pause:3.8
[config/images] Pulled registry.aliyuncs.com/k8sxio/etcd:3.5.5-0
failed to pull image "registry.aliyuncs.com/k8sxio/coredns:v1.9.3": output: E0219 23:36:32.189360    4681 remote_image.go:238] "PullImage from image service failed" err="rpc error: code = NotFound desc = failed to pull and unpack image \"registry.aliyuncs.com/k8sxio/coredns:v1.9.3\": failed to resolve reference \"registry.aliyuncs.com/k8sxio/coredns:v1.9.3\": registry.aliyuncs.com/k8sxio/coredns:v1.9.3: not found" image="registry.aliyuncs.com/k8sxio/coredns:v1.9.3"
time="2023-02-19T23:36:32+08:00" level=fatal msg="pulling image: rpc error: code = NotFound desc = failed to pull and unpack image \"registry.aliyuncs.com/k8sxio/coredns:v1.9.3\": failed to resolve reference \"registry.aliyuncs.com/k8sxio/coredns:v1.9.3\": registry.aliyuncs.com/k8sxio/coredns:v1.9.3: not found"
, error: exit status 1
To see the stack trace of this error execute with --v=5 or higher
```
在拉取 coredns 镜像的时候出错了，没有找到这个镜像，我们可以手动 pull 该镜像，然后重新 tag 下镜像地址即可：
```
# 在node上操作
ctr -n k8s.io i pull docker.io/coredns/coredns:1.9.3
ctr -n k8s.io i tag docker.io/coredns/coredns:1.9.3 registry.aliyuncs.com/k8sxio/coredns:v1.9.3
```
初始化集群
```
kubeadm init --config kubeadm.yaml
```
```
kubeadm init \
--image-repository registry.aliyuncs.com/k8sxio \
--kubernetes-version v1.25.6 \
--pod-network-cidr=10.244.0.0/16 \
--cri-socket /var/run/containerd/containerd.sock
```
```
kubeadm init \
--image-repository registry.aliyuncs.com/k8sxio \
--kubernetes-version v1.25.6 \
--pod-network-cidr=10.244.0.0/16 \
--cri-socket /run/containerd/containerd.sock
```
失败处理
```
journalctl -xeu kubelet
2月 20 00:39:05 master kubelet[6934]: E0220 00:39:05.012927    6934 remote_runtime.go:222] "RunPodSandbox from runtime service failed" err="rpc error: code = Unknown desc = failed to get sandbox image \"registry.k8s.io/paus
2月 20 00:39:05 master kubelet[6934]: E0220 00:39:05.012965    6934 kuberuntime_sandbox.go:71] "Failed to create sandbox for pod" err="rpc error: code = Unknown desc = failed to get sandbox image \"registry.k8s.io/pause:3.6
```
```
# 每台机器都要操作
ctr -n k8s.io i pull registry.aliyuncs.com/k8sxio/pause:3.6
ctr -n k8s.io i tag registry.aliyuncs.com/k8sxio/pause:3.6 registry.k8s.io/pause:3.6
kubeadm reset
重新初始化
```
根据安装提示拷贝 kubeconfig 文件：
```
Your Kubernetes control-plane has initialized successfully!

To start using your cluster, you need to run the following as a regular user:

  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

Alternatively, if you are the root user, you can run:

  export KUBECONFIG=/etc/kubernetes/admin.conf

You should now deploy a pod network to the cluster.
Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
  https://kubernetes.io/docs/concepts/cluster-administration/addons/

Then you can join any number of worker nodes by running the following on each as root:

kubeadm join 192.168.122.88:6443 --token 9xmb00.jgg2ytslgqgavcxc \
        --discovery-token-ca-cert-hash sha256:5dc53c7febabebb55cdd616d6614da055a3c2c2859a3b6128ccb4366ab486342 
```
添加节点
```
[root@master ~]# kubeadm token create --print-join-command
kubeadm join 192.168.122.88:6443 --token 57d01o.hd3y1o1g83sv8nkq --discovery-token-ca-cert-hash sha256:5dc53c7febabebb55cdd616d6614da055a3c2c2859a3b6128ccb4366ab486342 

kubeadm join 192.168.122.88:6443 --token 9xmb00.jgg2ytslgqgavcxc \
        --discovery-token-ca-cert-hash sha256:5dc53c7febabebb55cdd616d6614da055a3c2c2859a3b6128ccb4366ab486342 

[root@master ~]# kubectl get node
NAME     STATUS     ROLES           AGE     VERSION
master   NotReady   control-plane   7m52s   v1.25.6
node1    NotReady   <none>          90s     v1.25.6
node2    NotReady   <none>          50s     v1.25.6
```
### 安装网络插件
#### 安装 flannel
```
wget https://raw.githubusercontent.com/flannel-io/flannel/v0.20.1/Documentation/kube-flannel.yml
```
```
kubectl apply -f kube-flannel.yml
```
## 清理
```
kubeadm reset
ifconfig cni0 down && ip link delete cni0
ifconfig flannel.1 down && ip link delete flannel.1
rm -rf /var/lib/cni/
```
