import TSPLIB: readTSP, TSP
import Plots: scatter, plot!
import LinearAlgebra: I, normalize

function tspAdjust(tsp::TSP)::Matrix{Float64}
  return tsp.weights + I * Inf
end

function tspPlot(tsp::TSP)
  scatter(tsp.nodes[:,2], tsp.nodes[:,1], aspect_ratio=:equal, xflip=true, label="")
end

function tspPlot(tsp::TSP, path::Vector{Int64})
  scatter(tsp.nodes[:,2], tsp.nodes[:,1], aspect_ratio=:equal, xflip=true, label="")
  plot!(tsp.nodes[path,2], tsp.nodes[path,1], aspect_ratio=:equal, xflip=true, label="")
end