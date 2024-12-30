# Variables

# Integers: Int64
x = 1
typeof(x)

# Rationals : Rational{Int64}
q = 1//3
typeof(q)

# Real Numbers: Float64
y = 3.14
α = 1.
r = 1e3
typeof(r)

# Numerical constants
π
ℯ
## 3 special Float64 values
Inf
eps(Float64)
NaN
## π is not a Float, why ?
typeof(π)
sin(π)
sin(float(π))

# Boolean: Bool
condition = true
typeof(condition)

# Strings: String and Char
name = "Julien"
wrongname = 'Julien'
letter = 'J'
typeof(name)
typeof(letter)

# Assignment vs mutation
a = [1,2,3]
b = a         # b points to the same object as a
a[1] = 42     # mutation : hence b changes too
b
a = 3.14159   # assignment : b does not change
b

# More info at https://docs.julialang.org/en/v1/manual/variables/
