using BenchmarkTools

# Simple usage
@benchmark sin(1)
@benchmark sort(1:100)

# Terminology
## benchmark: a collection of N samples. Its summary statistics (min, median, mean, max) are displayed.
## sample: a single time/memory measurement obtained by averaging over M evaluations.
## evaluation: a single execution of the benchmark expression.

# Misleading usage
@benchmark sort(rand(10))
## The benchmark is not accurate because the generation of the input is included in the benchmark
## Two solutions:
@benchmark sort($(rand(10)))
@benchmark sort(data) setup=(data=rand(10))
## The generation of the input is not included in the benchmark

# Benchmark using a global variable without modifying it
A = zeros(4)
@benchmark fill!($(copy(A)), 1)

# More info at https://juliaci.github.io/BenchmarkTools.jl/stable/
