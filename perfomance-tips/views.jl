using BenchmarkTools
using Random

A = randn(200, 200);
x = randn(100);
inds = shuffle(1:200)[1:100];

xs = randn(50);
start_i = rand(1:151);
inds_i = start_i:(start_i+49);
start_j = rand(1:151);
inds_j = start_j:(start_j+49);

function iteratednn(A, x, depth)
    for _ in 1:depth
        x .= max.(0, A * x)
    end
    argmax(x)
end

println()
println("-----------BENCHMARK-----------")
println()
println("Computations involving several repetitions on the same contiguous 50x50 submatrix of a 200x200 matrix")
print("copy (20 repetitions):"); @btime iteratednn(A[inds_i, inds_j], xs, 20);
print("view (20 repetitions):"); @btime iteratednn(view(A, inds_i, inds_j), xs, 20);
println()
println("Computations involving several repetitions on the same randomly shuffled 100x100 submatrix of a 200x200 matrix")
print("copy (1 repetition): "); @btime iteratednn(A[inds, inds], x, 1);
print("view (1 repetition): "); @btime iteratednn(view(A, inds, inds), x, 1);
print("copy (2 repetitions):"); @btime iteratednn(A[inds, inds], x, 2);
print("view (2 repetitions):"); @btime iteratednn(view(A, inds, inds), x, 2);
print()