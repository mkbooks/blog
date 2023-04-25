---
title: "Python调用Go程序"
author: "陈金鑫"
description : "Python调用Go程序"
lastmod: 2023-04-25T14:10:00+08:00
date: 2023-04-25T14:10:00+08:00
tags : [
    "Python",
    "Go"
]
categories : [
    "Python",
    "Go"
]

---
## 使用子进程调用 Go 程序
将 Go 程序编译为可执行文件，然后在 Python 脚本中使用 subprocess 模块运行 Go 可执行文件。这是一种简单且通用的方法，但通信可能受到限制，因为它依赖于进程间通信（IPC）。

## 使用 C 扩展
将 Go 函数编译为 C 共享库，然后使用 Python 的 C 扩展（如 ctypes 或 cffi）调用该库。这种方法可能会增加复杂性，但在性能方面可能更优越。

### cffi(性能好)

### ctypes(Python标准库)

## 使用 gRPC 或其他 RPC 框架
创建一个 Go 服务并通过 gRPC（或其他 RPC 框架）公开函数，然后在 Python 中调用该服务。这种方法适用于跨语言和跨平台的通信，但可能需要额外的设置和依赖项。

- https://github.com/chenjinxin1124/grpc-python
- https://github.com/chenjinxin1124/grpc-go
