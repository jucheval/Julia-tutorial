using BenchmarkTools
using Random

A = randn(200, 200);
x = randn(100);
inds = shuffle(1:200)[1:100];

function iteratednn(A, x, depth)
    for _ in 1:depth
        x .= max.(0, A * x)
    end
    argmax(x)
end

println()
println("-----------BENCHMARK-----------")
println()
println("Computations involving several times the same 100x100 submatrix of a 200x200 matrix")
print("copy (1 time): "); @btime iteratednn(A[inds, inds], x, 1);
print("view (1 time): "); @btime iteratednn(view(A, inds, inds), x, 1);
print("copy (2 times):"); @btime iteratednn(A[inds, inds], x, 2);
print("view (2 times):"); @btime iteratednn(view(A, inds, inds), x, 2);
print("copy (3 times):"); @btime iteratednn(A[inds, inds], x, 3);
print("view (3 times):"); @btime iteratednn(view(A, inds, inds), x, 3);
print()