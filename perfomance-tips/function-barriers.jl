using BenchmarkTools
    
function unknown_typed_twos(n)
    a = Vector{rand(Bool) ? Int64 : Float64}(undef, n)
    for i = 1:n
        a[i] = 2
    end
    return a
end;

function fill_twos!(a)
    for i = eachindex(a)
        a[i] = 2
    end
end;
function known_typed_twos(n)
    a = Vector{rand(Bool) ? Int64 : Float64}(undef, n)
    fill_twos!(a)
    return a
end;

println()
println("-----------BENCHMARK-----------")
println()
println("Fill a vector of 2s with unknown type")
print("as one function: ");@btime unknown_typed_twos(10^4);
print("as two functions:");@btime known_typed_twos(10^4);
println("The core function fill_twos! is faster than the loop in unknown_typed_twos because of type instability in the latter")