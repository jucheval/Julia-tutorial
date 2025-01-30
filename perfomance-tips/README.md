# Performance tips

This document is based the [Performance Tips](https://docs.julialang.org/en/v1/manual/performance-tips/) page in the Julia documentation. Most of the sections below are a subset of the sections there. Moreover, all the quotes below come from there. The most simple and efficient tips were selected. If you think that one tip of [Performance Tips](https://docs.julialang.org/en/v1/manual/performance-tips/) should be added below, or conversely, one tip below should be removed, feel free to raise an issue on this repo.

The benchmarks are made thanks to the `@btime` macro of [BenchmarkTools.jl](https://juliaci.github.io/BenchmarkTools.jl/stable/). This macro returns the minimum elapsed time measured during the benchmark (over 10 000 samples if the really fast).

Each tip is illustrated via a Julia script file. All of them can be called from [call.jl](call.jl). The link after the section name is an hyperlink to the corresponding section in [Performance Tips](https://docs.julialang.org/en/v1/manual/performance-tips/).

## Table of Contents

- [Use map/reduce/mapreduce](#use-mapreducemapreduce)
- [Access arrays in memory order, along columns](#access-arrays-in-memory-order-along-columns-link)
- [Pre-allocating outputs](#pre-allocating-outputs-link)
- [Help the compiler to make type inference](#help-the-compiler-to-make-type-inference)
  - [Avoid untyped global variables](#avoid-untyped-global-variables-link)
  - [Write "type-stable" functions](#write-type-stable-functions-link)
  - [Avoid containers with abstract type parameters](#avoid-containers-with-abstract-type-parameters-link)
  - [Separate kernel functions (aka, function barriers)](#separate-kernel-functions-aka-function-barriers-link)
  - [Anonymous functions get unique types in global scope](#anonymous-functions-get-unique-types-in-global-scope)
- [Break functions into multiple methods](#break-functions-into-multiple-methods-link)
- [Performance of captured variable](#performance-of-captured-variable-link)
- [Consider using views for slices (but not always)](#consider-using-views-for-slices-but-not-always-link)

## Use map/reduce/mapreduce

During a for loop over an array, some execution time is consumed by the bounds checking: check that the indices at which you want to get or set a value is indeed within the bounds of the array. These checks can be bypassed via the `@inbounds` macro if you are 100% sure of what you are doing. Most common cases are:

- applying a function `f` element-wise to an array `x`,
- reducing the array `x` via a binary operator `op`.

I respectively recommend to use `map(f, x)` or `reduce(op ,x)`. Look also for `mapreduce(f, op, x)` which is equivalent to `reduce(op, map(f, x))` but usually faster.

Call and/or see [array-loops-advanced.jl](array-loops-advanced.jl).

## Access arrays in memory order, along columns ([link](https://docs.julialang.org/en/v1/manual/performance-tips/#man-performance-column-major))

If the previous tip does not apply, you should consider this one.

> Multidimensional arrays in Julia are stored in column-major order. This means that arrays are stacked one column at a time. This can be verified using the vec function or the syntax [:] as shown below (notice that the array is ordered [1 3 2 4], not [1 2 3 4]):

In particular, you should consider the column-major order when designing the dimensions of an array.

Call and/or see [array-loops.jl](array-loops.jl).

## Pre-allocating outputs ([link](https://docs.julialang.org/en/v1/manual/performance-tips/#Pre-allocating-outputs))

Usually, functions allocate a new variable for their output. Instead, you can assign the output of a function to a pre-allocated variable. For instance,

- `map(f, a)` allocates a new array `b` with the same sizes as `a` by applying `f` element-wise; or
- if an array `b` is pre-allocated, then `map!(f, b, a)` fills it with `f` applied element-wise to `a` (for instance, consider `map!(f, a, a)` to change `a` directly).

Call and/or see [pre-allocation.jl](pre-allocation.jl)

## Help the compiler to make type inference

Julia compiler is making type inference. It deduces the types of later values from the types of input values.

See [type-inference.jl](type-inference.jl).

### Avoid untyped global variables ([link](https://docs.julialang.org/en/v1/manual/performance-tips/#Avoid-untyped-global-variables))

> The value of an untyped global variable might change at any point, possibly leading to a change of its type.

This makes it difficult for the compiler to infer its type and the type of later values. A good way to avoid this issue is to pass the variable as a function argument.

Call and/or see [untyped-variables.jl](untyped-variables.jl).

### Write "type-stable" functions ([link](https://docs.julialang.org/en/v1/manual/performance-tips/#Write-%22type-stable%22-functions))

> When possible, it helps to ensure that a function always returns a value of the same type.

If, for a fixed argument type, your function returns an `output` of type `T` or `S` depending on some condition on the arguments, then you should consider to use `convert(promote_type(T,S), output)` before returning `output`.

One example is the division operator `/`. One could argue that `4 / 2` should be `2::Int`. However, `x::Int / y::Int` is not an integer in general (for instance `1 / 2`). Hence, `x::Int / y::Int` always returns a `Float64`.

### Avoid containers with abstract type parameters ([link](https://docs.julialang.org/en/v1/manual/performance-tips/#man-performance-abstract-container))

> When working with parameterized types, including arrays, it is best to avoid parameterizing with abstract types where possible.

For instance, initialize a vector of real numbers by `x = Float64[]` rather than `x = Real[]` if possible. If not, you may even prefer `x = Any[]`to avoid type checking.

Call and/or see [abstract-type.jl](abstract-type.jl).

### Separate kernel functions (aka, function barriers) ([link](https://docs.julialang.org/en/v1/manual/performance-tips/#kernel-functions))

> Many functions follow a pattern of performing some set-up work, and then running many iterations to perform a core computation. Where possible, it is a good idea to put these core computations in separate functions.

The example in [function-barriers.jl](function-barriers.jl) follows this pattern:

- a random type is chosen in the set-up,
- then core computations are done using this **fixed** (random) type.

Then, we see that it is beneficial to make two functions so that the core computations can specialize to the chosen type.

Call and/or see [function-barriers.jl](function-barriers.jl).

### Anonymous functions get unique types in global scope

Each time you use an anonymous function in global scope, it is assigned a new and unique type. Hence, compilation may be triggered more than necessary.

See [anonymous-functions.jl](anonymous-functions.jl)

## Break functions into multiple methods ([link](https://docs.julialang.org/en/v1/manual/performance-tips/#Break-functions-into-multiple-definitions))

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

## Performance of captured variable ([link](https://docs.julialang.org/en/v1/manual/performance-tips/#man-performance-captured))

> Consider the following example that defines an inner function:
>
>```julia
>function abmult(r::Int)
>    if r < 0
>        r = -r
>    end
>    f = x -> x * r
>    return f
>end
>```
>
>Function `abmult` returns a function `f` that multiplies its argument by the absolute value of `r`. The inner function assigned to `f` is called a "closure".

As of Julia 1.11, the variable `r` in the closure is assigned the type `Any` which causes a loss of performance. To circumvent this, one can annotate the type of `r`.

Call and/or see [captured-variable.jl](captured-variable.jl).

> Note that this is a rapidly evolving aspect of the compiler, and it is likely that future releases will not require this degree of programmer annotation to attain performance.

## Consider using views for slices (but not always) ([link](https://docs.julialang.org/en/v1/manual/performance-tips/#man-performance-views))

> In Julia, an array "slice" expression like `array[1:5, :]` creates a copy of that data (except on the left-hand side of an assignment, where `array[1:5, :] = ...` assigns in-place to that portion of array).

This is good or not depending on your objective:

- Many repetitions on the slice -> **good**, because it is more efficient to work with a smaller contiguous copy.
- Few repetitions on the slice -> **bad**, because the cost of the allocation and copy operations can be substantial.

> An alternative is to create a "view" of the array, which is an array object (a `SubArray`) that actually references the data of the original array in-place, without making a copy. This can be done for individual slices by calling `view`, or more simply for a whole expression or block of code by putting `@views` in front of that expression.

Two examples are included in [views.jl](views.jl):

- the subarray is contiguous -> `view` seems faster in any case;
- the coordinates of the subarray are randomly shuffled -> `view` is faster only in the case of 1 repetition.

Call and/or see [views.jl](views.jl).
