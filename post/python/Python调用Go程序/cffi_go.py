from cffi import FFI

ffi = FFI()
ffi.cdef("void GoFunction();")
go_lib = ffi.dlopen("./go_function.so")
go_lib.GoFunction()
