---
title: "安装新系统-Ubuntu"           # 文章标题
author: "陈金鑫"              # 文章作者
description : "安装新系统后需要做的操作"    # 文章描述信息
lastmod: 2022-12-05T20:00:00+08:00        # 文章修改日期
date: 2022-12-05T20:00:00+08:00
tags : [                    # 文章所属标签
    "Ubuntu"
]
categories : [              # 文章所属标签
    "Ubuntu"
]

---
## 系统
ubuntu20.04
```
$ uname -a
Linux cjx 5.15.0-56-generic #62-Ubuntu SMP Tue Nov 22 19:54:14 UTC 2022 x86_64 x86_64 x86_64 GNU/Linux
```
### 安装工具
[Ventoy](https://www.ventoy.net/cn/index.html)
## 系统设置
### ssh 设置
#### 创建秘钥
```
ssh-keygen
```
#### 设置 root 密码
```
sudo passwd
```
#### `sudo`免密
```
sudo -i
visudo
```
在`%sudo   ALL=(ALL:ALL) ALL`的下一行添加`${USER}    ALL=(ALL:ALL) NOPASSWD:ALL`
#### `su root`免密
查看组
```
cjx@cjx:~$ groups
cjx adm cdrom sudo dip plugdev lpadmin lxd sambashare
```
```
su root 
```
给 cjx 用户添加组
```
groupadd wheel
usermod -G wheel cjx
```
修改`su`的配置文件（给 wheel 组设置免密）
```
vim /etc/pam.d/su
```
```
# Uncomment this if you want wheel members to be able to
# su without a password.
auth       required   pam_wheel.so group=wheel 
auth       sufficient pam_wheel.so trust use_uid
```

### 设置网络
#### 火狐
1. 登陆同步服务
2. 设置 SwitchyOmega（使用内网其他可以上网的机器）

### 设置输入法
#### 搜狗输入法
1. [下载](https://shurufa.sogou.com/linux)
2. [安装](https://shurufa.sogou.com/linux/guide)

### 设置上网
#### Qv2ray
1. https://github.com/v2fly/v2ray-core/releases
    1. `unzip v2ray-linux-64.zip`
2. https://github.com/Qv2ray/Qv2ray/releases
    1. `sudo chmod +x ./Qv2ray-refs.tags.v1.99.6-linux.AppImage`
    2. `sudo ./Qv2ray-refs.tags.v1.99.6-linux.AppImage`

如果报错：
```
dlopen(): error loading libfuse.so.2

AppImages require FUSE to run. 
You might still be able to extract the contents of this AppImage 
if you run it with the --appimage-extract option. 
See https://github.com/AppImage/AppImageKit/wiki/FUSE 
for more information
```
安装：`sudo apt install libfuse2`

3. 首选项 -> 内核设置

4. 设置服务器

    0. `sudo v2ray url`
    1. [搬瓦工](https://bwh1.net/index.php)
    2. [腾讯云](https://cloud.tencent.com/)
    3. [阿里云](https://www.aliyun.com)
    4. [谷歌云](https://cloud.google.com/)

5. SwitchyOmega.auto switch.规则列表设置: https://raw.githubusercontent.com/gfwlist/gfwlist/master/gfwlist.txt
#### chrome 浏览器
1. [下载](https://www.google.com/intl/zh-CN/chrome/)
2. 安装: `sudo dpkg -i `

### 设置 oh-my-zsh
[参阅](https://www.jianshu.com/p/ba782b57ae96)

[oh-my-zsh](https://ohmyz.sh/#install)

1. 默认 shell: `echo $SHELL`
2. 系统自带 shell: `cat /etc/shells`

#### 安装 zsh
1. 安装: `sudo apt install zsh -y`
2. 查看是否已添加到 shell: `cat /etc/shells`
    1. 有 zsh 即可
3. 设置 zsh 为默认 shell
    1. 当前用户: `chsh -s /bin/zsh`
    2. root 用户: `sudo chsh -s /bin/zsh`
4. 重启: `sudo reboot`，或注销: `logout`
    1. 选择 2 : 使用推荐配置
5. 查看默认 shell: `echo $SHELL`
    1. 输出`/bin/zsh`表示已修改成功

#### 安装 oh-my-zsh
1. 安装 curl: `sudo apt install curl`
2. 下载 Git: `sudo apt-get install git`
3. 安装 oh-my-zsh: `sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`

#### 个性化
##### 主题
[官方主题网站](https://www.slant.co/topics/7553/~theme-for-oh-my-zsh)

[powerlevel10k](https://github.com/romkatv/powerlevel10k)

[agnosterzak](https://github.com/zakaziko99/agnosterzak-ohmyzsh-theme)

###### powerlevel10k
1. `cd ~/.oh-my-zsh/themes`
2. `git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k`
3. `vi ~/.zshrc`
    1. `ZSH_THEME="powerlevel10k/powerlevel10k"`, 默认: `ZSH_THEME="robbyrussell"`
4. `source ~/.zshrc`
5. `sudo apt install fonts-powerline -y`
###### agnosterzak
1. `cd ~/.oh-my-zsh/themes`
2. `wget https://raw.githubusercontent.com/zakaziko99/agnosterzak-ohmyzsh-theme/master/agnosterzak.zsh-theme`
3. `vi ~/.zshrc`
    1. `ZSH_THEME="agnosterzak"`, 默认: `ZSH_THEME="robbyrussell"`
4. `source ~/.zshrc`
5. `sudo apt install fonts-powerline -y`

> - 如果`ZSH_THEME=""`则不启用任何主题.<br>
> - 如果`ZSH_THEME="random"`，那么每次打开一个新的终端窗口时，电脑会随机选择一个主题使用，<br>
> - `echo $RANDOM_THEME`可输出当前主题名称.<br>
> - 如果你想从你最喜欢的主题列表中选择随机主题，那么`ZSH_THEME="random"`且<br>
> - `ZSH_THEME_RANDOM_CANDIDATES`的值设置为你喜欢的主题名称<br>
> - 例如：`ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )`<br>

##### 插件
###### 自动补全插件 incr
1. `cd ~/.oh-my-zsh/plugins/`
2. `mkdir incr && cd incr`
3. `wget http://mimosa-pudica.net/src/incr-0.2.zsh`
4. `vi ~/.zshrc`
    1. `source ~/.oh-my-zsh/plugins/incr/incr*.zsh`
5. `source ~/.zshrc`

> 提示：
> 与`vim`的提示相冲突的解决方案
> ```
> $ vim t
> _arguments:451: _vim_files: function definition file not found
> ```
> 将~/.zcompdump*删除即可
> 
> `rm -rf ~/.zcompdump*`
> 
> `exec zsh`

###### 直接使用的插件
1. `vi ~/.zshrc`
    1. plugins=(git extract z)
2. `source ~/.zshrc`

1. git 
    1. 默认开启的插件，提供了大量 git 的alias.
    2. 查看 alias: `alias`
2. extract
    1. 功能强大的解压插件，所有类型的文件解压一个命令x全搞定，再也不需要去记tar后面到底是哪几个参数了.
3. z
    1. 强大的目录自动跳转命令，会记忆你曾经进入过的目录，用模糊匹配快速进入你想要的目录.

###### 安装`zsh-autosuggestions`语法历史记录插件
1. `git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions`
2. `vim ~/.zshrc`
```
plugins=(git zsh-autosuggestions)
# 最后一行：（可以不加）
# source $ZSH_CUSTOM/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
```
3. `source ~/.zshrc`

###### 其他
> - [oh-my-zsh插件](https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins)
> - [git插件](https://github.com/ohmyzsh/ohmyzsh/wiki/Plugin:git)
> - 大多数插件包括一个README，它记录了如何使用它们.

##### 其他
1. 更新
- 设置更新日期: `vi ~/.zshrc`
```
export UPDATE_ZSH_DAYS=13
```
- 禁用自动更新: `vi ~/.zshrc`
```
DISABLE_AUTO_UPDATE="true"
```
- 手动更新oh-my-zsh: `upgrade_oh_my_zsh`

2. 卸载
- 卸载`oh-my-zsh`
```
uninstall_oh_my_zsh zsh
```

3. `.zshrc`源文件内容
```
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
  export ZSH="/root/.oh-my-zsh"

1.zsh主题
# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

2.是否自动更新
# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

3.更新周期
# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

4.zsh插件
# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
```


## 安装软件

### VSCode
[下载](https://code.visualstudio.com/Download)

### IDEA
[下载](https://www.jetbrains.com/idea/download/#section=linux)

1. `tar -zxf ideaIU-2020.1.3.tar.gz`
2. `cd idea-IU-201.8538.31/bin/`
3. 安装: `./idea.sh`
4. 设置桌面快捷方式（略）

### PyCharm
[下载](https://www.jetbrains.com/pycharm/download/#section=linux)

1. `tar -zxf pycharm-professional-2020.1.3.tar.gz`
2. `cd idea-IU-201.8538.31/bin/`
3. 安装: `./idea.sh`
4. 设置桌面快捷方式
    1. pycharm_pkg目录下: `bin/pycharm.sh`
    2. tools -> Create desktop entry

### 百度网盘
[下载](https://pan.baidu.com/download#linux)

### 火焰截图
[下载](https://linux265.com/soft/3848.html)

```
sudo apt install flameshot
```

### 微信
[下载](https://www.ubuntukylin.com/applications/106-cn.html)

### 虚拟系统管理器
[下载](https://virt-manager.org/)

1. `sudo apt install virt-manager`
2. `sudo systemctl status libvirtd`
    1. `sudo systemctl enable libvirtd`
    2. `sudo systemctl start libvirtd`
3. `sudo usermod -a -G libvirt ${USER}`
### APIPost
[下载](https://www.apipost.cn/)

### uGet
[下载](https://ugetdm.com/downloads/)

### WPS
[下载](https://linux.wps.cn/)

### VLC 媒体播放器
[下载](https://www.videolan.org/vlc/download-ubuntu.html)

## 添加硬盘
[参考一](https://www.jianshu.com/p/ec5579ef15a6)

[参考二](https://blog.51cto.com/u_15127582/4731125)

1. 查看硬盘状况: `sudo fdisk -l`
2. 分区: `sudo fdisk /dev/sdb`
    1. m: 查看命令
    2. n: 开始分区
        1. 输入分区号1，然后输入大小，默认是一个分区，全部的空间大小
        2. w保存退出
    3. `sudo fdisk -l` 查看是否创建
3. 格式化分区: `sudo mkfs -t ext4 /dev/sdb1`
4. 挂载
    1. sudo mkdir /ssd2
    2. sudo mount /dev/sdb1 /ssd2
5. 自动挂载
    1. `sudo vim /etc/fstab`
        1. `UUID=b543f8f7-579c-45b5-96d6-31de6fa1a55e /ssd2 ext4 defaults 0 2`
        2. `/dev/nvme0n1p1  /ssd2   ext4 defaults 0 2`
6. 修改权限: `sudo chown -R cjx:cjx /ssd2`

## 安装服务

### mkdocs
[Getting Started with MkDocs](https://www.mkdocs.org/getting-started/)

1. `sudo apt update`
2. `sudo apt install python3-pip`
3. `pip install mkdocs`
4. `sudo apt install mkdocs`
5. `pip install mkdocs-material`
6. `mkdocs serve`

### go
[下载](https://golang.google.cn/dl/)

[安装](https://mkbooks.github.io/k8s-mengfanjie/1/2/2/)

```
tar -zxf go*.tar.gz
sudo mv go /usr/local
```
#### 设置环境变量
```
mkdir -p /ssd2/go/{src,pkg,bin}
```
```
sudo vim ~/.bashrc
```
```
export GOROOT=/usr/local/go
export GOPATH=/ssd2/go
export GOPROXY=https://goproxy.cn
```
```
source ~/.bashrc
```
