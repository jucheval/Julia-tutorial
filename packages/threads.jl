# Intro
## see how many available threads there are
versioninfo()
## go to settings and modify julia.NumThreads

## number of threads used by Julia @threads macro
Threads.nthreads()

# First example
## iterations treated sequentially on one thread
for i = 1:10
    println("i = $i \t on thread $(Threads.threadid())")
end
## iterations are distributed across threads in a non sequential way
Threads.@threads for i = 1:10
    println("i = $i \t on thread $(Threads.threadid())")
end

# Issue 1 : Data Race
range_N = 1:1_000_000
## standard implementation
function sum_single(a)
    s = 0
    for i in a
        s += i
    end
    return s
end
sum_single(range_N)

## data race occurring
function sum_multi_bad(a)
    s = 0
    Threads.@threads for i in a
        s += i
    end
    return s
end
sum_multi_bad(range_N)
### @threads macro may induce some data-race between threads. 
### the code is not memory safe
### here, s is read and written at the same time by several threads
### resulting in an incorrect result

## Fix 1:
### separate memory for each thread
function sum_multi_separated(myvector)
    temp = zeros(Int, Threads.nthreads())
    Threads.@threads for i in eachindex(myvector)
        temp[Threads.threadid()] += myvector[i]
    end
    return sum(temp)
end
sum_multi_separated(range_N)

## Fix 2:
### Atomic's are used to avoid data-race
function sum_multi_atomic(a)
    s = Threads.Atomic{Int}(0)
    Threads.@threads for i in a
        Threads.atomic_add!(s, i)
    end
    return s[]
end
sum_multi_atomic(range_N)
