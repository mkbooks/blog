---
title: "Python调用C程序"
author: "陈金鑫"
description : "Python调用C程序"
lastmod: 2023-04-25T13:00:00+08:00
date: 2023-04-25T13:00:00+08:00
tags : [
    "Python",
    "Go"
]
categories : [
    "Python",
    "Go"
]

---

## C程序
mylib.c
```c
#include <stdio.h>

int add(int a, int b) {
    return a + b;
}
```

编译这个 C 文件为共享库：
```shell
gcc -shared -o mylib.so mylib.c
```

### cffi(性能好)
```bash
pip install cffi
```

cffi_c.py
```python
import cffi

ffi = cffi.FFI()
# 定义C函数的接口
ffi.cdef("""
    int add(int a, int b);
""")
# 加载动态链接库
lib = ffi.dlopen("./mylib.so") # 这里假设动态库名为test.so，需要将其放在与Python脚本同一目录下

# 调用C函数
result = lib.add(2, 3)
print(result)
```

运行 Python 程序
```shell
python cffi_c.py

5
```

### ctypes(Python标准库)
ctypes_c.py
```python
import ctypes

# 加载库
mylib = ctypes.CDLL("./mylib.so")

# 定义参数类型和返回值类型
mylib.add.argtypes = (ctypes.c_int, ctypes.c_int)
mylib.add.restype = ctypes.c_int

# 调用 C 函数
result = mylib.add(3, 4)
print(f"3 + 4 = {result}")
```

运行 Python 程序
```shell
python ctypes_c.py

3 + 4 = 7
```
