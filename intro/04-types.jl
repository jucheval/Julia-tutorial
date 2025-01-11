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
isa(1,Number)

# AbstractFloat vs Float64, Float32
x = 1.
x isa AbstractFloat
y = Float32(1)
y isa AbstractFloat
!( y isa Float64 )
## their memory sizes are different
Base.summarysize(x)
Base.summarysize(y)

# Vector{Type}
x_vec = [1, 2, 3, 4]

# Matrix{Type}
x_mat = [1 2; 3 4]
## vectors are columns
x_vec == [1;2;3;4]
## and not rows
x_vec != [1 2 3 4]

# It's all Array{Type, N}
## There is also an AbstractArray type. It contains types that behave like arrays but are not the basic type Array
subtypes(AbstractArray)

# All values in an Array must have the same type
[1, 2]
[1, 2.]
["a", true]
## the chosen type may be the first common ancestor in the types tree
## but sometimes conversion applies

# Promotion and conversion
## Julia makes automatic conversions during numeric operations
## for instance, before summing a Float32 and a Float64, Julia converts the Float32 to a Float64

# Tuple and NamedTuple
## variables of different types usually are stored in Tuples
tuple = ("a", true)
tuple[1]    # accessed like Vectors, but they are not mutable
typeof(tuple)   # Each type is specified
(nrow, ncol) = size(x_mat)
# or
nrow, ncol = size(x_mat)
nrow
## there is also NamedTuples, very neat to define parameters
namedtuple = (a = 1, b = 3)


# More info at https://docs.julialang.org/en/v1/manual/types/