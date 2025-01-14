# For loops

# Iterators (range)
## start:end, step = 1
1:10
## start:step:end
1:.5:20
## note that the range has type Float64

## They are not Vectors. 
### Use collect to get the associated vector
collect(1:10)
### however this is not recommended because of the memory size
sizeof(1:1_000_000)
sizeof(collect(1:1_000_000))

# For loops
for n in [1, 2, 5, 7]
    println(n)
end
for n ∈ 0:1_000:10_000 # \in + tab
    println(n)
end
## enumerate
for (id, value) in enumerate(["a", "b", "c"])
    println( (id, value) )
end
## to explore an Array, Julia doc recommends to use eachindex (way faster, see below)
a = reshape(1:8, (2,2,2))
for id in eachindex(a)
    println(a[id])
end
## this enumeration is coherent with the filling order and the faster exploration order, 
## that is the inner most loop correspond to rows, and so on...
for tube in 1:2
    for col in 1:2
        for row in 1:2
            println(a[row, col, tube])
        end
    end
end
## some benchmarks
include("../perfomance-tips/array-loops.jl")

# While loops
i = 1
while i < 5
    println(i)
    i += 1
end

# Exercises
# 1. Write a Julia program to construct this pattern below:
## * 
## * * 
## * * * 
## * * * * 
## * * * * * 
## * * * * 
## * * * 
## * * 
## *

# 2. If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9.
## The sum of these multiples is 23.
## Find the sum of all the multiples of 3 or 5 that are less or equal than 1000.

# 3. Print all natural numbers from 1 to 10 in reverse

# 4. Print all natural *even* numbers from 1 to 10

# More info at https://docs.julialang.org/en/v1/manual/control-flow/#man-loops