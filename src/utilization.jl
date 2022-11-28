module Utilization
    using Libdl
    const CUDART_LIBM = libdl.dlopen("libcudart.so")
    const cudaGetDeviceUtilizationRates = Libdl.dlsym(CUDART_LIBM, "cudaGetDeviceUtilizationRates")
    function get_utilization(device)
        (free::Cint, used::Cint) = (0, 0)
        Libdl.ccall(cudaGetDeviceUtilizationRates, Cvoid, (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Cint), free, used, device.id)
        return (free, used)
    end
end
