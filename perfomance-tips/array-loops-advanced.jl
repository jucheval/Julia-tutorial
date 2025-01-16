using BenchmarkTools

a = rand(100,100)

# map and broadcast use the @inbounds macro to avoid bounds checking
# hence I added the @inbounds to the explicit loops in order to have a fair comparison
## The results are quite different without the @inbounds macro

## Assignment functions
function row_col_loop(a::AbstractArray)
    output = similar(a)
    nrows, ncols = size(a)
    @inbounds for row in 1:nrows
        for col in 1:ncols
            output[row, col] = a[row, col]^2
        end
    end
end
function col_row_loop(a::AbstractArray)
    output = similar(a)
    nrows, ncols = size(a)
    @inbounds for col in 1:ncols
        for row in 1:nrows
            output[row, col] = a[row, col]^2
        end
    end
end
function length_loop(a::AbstractArray)
    output = similar(a)
    @inbounds for i in 1:length(a)
        output[i] = a[i]^2
    end
end
function eachindex_loop(a::AbstractArray)
    output = similar(a)
    @inbounds for id in eachindex(a)
        output[id] = a[id]^2
    end
end
function broadcast_loop(a::AbstractArray)
    output = broadcast(x->x^2, a)
end
function dot_broadcast_loop(a::AbstractArray)
    output = a .^ 2
end
function map_loop(a::AbstractArray)
    output = map(x->x^2, a)
end
function comprehension_loop(a::AbstractArray)
    output = [x^2 for x in a]
end

## Mutation functions
function row_col_loop!(a::AbstractArray)
    nrows, ncols = size(a)
    @inbounds for row in 1:nrows
        for col in 1:ncols
            a[row, col] = a[row, col]^2
        end
    end
end
function col_row_loop!(a::AbstractArray)
    nrows, ncols = size(a)
    @inbounds for col in 1:ncols
        for row in 1:nrows
            a[row, col] = a[row, col]^2
        end
    end
end
function eachindex_loop!(a::AbstractArray)
    @inbounds for id in eachindex(a)
        a[id] = a[id]^2
    end
end
function length_loop!(a::AbstractArray)
    @inbounds for i in 1:length(a)
        a[i] = a[i]^2
    end
end
function broadcast_loop!(a::AbstractArray)
    broadcast!(x->x^2, a, a)
end
function dot_broadcast_loop!(a::AbstractArray)
    a .= a .^ 2
end
function map_loop!(a::AbstractArray)
    map!(x->x^2, a, a)
end
function comprehension_loop!(a::AbstractArray)
    a .= [x^2 for x in a]
end

begin
    println()
    println("Compute element-wise square of a 100x100 matrix in a new matrix")
    print("row -> col:    "); @btime row_col_loop(a);
    print("col -> row:    "); @btime col_row_loop(a);
    print("eachindex:     "); @btime eachindex_loop(a);
    print("length:        "); @btime length_loop(a);
    print("broadcast:     "); @btime broadcast_loop(a);
    print("dot broadcast: "); @btime dot_broadcast_loop(a);
    print("map:           "); @btime map_loop(a);
    print("comprehension: "); @btime comprehension_loop(a);
    print("row -> col!:   "); @btime row_col_loop!(a);
    print("col -> row!:   "); @btime col_row_loop!(a);
    print("eachindex!:    "); @btime eachindex_loop!(a);
    print("length!:       "); @btime length_loop!(a);
    print("broadcast!:    "); @btime broadcast_loop!(a);
    print("dot broadcast!:"); @btime dot_broadcast_loop!(a);
    print("map!:          "); @btime map_loop!(a);
    print("comprehension!:"); @btime comprehension_loop!(a);
end


function sum_loop(a::AbstractArray)
    output = zero(eltype(a))
    @inbounds for x in a
        output += x
    end
    return output
end

begin
    println()
    println("Compute the sum of a 100x100 matrix")
    print("sum (alias of reduce(+,x)):");@btime sum(a); # in fact + is replace by add_sum
    print("reduce:");@btime reduce(+, a);
    print("loop:");@btime sum_loop(a);
end
