using BenchmarkTools

a = reshape(100,100)

function row_col_loop(a::AbstractArray)
    nrows, ncols = size(a)
    output = zeros(nrows, ncols)
    for row in 1:nrows
        for col in 1:ncols
            output[row, col] = a[row, col]^2
        end
    end
end
function col_row_loop(a::AbstractArray)
    nrows, ncols = size(a)
    output = zeros(nrows, ncols)
    for col in 1:ncols
        for row in 1:nrows
            output[row, col] = a[row, col]^2
        end
    end
end
function eachindex_loop(a::AbstractArray)
    nrows, ncols = size(a)
    output = zeros(nrows, ncols)
    for id in eachindex(output)
        output[id] = a[id]^2
    end
end
println("Compute element-wise square of a 100x100 matrix in a new matrix")
print("row -> col:"); @btime row_col_loop(a);
print("col -> row:"); @btime col_row_loop(a);
print("eachindex: "); @btime eachindex_loop(a);
println("The eachindex loop is slower than the col -> row loop because of bounds checking (see the file array-loops-advanced.jl for more details)")
println("FYI, the balance of speed is inverted when we mutate the input matrix instead of creating a new one")