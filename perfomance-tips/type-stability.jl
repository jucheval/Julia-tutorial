using BenchmarkTools

function unstable()
    x = 0.
    for i in 1:10_000
        x = Int64(i)
        x = Int16(i+1)
        x = Int32(i-1)
        x = float(i-2)
    end
end
function stable()
    x = 0.
    for i in 1:10_000
        x = float(i)
        x = float(i+1)
        x = float(i-1)
        x = float(i-2)
    end
end

begin
    println()
    print("stable:  ");@btime stable();
    print("unstable:");@btime unstable();
end