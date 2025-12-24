import ctypes

# 加载库
mylib = ctypes.CDLL("./mylib.so")

# 定义参数类型和返回值类型
mylib.add.argtypes = (ctypes.c_int, ctypes.c_int)
mylib.add.restype = ctypes.c_int

# 调用 C 函数
result = mylib.add(3, 4)
print(f"3 + 4 = {result}")
