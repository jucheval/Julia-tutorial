typeof(x -> x^2)
typeof(x -> x^2)
# At each call, Julia creates a new anonymous function. Their type is different.

@time sum(x -> x^2, 1:10^6);
@time sum(x -> x^2, 1:10^6);
# Compilation is triggered at each call. This is not efficient.

# To avoid this, the most efficient is to put this call in a function
fsum(vec) = sum(x -> x^2, vec)
@time fsum(1:10^6);
@time fsum(1:10^6);

# Alternatively, we can define the anonymous function before the call
f = x -> x^2
@time sum(f, 1:10^6);
@time sum(f, 1:10^6);

