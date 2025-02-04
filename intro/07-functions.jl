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
## Arguments before the semicolon (;) are positional. Sensible to position and cannot be named.
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
myfunction(x::Int, y::Int) = "Int first and it's a match!"
myfunction(x::Float64, y::Int) = "Float64 first"
myfunction(x::Float64, y::Float64) = "Float64 first and it's a match!"
myfunction(1, 2.0)
myfunction(1, 2)
myfunction(1.0, 2)
myfunction(1.0, 2.0)

# Anonymous functions
(x -> 2 * x)(2)

# map (broadcasting)/reduce/mapreduce
## map, broadcasting (with the dot syntax, see the second line below) and comprehension 
## are used to broadcast functions with argument of type T to Vectors{T}
### In other words, Julia executes a for loop without explicitly writing it
map(myfunction, Any[1, 1, 1.0, 1.0], Any[2.0, 2, 2.0, 2])
myfunction.(Any[1, 1, 1.0, 1.0], Any[2.0, 2, 2.0, 2])
reshape([myfunction(x, y) for y in Any[2.0, 2], x in Any[1, 1.0]], (4))
### note that Any[..] above is an artifact of the example 
### it is needed otherwise the Int's are converted into Float's and all the outputs are the same
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

# JIT compilation
function JITexample(x)
    s = 0.0
    for i in x
        s += i
    end
    return s
end
@time JITexample(rand(100_000));
@time JITexample(rand(100_000));
## The two times are equivalent. The function JITexample is not compiled yet
x = rand(100_000);
@time JITexample(x);
## This time, JIT compilation applies and time is larger
x = rand(100_000);
@time JITexample(x);
## This time, the function is compiled and time is smaller
### The compilation is specialized for the type of x (Vector{Float64} here)
### If you apply it to an other type (Vector{Int}, Matrix{Float64}, etc.), JIT compilation applies again
### For instance,
x = rand(Int,1_000);
@time JITexample(x);
@time JITexample(x);

# Exercises

# 1. Make a function that accepts any Integer except Bool and returns the passed value. If Bool is passed an error should be thrown. You can either:
## a) define only one method (which does not accept Bool)
## b) define two methods (one for Bool and one for the rest). To throw an error you can use
### throw(ArgumentError("Bool is not supported"))

# 2. Write a function to multiply all the numbers in a vector

# More info at https://docs.julialang.org/en/v1/manual/functions/