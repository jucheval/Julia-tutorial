# Exercise : Meta Types ?
## What is the type of Int ? What is the type of Union{Int64,Int32} ?
typeof(Int)     # All types have type DataType
typeof(Union{Int64, Int32})     # finite unions of types have type Union

## What is the type of Vector ? What is the type of Vector{Int} ? Why ?
typeof(Vector)   # Vector is the infinite union of Vector{T} for all types T
typeof(Vector{Int}) # Vector{Int} is one particular type

# Note that Array{Int} is also UnionAll: it is the infinite union of Array{Int,n} for all integer n
typeof(Array{Int})