# Type Inference in Julia

## We use two macros :
## @code_lowered : to see the code after lowering it to more "basic" functions
## @code_typed : to see the code after lowering, optimization and type inference. Remark that every variable is typed after this step.

function add(a, b)
    return a + b
end

@code_lowered add(1, 2)
## + is already a "basic" function
@code_typed add(1, 2)
## add_int is faster so it replaces +
## The return type is Int64

function cubic(a)
    return a^3
end

@code_lowered cubic(2)
## ^ is replaced by Base.literal_pow
@code_typed cubic(2)
## The cube is unfolded as two multiplications
## The return type is Int64

function power(a,p)
    return a^p
end

@code_lowered power(2, 3)
@code_typed power(2, 3)
## The power is unfolded as recursive squaring
## The return type is Int64
@code_lowered power(2, 3.2)
@code_typed power(2, 3.2)
## The power uses the general power function (exponential and logarithm)
## The return type is Float64