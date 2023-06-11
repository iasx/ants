using StatsBase
using LinearAlgebra

struct ACOResult
  length::Float64
  path::Vector{Int64}
  trails::Matrix{Float64}
end

"""
    route(D::Matrix{Float64}, path::Vector{Int64})::Float64

  Calculates the length of the `path` given the distance matrix `D`.

  **Arguments**
  - `D` Distance matrix
  - `path` Path to calculate the length
"""
function route(D::Matrix{Float64}, path::Vector{Int64})::Float64
  return sum(D[path[i-1], path[i]] for i in 2:length(path))
end

"""
    ACO(D::Matrix{Float64}, A::Int64, I::Int64, [α::Float64=1.0], [β::Float64=1.0], [ρ::Float64=0.75], [Q::Float64=5.0])::ACOResult

  Finds the optimal graph path using the Ant Colony Optimization algorithm.

  **Arguments**
  - `D` Distance matrix
  - `A` Number of ants
  - `I` Number of iterations
  - `α` Pheromone factor
  - `β` Heuristic factor
  - `ρ` Evaporation factor
  - `Q` Pheromone deposit factor

  **Returns**
  - `path::Vector{Int}` Optimal path
  - `length::Float64` Optimal path length
  - `trails::Matrix{Float64}` Pheromone trails matrix
"""
function ACO(
  D::Matrix{Float64},
  A::Int64,
  I::Int64;
  α::Float64=1.0,
  β::Float64=1.0,
  ρ::Float64=0.75,
  Q::Float64=5.0
)::ACOResult
  bestPath = nothing
  bestLen = Inf

  N::Int64 = size(D, 1) # number of nodes
  P::Matrix{Float64} = ones(N, N) / length(D)  # pheromone trail matrix

  for _ in 1:I
    paths = []
    lens = []

    for _ in 1:A
      x = rand(1:N) # ant starts at random node
      path = [x]

      while length(path) < N # route building
        left = setdiff(1:N, path)

        τ = P[x, left]
        η = 1 ./ D[x, left]
        p = @. τ^α * η^β
        p = p ./ sum(p)

        next = sample(left, Weights(p))
        push!(path, next)
        x = next
      end

      push!(path, path[1]) # append the last node to close the path

      len = route(D, path)
      push!(paths, path)
      push!(lens, len)

      if len < bestLen
        bestPath = path
        bestLen = len
      end
    end

    P *= ρ # pheromone evaporation

    for (path, len) in zip(paths, lens) # pheromone emission
      new = Q / len
      for i in 1:N
        P[path[i], path[i+1]] += new
      end
    end
  end

  return ACOResult(bestLen, bestPath, P)
end
