# Ants
Ant Colony Optimization (ACO) algorithm for Traveling Salesman Problem (TSP) implemented in Julia.

## Usage: Distance Matrices

### Description

Input data for TSP can be defined in a form of a distance matrix. The matrix can be defined as a Julia array or loaded from a file.

Matrix must have `Inf` as a value for non-existing edges.

### Example

Results for `D1` matrix from `data/dists.jl`.

![D1](/imgs/d1.svg)

## Usage: TSPLIB

### Description

Datasets from [TSPLIB](http://comopt.ifi.uni-heidelberg.de/software/TSPLIB95/) database are also supported.

### Example

Optimization was performed on [Wi29](https://www.math.uwaterloo.ca/tsp/world/wipoints.html) dataset.

During the experiments the suboptimal tour of length 27760.0 was found in just 100 iterations with 50 ants.

![Wi29My](/imgs/wi29.svg)

The [optimal tour](https://www.math.uwaterloo.ca/tsp/world/witour.html) of length 27603.0 is illustrated below.

![Wi29Opt](https://www.math.uwaterloo.ca/tsp/world/witour.gif)