using BenchmarkTools

begin

function abstractf()
    x = Real[1,2,π]
    for i in 1:1_000
        push!(x,rand())
    end
end
function anyf()
    x = Any[1,2,π]
    for i in 1:1_000
        push!(x,rand())
    end
end
function concretef()
    x = Float64[1,2,π]
    for i in 1:1_000
        push!(x,rand())
    end
end
 
    println("Pushing 1_000 values in a vector of different type")
    print("Vector{Real}:   "); @btime abstractf()
    print("Vector{Any}:    "); @btime anyf()
    print("Vector{Float64}:"); @btime concretef()
end;
