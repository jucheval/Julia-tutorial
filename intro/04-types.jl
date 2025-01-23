# Types are organized as a tree
using GraphRecipes, Plots
plot(Integer, method=:tree, fontsize=7, nodeshape=:rect)
## the leaves are Concrete types. Any object has a concrete type
## the inner nodes are Abstract types. They describe the relations between types

# Navigate the tree : supertypes, supertype, and subtypes
supertypes(Integer)
subtypes(Integer)

# Comparisons
Bool <: Integer
1 isa Integer
## "<:" and "isa" above have "operator syntax"
## but any operator can be written as a regular functions
isa(1, Number)

# AbstractFloat vs Float64, Float32
x = 1.0
x isa AbstractFloat
y = Float32(1)
y isa AbstractFloat
!(y isa Float64)
## their memory sizes are different
sizeof(x)
sizeof(y)

# Vector{Type}
x_vec = [1, 2, 3, 4]

# Matrix{Type}
x_mat = [1 2; 3 4]
## vectors are columns
x_vec == [1; 2; 3; 4]
## and not rows
x_vec != [1 2 3 4]
## matrix product vs element-wise product
x_mat * x_mat
x_mat .* x_mat

# It's all Array{Type, N}
Vector{Int64}
Vector
Matrix
## ways to construct Arrays
[i^2 for i in 1:10]
ones(4)
zeros(2, 3)
fill("a", (2, 2, 2))
rand(2, 3)
reshape([1, 2, 3, 4], (2, 2))
## all values in an Array must have the same type
[1, 2]
[1, 2.0]
["a", true]
### the chosen type may be the first common ancestor in the types tree
### but sometimes conversion applies
# Promotion and conversion
## Julia makes automatic conversions during numeric operations
## for instance, before summing a Float32 and a Float64, Julia converts the Float32 to a Float64

## More info at https://docs.julialang.org/en/v1/manual/arrays/

# Tuple and NamedTuple
## variables of different types usually are stored in Tuples
tuple = ("a", true)
## accessed like Vectors
tuple[1]
## but they are not mutable
tuple[1] = "b"
typeof(tuple)   # each type is specified
## some functions return a Tuple
(nrow, ncol) = size(x_mat)
## or
nrow, ncol = size(x_mat)
nrow
## there is also NamedTuples, very neat to define parameters (see DrWatson package)
namedtuple = (a=1, b=3)

# More info at https://docs.julialang.org/en/v1/manual/types/