# Demonstration of the ACO algorithm.

include("aco.jl")
include("data.jl")
include("visualize.jl")

test = ACO(G2, 8, 10)

visualize(G2, test.trails, test.path)