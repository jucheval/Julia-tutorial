# Functions

# Standard syntax
function function_name()
    return "function output"
end
function_name()

# Short syntax
short_function() = "short function output"
short_function()

# Positional arguments versus keyword arguments
function myprint(x, y)
    println("x = "*string(x)*" and y = "*string(y))
end
myprint(1, 2)
function myprint_with_optional(x, y = 3)
    println("x = "*string(x)*" and y = "*string(y))
end
myprint_with_optional(1)
myprint_with_optional(1, 2)
function myprint_with_kwarg(x, y; key1, key2 = 2)
    println("x = "*string(x)*", y = "*string(y)*", key1 = "*string(key1)*" and key2 = "*string(key2))
end
myprint_with_kwarg(1, 2; key1 = 3)
myprint_with_kwarg(1, 2; key2 = 4, key1 = 2)
## Arguments before the semicolon (;) are positional (sensible to their position)
## Arguments after the semicolon (;) are keywords. Not sensible to position but they must be named

function kwarg_only(; key1, key2)
    println("key1 = "*string(key1)*" and key2 = "*string(key2))
end
kwarg_only(; key2 = 4, key1 = 2)

# Specify argument type, argument::Type
only_for_array(x::Array) = "argument is an Array"
only_for_array([1])
only_for_array(1)

# Function vs methods
## Each (generic) function have several methods depending on the types of the arguments
## Julia searches the method with the closest supertype of the argument
myfunction(x) = "General method"
## same as myfunction(x::Any) = "General method"
myfunction(x::Real) = "Real method"
myfunction(x::Float64) = "Float64 method"
myfunction(3.1)
myfunction(Float32(3.1))
myfunction("3")

# How to search for methods ?
## methods of a function
methods(myfunction)
## methods with a Type
methodswith(Irrational)

# Multiple dispatch
## Julia manages methods for all the arguments of a function
myfunction(x::Int, y::Float64) = "Int first"
myfunction(x::Int, y::Int) = "Int first and it's a match !"
myfunction(x::Float64, y::Int) = "Float64 first"
myfunction(x::Float64, y::Float64) = "Float64 first and it's a match"
myfunction(1, 2.)
myfunction(1, 2)
myfunction(1., 2)
myfunction(1., 2.)

# Anonymous functions
(x -> 2*x)(2)

# map (broadcasting)/reduce/mapreduce
## map and broadcasting (with the dot syntax, see teh second line below) are used to broadcast functions of type T to Vectors{T}
### In other words, Julia executes a for loop without explicitly writing it
map(myfunction, Any[1, 1, 1., 1.], Any[2., 2, 2, 2.])
myfunction.(Any[1, 1, 1., 1.], Any[2., 2, 2, 2.])
### note that Any[..] above is an artifact of the example 
### it is needed otherwise the Int's are converted into Float's and all the outputs are the same

## Julia performance tips recommend map over the broadcasting

## filter extracts the values matching a certain condition
filter(x -> x^2 <= 5, -10:10)
## reduce applies a binary operator iteratively
### sum of the first 10 integers
reduce(+, 1:10)
## mapreduce(f, op, v) is equivalent reduce(op, map(f, v)) but generally faster !!
### sum of the first 10 squares
mapreduce(x -> x^2, +, 1:10)

# ! convention
## function names ending with ! mutates at least one of their arguments
x = [6, 5]
push!(x, 4, 3)
x
append!(x, [2, 1])
x
sort!(x)
x

# Main performance tip
## If possible, specify the type when you initialize an Array
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
## Note that both functions below take arguments of Any type
## but the second one is less general and may end up with an error
f1(["ok since output is Vector{Any}"])
f2(["error since output is Vector{Float64}"])


# Exercises

# 1. Make a function `round_number` that rounds a number x as input.
## It should have two methods:
## a. Float64 should use the `round` function
## b. Int64 should just return the input

# 2. Write a function to multiply all the numbers in a vector

# More info at https://docs.julialang.org/en/v1/manual/functions/