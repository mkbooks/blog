---
title: "Python 实现 Linux 的 'df -h' 命令"           # 文章标题
author: "陈金鑫"              # 文章作者
description : "Python 实现 Linux 的 'df -h' 命令"    # 文章描述信息
lastmod: 2020-08-15        # 文章修改日期
date: 2022-08-15T17:03:18+08:00
tags : [                    # 文章所属标签
    "Python",
    "Linux",
    "磁盘"
]
categories : [              # 文章所属标签
    "Python",
]

---
参考: https://developer.aliyun.com/article/53579

mycode
```
import os
import math

if __name__ == '__main__':
    vfs = os.statvfs("/home/manager")
    g = 1024 * 1024 * 1024

    # 总容量
    k_blocks = vfs.f_bsize * vfs.f_blocks / g
    # Used,使用量，总容量减去空闲容量
    used = vfs.f_bsize * (vfs.f_blocks - vfs.f_bfree) / g
    # Available，有效容量
    available = vfs.f_bsize * vfs.f_bavail / g
    # use%,使用量，%,round(浮点数，精确到小数点后的位数）
    use = round(used / (used + available) * 100, 2)
    
    print({
        "容量": k_blocks,
        "已用": used,
        "可用": available,
        "已用%": use,
    })

    print({
        "容量": f'{math.ceil(k_blocks)}G',
        "已用": f'{math.ceil(used)}G',
        "可用": f'{math.ceil(available)}G',
        "已用%": f'{math.ceil(use)}%',
    })
```
运行测试
```
$ df -h /home/manager
文件系统        容量  已用  可用 已用% 挂载点
/dev/nvme0n1p2  457G  325G  110G   75% /
```
```
python test.py
{'容量': 456.8854446411133, '已用': 324.40053939819336, '可用': 109.20629501342773, '已用%': 74.81}
{'容量': '457G', '已用': '325G', '可用': '110G', '已用%': '75%'}
```