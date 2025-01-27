using Distributions
using Random # built-in package necessary to set random seeds
Random.seed!(123) # Setting the seed

# Define a random variable X, not a realization !!
X = Exponential(2)

# Get its properties
## single value
mean(X)
median(X)
var(X)
kurtosis(X)
extrema(X)
## functionals
pdf(X, [0.1, 2])
quantile(X, [0.25, 0.5, 0.75])
cdf(X, [-1, 1, 3])
mgf(X, 2)

# Get samples x
rand(X)
x = rand(X, 100, 100)

# Fit a distribution to your data
fit(Exponential, x)
## It returns a random variable
## In general, fit function corresponds to MLE estimation

# Conditional distributions
## Say you want to sample from a random variable Y which is defined conditionally to X
## X follows an Exponential with mean 3
## Given X=x Y follows a Normal with mean x and standard deviation 2
X = Exponential(3)
x = rand(X, 10)
Y = Normal.(x, 2)
y = rand.(Y)

# Product distributions
## Say you want the distribution of a vector V where:
## the first coordinate is distributed as standard normal
## the second coordinate is distributed as Dirichlet([2, 4])
X = Normal()
Y = Binomial(2, 0.3)
V = product_distribution([X, Y])

v = rand(V)
pdf(V, v) # product of pdfs
mode(V)   # marginal modes
mean(V)   # marginal means

# Type hierarchy
supertype(Normal)
## Each distribution is a subtype of Distribution{F, S} where:
## F = Univariate, Multivariate or Matrixvariate
## S = Discrete or Continuous

# More info at https://juliastats.org/Distributions.jl/stable/