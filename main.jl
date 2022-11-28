using Pkg
Pkg.add("Distributed")
addprocs(4)

@everywhere using .Utilization
@everywhere using .DeviceInfo

@everywhere function main()
    devices = DeviceInfo.get_devices()
    for (id, device) in enumerate(devices)
        println("GPU$id: $device")
    end

    for device in devices
        println(device)
        println(Utilization.get_utilization(device))
    end
end

main()
