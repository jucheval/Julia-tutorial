# Boolean operators
## Convention : all the Bool written in these files evaluate to true

# && (AND)
true && true
## & corresponds to bitwise AND

# || (OR)
true || false
## | corresponds to bitwise OR

# ! (NOT)
!false
## ~ corresponds to bitwise NOT

# Numerical comparisons
1 ≤ 1
1 < 2 < 3
(2 < 1) || (3. < 6.4)
1 == 1.
1 == true
!( 1 === 1. )
## === test the exact equality (in particular they must have same type)

# More info at https://docs.julialang.org/en/v1/manual/mathematical-operations/#Boolean-Operators
# and https://docs.julialang.org/en/v1/manual/mathematical-operations/#Numeric-Comparisons