# Performance tips

This document is based the [Performance Tips](https://docs.julialang.org/en/v1/manual/performance-tips/) page in the Julia documentation. Most of the sections below are a subset of the sections there. Moreover, all the quotes below come from there.

The benchmarks are made thanks to the `@btime` macro of [BenchmarkTools.jl](https://juliaci.github.io/BenchmarkTools.jl/stable/). This macro returns the minimum elapsed time measured during the benchmark (over 10 000 samples if the really fast).

## Under construction

- benchmark the perfomance tips given in the intro and other things.

## Table of Contents

## Use map/reduce/mapreduce

## Performance critical code should be inside a function

> Any code that is performance critical should be inside a function. Code inside functions tends to run much faster than top level code, due to how Julia's compiler works.

## Pay attention to memory allocation

## Avoid containers with abstract type parameters

## Be aware of when Julia avoids specializing

## Break functions into multiple definitions

## Write "type-stable" functions

> When possible, it helps to ensure that a function always returns a value of the same type.

It helps Julia compiler to make type inference along your code: it deduces the types of later values from the types of input values. If your function typically returns `normal_output::T` then consider to use `convert(T, anormal_output)`.

## Avoid changing the type of a variable

## Separate kernel functions (aka, function barriers)

related with "Types with values-as-parameters"

## Access arrays in memory order, along columns

## Pre-allocating outputs

## Consider using views for slices (but not always)

## Performance of captured variable
