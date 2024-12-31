# Exercises

# 1. Make a function `round_number` that rounds a number x as input.
## It should have two methods:
## a. Float64 should use the `round` function
## b. Int64 should just return the input

function round_number(x::Float64)
    return round(x)
end

function round_number(x::Int64)
    return x
end

# 2. Write a function to multiply all the numbers in a vector

function multiply_list(v)
    acc = 1
    for i in v
        acc *= i
    end
    return acc
end
