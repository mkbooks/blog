---
title: "JSON 编码"           # 文章标题
author: "陈金鑫"              # 文章作者
description : "JSON 编码"    # 文章描述信息
lastmod: 2023-02-01       # 文章修改日期
date: 2023-02-01T14:10:00+08:00
tags : [                    # 文章所属标签
    "Python",
    "json"
]
categories : [              # 文章所属标签
    "Python",
    "json"
]
keywords : [                # 文章关键词
    "Python",
    "json"
]

---
# 问题 1
## 操作
```
if __name__ == "__main__":
    name = "陈金鑫"
    logger.info(
        json.dumps(
            {
                "name": name,
                "age": 10,
                "operator_time": time.strftime(
                    "%Y-%m-%d %H:%M:%S",
                    time.localtime((int(round(time.time() * 1000))) / 1000),
                ),
            }
        )
    )
```
print
```
line 48： {"name": "\u9648\u91d1\u946b", "age": 10, "operator_time": "2023-02-01 14:20:35"}
```
## 解决
> 添加：ensure_ascii=False

```
if __name__ == "__main__":
    name = "陈金鑫"
    logger.info(
        json.dumps(
            {
                "name": name,
                "age": 10,
                "operator_time": time.strftime(
                    "%Y-%m-%d %H:%M:%S",
                    time.localtime((int(round(time.time() * 1000))) / 1000),
                ),
            },
            ensure_ascii=False,
        )
    )
```
print
```
line 48： {"name": "陈金鑫", "age": 10, "operator_time": "2023-02-01 14:21:33"}
```
