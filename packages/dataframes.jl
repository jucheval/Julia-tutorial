using DataFrames

# Constructors
DataFrame(a=[1,2], b=["M", "F"])            # keyword argument constructor
DataFrame([(a=1, b="M"), (a=2, b="F")])     # tuple constructor
DataFrame(:a => [1,2], :b => ["M", "F"])    # dictionary constructor

# Construction by columns
df = DataFrame();
df.a = [1,2];
df.b = ["M", "F"];
df

# Construction by rows
df = DataFrame(a=Int[], b=String[]);
push!(df, (1, "M"));
push!(df, (2, "F"));
df

# Extract a column as a Vector
df = DataFrame(A=1:2:1000, B=repeat(1:10, inner=50), C=1:500)
## Without copy (like a view)
df.A
df[!, :A]
## With copy
df[:, :A]
### Check
df.A[1] = 3                     # mutation
df.A[1]
df.A[1] = 1; df[!,:A][1] = 3    # mutation
df.A[1]
df.A[1] = 1; df[:,:A][1] = 3    # no mutation
df.A[1]

# Extract a sub-DataFrame
df = DataFrame(A=1:2:1000, B=repeat(1:10, inner=50), C=1:500)
## By indexing
df[!, [:B, :A]]     # like a view
df[:, [:B, :A]]     # like a copy
df[1:3, [:B, :A]]   # like a copy
## By filtering
df[(df.A .> 500) .& (300 .< df.C .< 400), :]                    # like a copy
subset(df, :A => x -> x .> 500, :C => x -> 300 .< x .< 400)     # like a copy

# Basic functions
size(df)
names(df)
describe(df)

# More info at https://dataframes.juliadata.org/stable/