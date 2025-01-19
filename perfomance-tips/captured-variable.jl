using BenchmarkTools

function abmult(r::Int)
    if r < 0
        r = -r
    end
    f = x -> x * r
    return f
end

function abmult_annotated(r0::Int)
    r::Int = r0
    if r < 0
        r = -r
    end
    f = x -> x * r
    return f
end

println()
println("-----------BENCHMARK-----------")
println()
println("Closure with captured variable")
print("naive code:          ");@btime [abmult(rand(Int))(rand(Int)) for _ in 1:10];
print("with type annotation:");@btime [abmult_annotated(rand(Int))(rand(Int)) for _ in 1:10];
print()