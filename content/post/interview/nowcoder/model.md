---
title: "牛客网刷题模板"
author: "陈金鑫" 
description : "牛客网刷题模板"
lastmod: 2023-05-06T20:20:30+08:00
date: 2023-05-06T20:20:30+08:00
categories : [              
    "interview",
]
tags : [                   
    "interview",
    "nowcoder"
]
---
## 刷题模板
```python
class Pipe:
    def __init__(self, func):
        self.func = func

    def __ror__(self, other):
        return self.func(other)

    def __call__(self, *args, **kwargs):
        return self.func(*args, **kwargs)


@Pipe
def split_data(datas):
    return [data.split("\\")[-1].split() for data in datas]


@Pipe
def get_error(datas):
    return [data[0][-16:] + " " + data[1] for data in datas]


@Pipe
def get_count(datas):
    result = dict()
    for data in datas:
        result[data] = result.get(data, 0) + 1
    return result


@Pipe
def print_data(datas):
    for key, val in list(datas.items())[-8:]:
        print(key, val)


if __name__ == "__main__":
    datas = []

    while True:
        try:
            data = input()
            if data == "":
                break
            datas.append(data)
        except:
            break

    datas | split_data | get_error | get_count | print_data
```