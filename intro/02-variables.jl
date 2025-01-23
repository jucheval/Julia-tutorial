# Variables

# Integers: Int64
x = 1
typeof(x)

# Rationals : Rational{Int64}
q = 1//3
typeof(q)

# Real Numbers: Float64
y = 3.14
r = 1e3
typeof(r)
## 3 special Float64 values
Inf
eps(Float64)
NaN

# Numerical constants
## Unicode characters (e.g. greek letters) can be used
## write \pi and push Tab
π
## \euler           
ℯ
## π is not a Float.
typeof(π)
## one reason why
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
## string concatenation
"The author is " * name
"Its initials are " * 'J' * 'C'
## + and * convention :
### + is always symmetric, * may be not

# Assignment vs mutation
a = [1,2,3]
b = a
## b points to the same object as a
a[1] = 42
## this is a mutation : hence b changes too
b
a = [4,5,6]
## this is an assignment : b does not change
b

# More info at https://docs.julialang.org/en/v1/manual/variables/
