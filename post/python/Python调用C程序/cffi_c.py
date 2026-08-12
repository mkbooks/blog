import cffi

ffi = cffi.FFI()
# 定义C函数的接口
ffi.cdef(
    """
    int add(int a, int b);
"""
)
# 加载动态链接库
lib = ffi.dlopen("./mylib.so")  # 这里假设动态库名为 mylib.so，需要将其放在与Python脚本同一目录下

# 调用C函数
result = lib.add(2, 3)
print(result)
