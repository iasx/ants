using Plots
using Graphs
using GraphPlot

function draw(graph; nodes, edges=[], lines=0.5, strokes=colorant"lightgray")
  return gplot(
    graph,
    nodelabel=nodes,
    edgelabel=edges,
    edgestrokec=strokes,
    edgelinewidth=lines,
    edgelabelc=colorant"magenta",
    nodelabelc=colorant"white",
    nodefillc=colorant"black",
    layout=circular_layout,
    edgelabeldisty=-1.0,
  )
end

function visualize(X::Matrix{Float64})
  labels = []
  N = size(X, 1)
  G = SimpleGraph(N)

  for i in 1:N-1
    for j in i+1:N
      isinf(X[j, i]) && continue

      add_edge!(G, j, i)
      push!(labels, X[j, i])
    end
  end

  return draw(G; nodes=1:N, edges=labels)
end

function visualize(X::Matrix{Float64}, P::Matrix{Float64})
  width = []
  labels = []
  N = size(X, 1)
  P = normalize(P)
  G = SimpleGraph(N)

  for i in 1:N-1
    for j in i+1:N
      isinf(X[j, i]) && continue

      add_edge!(G, j, i)
      push!(labels, X[j, i])
      push!(width, P[i, j] + P[j, i])
    end
  end

  return draw(G; nodes=1:N, edges=labels, lines=width)
end

function visualize(X::Matrix{Float64}, path::Vector{Int64})
  labels = []
  colors = []
  N = size(X, 1)
  G = SimpleGraph(N)

  steps = Set(
    path[i] < path[i-1]
    ? path[i] => path[i-1]
    : path[i-1] => path[i]
    for i in 2:length(path)
  )

  for i in 1:N-1
    for j in i+1:N
      isinf(X[j, i]) && continue

      add_edge!(G, j, i)
      push!(labels, X[j, i])
      push!(colors, (i => j) in steps ? colorant"red" : colorant"gray")
    end
  end

  return draw(G; nodes=1:N, edges=labels, strokes=colors)
end

function visualize(X::Matrix{Float64}, P::Matrix{Float64}, path::Vector{Int64})
  width = []
  labels = []
  colors = []
  N = size(X, 1)
  P = normalize(P)
  G = SimpleGraph(N)

  steps = Set(
    path[i] < path[i-1]
    ? path[i] => path[i-1]
    : path[i-1] => path[i]
    for i in 2:length(path)
  )

  for i in 1:N-1
    for j in i+1:N
      isinf(X[j, i]) && continue

      add_edge!(G, j, i)
      push!(labels, X[j, i])
      push!(width, P[i, j] + P[j, i])
      push!(colors, (i => j) in steps ? colorant"red" : colorant"gray")
    end
  end

  return draw(G; nodes=1:N, edges=labels, lines=width, strokes=colors)
end
