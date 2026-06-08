import ctypes

go_lib = ctypes.CDLL("./go_function.so")
go_lib.GoFunction()
