# 1: Test if a number is a multiple of 3, 5 or 7
number = rand(1:100)

if number % 3 == 0
    println("Number is a multiple of 3")
elseif number % 5 == 0
    println("Number is a multiple of 5")
elseif number % 7 == 0
    println("Number is a multiple of 7")
else
    println("Number is not a multiple of 3, 5 or 7")
end

# 2: Print which quadrant in the Cartesian plane a point is located
x = 1.

if typeof(x)<:Integer
    println("x is an Integer")
elseif typeof(x)<:Real
    println("x is a non Integer Real number")
else
    println("x is not a Real number")
end
