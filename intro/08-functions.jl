# functions

# short form

# positional arguments versus keyword arguments

# function vs methods

# methodswith

# multiple dispatch

# anonymous functions

# map (broadcasting)/reduce/mapreduce

function f1(x)
    output = []
    for i in eachindex(x)
        push!(output, x[i])
    end
end
function f2(x)
    output = Float64[]
    for i in eachindex(x)
        push!(output, x[i])
    end
end
using BenchmarkTools
@benchmark f1(rand(Int(1e5)))
@benchmark f2(rand(Int(1e5)))
f1(["ok since output is Vector{Any}"])
f1(["error since output is Vector{Float64}"])


# functions Exercises

# Make a function `round_number` that rounds a number x as input.
# It should have two methods:
# 1. Float64 should use the `round` function
# 2. Int64 should just return the input (noop)

# Write a function to multiply all the numbers in a vector
