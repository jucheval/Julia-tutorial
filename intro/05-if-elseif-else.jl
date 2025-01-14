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
## Evaluates the expression after && if the condition before is true. Otherwise, returns false.
x < y || "x is not less than y"
## Evaluates the expression after || if the condition before is false. Otherwise, returns true.
x < y ? "x is less than y" : "x is not less than y"
## Evaluates the first expression if the condition is true and the second expression otherwise.

# Exercises
## 1. Test if a number is a multiple of 3, 5 or 7

## 2. For a given variable x, print "x is an Integer", "x is a non Integer Real number", or "x is not a Real number" depending on x's type (not on its value)

# More info at https://docs.julialang.org/en/v1/manual/control-flow/#man-conditional-evaluation