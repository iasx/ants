################################################################################
# Demonstration of the ACO algorithm.                                          #
################################################################################

# Load the libraries.

include("lib/aco.jl")
include("lib/tsplib.jl")
include("lib/visualize.jl")

# Test on distance matrix.

include("data/dists.jl")

y1 = ACO(D1, 8, 10)

visualize(D1, y1.trails, y1.path)

# Test on TSPLIB instance (WI29 - Western Sahara).

tsp = readTSP("data/wi29.tsp")

x2 = tspAdjust(tsp)

y2 = ACO(x2, 29, 1000, α=1.0, β=2.0, ρ=0.85, Q=100.0)

tspPlot(tsp, y2.path)