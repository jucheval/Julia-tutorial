using BenchmarkTools

global x = rand(1000);

function sum_global()
    s = 0.0
    for i in x
        s += i
    end
    return s
end;
function sum_global_annotated()
    s = 0.0
    for i in x::Vector{Float64}
        s += i
    end
    return s
end;
function sum_local(x)
    s = 0.0
    for i in x
        s += i
    end
    return s
end;
function sum_local_annotated(x)
    s = 0.0
    for i in x::Vector{Float64}
        s += i
    end
    return s
end;

println()
println("-----------BENCHMARK-----------")
println()
println("Sum over a vector")
print("global vector:          "); @btime sum_global();
print("global vector annotated:"); @btime sum_global_annotated();
print("local vector:           "); @btime sum_local(x);
print("local vector annotated: "); @btime sum_local_annotated(x);


x = rand(10_000);

function mutateglobal()
    for i in eachindex(x::Vector)
        x[i] = rand() 
    end
end
function mutatelocal(x)
    for i in eachindex(x::Vector)
        x[i] = rand() 
    end
end

println()
println("-----------BENCHMARK-----------")
println()
println("Mutating a vector")
print("global mutation:"); @btime mutateglobal();
print("local mutation: "); @btime mutatelocal(x);