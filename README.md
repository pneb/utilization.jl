# utilization.jl

This is a package to get GPU utilization in Julia.

## TODO
- [ ] More information

# Build
```sh
julia --project=. -e 'using Pkg; Pkg.instantiate(); Pkg.build(); Pkg.develop(PackageSpec(path=pwd()))'
```

# Run
```sh
julia --project=. --sysimage-native=./sys.so main.jl
```

# Supported Platforms / Device

- [x] Linux
- [x] Windows
- [x] Mac OSX
- [x] NVIDIA Geforce
- [x] NVIDIA Quadro
- [x] NVIDIA Tesla
- [x] NVIDIA Jetson
- [x] NVIDIA Tegra
- [x] NVIDIA Grid
- [x] NVIDIA NVS
- [x] AMD Radeon
- [x] AMD FirePro
- [x] Intel Iris
- [x] Intel HD Graphics
- [x] Intel Xeon Phi
- [x] Intel Xeon
- [x] Intel Core
- [x] ARM Mali
- [x] Imagination PowerVR
- [x] Vivante
- [x] VIA Chrome
- [x] Matrox
- [x] SiS
- [x] XGI
- [x] NVIDIA GRID
