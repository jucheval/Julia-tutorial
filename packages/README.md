# Useful packages

Here is a selective list of packages I use and find useful. Some are illustrated with a short demo script with comments.

## Table of Contents

- [Distributions.jl](distributions.jl): Use probabilistic distributions and related functions (sampling, moments, pdf, cdf, quantile, MLE, etc.)
- [DataFrames.jl](dataframes.jl): Manipulate tabular data
- [DrWatson.jl](https://juliadynamics.github.io/DrWatson.jl/dev/workflow/): Manage scientific projects (setup the directories and Julia dependencies, handle parameters, saving and loading files)
- [BenchmarkTools.jl](benchmark-tools.jl): Track performance of Julia code
- Plot packages:
  - [Plots.jl](https://docs.juliaplots.org/latest/): Simplest one (with [StatsPlots.jl](https://docs.juliaplots.org/latest/generated/statsplots/) for DataFrames integration)
  - [Makie.jl](https://docs.makie.org/v0.22/): Versatile and allows nice animations with GLMakie backend ([Examples](https://beautiful.makie.org/dev/))
  - [Gadfly.jl](http://gadflyjl.org/stable/): Similar to R's ggplot2
  - [PyPlot.jl](https://github.com/JuliaPy/PyPlot.jl): Call Python’s matplotlib (Python and matplotlib must be installed on your machine)
