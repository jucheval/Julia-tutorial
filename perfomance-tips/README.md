# Performance tips

This document is based the [Performance Tips](https://docs.julialang.org/en/v1/manual/performance-tips/) page in the Julia documentation. Most of the sections below are a subset of the sections there. Moreover, all the quotes below come from there. The most simple and efficient tips were selected. If you think that one tip of [Performance Tips](https://docs.julialang.org/en/v1/manual/performance-tips/) should be added below, or conversely, one tip below should be removed, feel free to raise an issue on this repo.

The benchmarks are made thanks to the `@btime` macro of [BenchmarkTools.jl](https://juliaci.github.io/BenchmarkTools.jl/stable/). This macro returns the minimum elapsed time measured during the benchmark (over 10 000 samples if the really fast).

## Under construction

- benchmark the perfomance tips given in the intro and other things.

## Table of Contents

## Use map/reduce/mapreduce

During a for loop over an array, some execution time is consumed by the bounds checking: check that the indices at which you want to get or set a value is indeed within the bounds of the array. These checks can be bypassed via the `@inbounds` macro if you are 100% sure of what you are doing. Most common cases are:

- applying a function `f` element-wise to an array `x`,
- reducing the array `x` via a binary operator `op`.

I respectively recommend to use `map(f, x)` or `reduce(op ,x)`. Look also for `mapreduce(f, op, x)` which is equivalent to `reduce(op, map(f, x))` but usually faster.

Look at [array-loops-advanced.jl](array-loops-advanced.jl).

## Help the compiler to make type inference

Julia compiler is making type inference. It deduces the types of later values from the types of input values.

Look at [type-inference.jl](type-inference.jl).

### Avoid untyped global variables

> The value of an untyped global variable might change at any point, possibly leading to a change of its type.

This makes it difficult for the compiler to infer its type and the type of later values. A good way to avoid this issue is to pass the variable as a function argument.

Look at [untyped-variables.jl](untyped-variables.jl).

### Write "type-stable" functions

> When possible, it helps to ensure that a function always returns a value of the same type.

If, for a fixed argument type, your function returns an `output` of type `T` or `S` depending on some condition on the arguments, then you should consider to use `convert(promote_type(T,S), output)` before returning `output`.

One example is the division operator `/`. One could argue that `4 / 2` should be `2::Int`. However, `x::Int / y::Int` is not an integer in general (for instance `1 / 2`). Hence, `x::Int / y::Int` always returns a `Float64`.

## Avoid containers with abstract type parameters

> When working with parameterized types, including arrays, it is best to avoid parameterizing with abstract types where possible.

For instance, initialize a vector of real numbers by `x = Float64[]` rather than `x = Real[]` if possible. If not, you may even prefer `x = Any[]`to avoid type checking.

Look at [abstract-type.jl](abstract-type.jl).

## Break functions into multiple methods

Julia's writing style is to use multiple method definitions rather than `if` statements devoted to exhaust all possible argument types. For instance, do not write:

```julia
function vecormat(A)
    if A::Vector
        return "vector"
    elseif A::Matrix
        return "matrix"
    else
        error("not a vector or matrix")
    end
end
```

but rather:

```julia
vecormat(A::Vector) = "vector"
vecormat(A::Matrix) = "matrix"
```

The case where `A` is neither a `Vector` or a `Matrix` will throw a `MethodError`.

## Separate kernel functions (aka, function barriers)

related with "Types with values-as-parameters"

## Access arrays in memory order, along columns

## Pre-allocating outputs

## Consider using views for slices (but not always)

## Performance of captured variable
