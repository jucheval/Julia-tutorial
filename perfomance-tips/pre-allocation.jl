using BenchmarkTools

function xinc(x)
    return [x, x+1, x+2]
end;

function loopinc()
    y = 0
    for i = 1:10^4
        ret = xinc(i)
        y += ret[2]
    end
    return y
end;

function xinc!(ret::AbstractVector{T}, x::T) where T
    ret[1] = x
    ret[2] = x+1
    ret[3] = x+2
    nothing
end;

function loopinc_prealloc()
    ret = Vector{Int}(undef, 3)
    y = 0
    for i = 1:10^4
        xinc!(ret, i)
        y += ret[2]
    end
    return y
end;

println()
println("-----------BENCHMARK-----------")
println()
println("10^4 iterations with the computation of a 3-element vector")
print("with new allocation:");@btime loopinc();
print("with pre-allocation:");@btime loopinc_prealloc();
print()