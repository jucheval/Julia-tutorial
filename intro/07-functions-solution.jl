# Exercises

# 1. Make a function that accepts any Integer except Bool and returns the passed value. If Bool is passed an error should be thrown. You can either:
## a) define only one method (which does not accept Bool)
### The subtypes of Integer are Bool, Signed and Unsigned
fun1(i::Union{Signed, Unsigned}) = i
## b) define two methods (one for Bool and one for the rest). To throw an error you can use
### throw(ArgumentError("Bool is not supported"))
fun2(i::Integer) = i
fun2(::Bool) = throw(ArgumentError("Bool is not supported"))

# 2. Write a function to multiply all the numbers in a vector

function multiply_list(v)
    acc = 1
    for i in v
        acc *= i
    end
    return acc
end
