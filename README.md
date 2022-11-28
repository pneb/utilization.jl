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
