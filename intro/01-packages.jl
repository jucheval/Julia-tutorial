# Packages

# Adding packages
## with the package mode ] -> add PackageName
## some useful packages
using Pkg
Pkg.add(["OhMyREPL",            # Highlights your REPL
         "Revise",              # Awesome for Package development
         "Distributions",       # All about probability distributions
         "DataFrames",          # Data frames management
         "Plots",               # Basic plots
         "DrWatson",            # Simulation data management and reproducibility
         "GraphRecipes",        # Look at the types tree
         "StartupCustomizer",   # Used below
         "Statistics",          # Basic statistics functions
         "BenchmarkTools"])     # Time the performance of your code
## 2 packages added to your startup.jl file
using StartupCustomizer
StartupCustomizer.add(StartupCustomizer.Revise(), StartupCustomizer.OhMyREPL())

# Removing packages
## with the package mode ] -> rm PackageName

# see the doc of Pkg.jl for more info
# https://pkgdocs.julialang.org/