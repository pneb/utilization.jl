module DeviceInfo
    export Device
    struct Device
        id
    end
    export get_devices

    using Libdl
    const CUDART_LIBM = libdl.dlopen("libcuda.so")
    const cudaGetDeviceCount = Libdl.dlsym(CUDART_LIBM, "cudaGetDeviceCount")
    const cudaGetDeviceProperties = Libdl.dlsym(CUDART_LIBM, "cudaGetDeviceProperties")
    const cudaGetErrorName = Libdl.dlsym(CUDART_LIBM, "cudaGetErrorName")
    const cudaDeviceProp = Cstruct("cudaDeviceProp", :name => Char[], :totalGlobalMem => Cuint, :sharedMemPerBlock => Cuint, :regsPerBlock => Cint, :warpSize => Cint, :memPitch => Cuint, :maxThreadsPerBlock => Cint, :maxThreadsDim => Cint[], :maxGridSize => Cint[], :clockRate => Cint, :totalConstMem => Cuint, :major => Cint, :minor => Cint, :textureAlignment => Cuint, :deviceOverlap => Cint, :multiProcessorCount => Cint, :kernelExecTimeoutEnabled => Cint, :integrated => Cint, :canMapHostMemory => Cint, :computeMode => Cint, :maxTexture1D => Cint, :maxTexture1DMipmap => Cint, :maxTexture1DLinear => Cint, :maxTexture2D => Cint[], :maxTexture2DMipmap => Cint[], :maxTexture2DLinear => Cint[], :maxTexture2DGather => Cint[], :maxTexture3D => Cint[], :maxTexture3DAlt => Cint[], :maxTextureCubemap => Cint, :maxTexture1DLayered => Cint[], :maxTexture2DLayered => Cint[], :maxTextureCubemapLayered => Cint[], :maxSurface1D => Cint, :maxSurface2D => Cint[], :maxSurface3D => Cint[], :maxSurface1DLayered => Cint[], :maxSurface2DLayered => Cint[], :maxSurfaceCubemap => Cint, :maxSurfaceCubemapLayered => Cint[], :surfaceAlignment => Cuint, :concurrentKernels => Cint, :ECCEnabled => Cint, :pciBusID => Cint, :pciDeviceID => Cint, :pciDomainID => Cint, :tccDriver => Cint, :asyncEngineCount => Cint, :unifiedAddressing => Cint, :memoryClockRate => Cint, :memoryBusWidth => Cint, :l2CacheSize => Cint, :maxThreadsPerMultiProcessor => Cint, :streamPrioritiesSupported => Cint, :globalL1CacheSupported => Cint, :localL1CacheSupported => Cint, :sharedMemPerMultiprocessor => Cint, :regsPerMultiprocessor => Cint, :managedMemory => Cint, :isMultiGpuBoard => Cint, :multiGpuBoardGroupID => Cint, :singleToDoublePrecisionPerfRatio => Cfloat, :pageableMemoryAccess => Cint, :concurrentManagedAccess => Cint, :computePreemptionSupported => Cint, :canUseHostPointerForRegisteredMem => Cint, :cooperativeLaunch => Cint, :cooperativeMultiDeviceLaunch => Cint, :pageableMemoryAccessUsesHostPageTables => Cint, :directManagedMemAccessFromHost => Cint)
    const cudaDeviceProp_size = sizeof(cudaDeviceProp)
    const cudaSuccess = 0
    const cudaErrorNoDevice = 100
    const cudaErrorInvalidDevice = 201

    function get_devices()
        (count::Cint, err::Cint) = (0, 0)
        err = Libdl.ccall(cudaGetDeviceCount, Cint, (Ptr{Cint},), count)
        if !(err == cudaSuccess || err == cudaErrorNoDevice)
            error(Int32(err), ": ", string(Cstring(cudaGetErrorName(err))))
        end
        return [get_device(id) for id in 0:count-1]
    end

    function get_device(id::Int)
        err::Cint = 0
        device_prop = cudaDeviceProp()
        err = Libdl.ccall(cudaGetDeviceProperties, Cint, (Ptr{cudaDeviceProp}, Cint), device_prop, Cint(id))
        if err != cudaSuccess
            error(Int32(err), ": ", string(Cstring(cudaGetErrorName(err))))
        end
        return Device(id)
    end
end
