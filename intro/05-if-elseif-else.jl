# Conditional evaluation
x = 2
y = 3

# if-elseif-else (indentation plays no role)
if x < y
    println("x is less than y")
elseif x > y
println("x is greater than y")
else
        println("x is equal to y")
end

# Three short syntaxes
x < y && "x is less than y"
x < y || "x is not less than y"
x < y ? "x is less than y" : "x is not less than y"

# Exercises
## 1. Test if a number is a multiple of 3, 5 or 7

## 2. Print which quadrant in the Cartesian plane a point is located

# More info at https://docs.julialang.org/en/v1/manual/control-flow/#man-conditional-evaluation