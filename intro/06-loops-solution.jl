# 1. Write for loops to construct this pattern below:
## * 
## * * 
## * * * 
## * * * * 
## * * * * * 
## * * * * 
## * * * 
## * * 
## *

rows = [] # empty vector
for r in 1:5
    push!(rows, r)
end
for r in 4:-1:1
    push!(rows, r)
end
for r in rows
    println(repeat("* ", r))
end

# 2. If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9.
## The sum of these multiples is 23.
## Find the sum of all the multiples of 3 or 5 that are less or equal than 1000.
N = 1_000
acc = 0
for n in 1:N
    if n % 3 == 0 || n % 5 == 0
        acc += n
    end
end

# 3. Print all natural numbers from 1 to 10 in reverse with a while loop
i = 10
while i >= 1
    println(i)
    i -= 1
end

# 4. Print all natural *even* numbers from 1 to 10 with a while loop
i = 1
while i <= 10
    if i % 2 == 0
        println(i)
    end
    i += 1
end