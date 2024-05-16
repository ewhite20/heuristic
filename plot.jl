include("trevisan_max_cut.jl")
include("official_SDP.jl")
include("helpers.jl")
include("split_cuts.jl")
include("burer.jl")
include("bmz_linesearch.jl")
using MatrixMarket
using LightGraphs
using Random
using SparseArrays
using TSPLIB
using PrettyTables
# using PyPlot


# function value (what wanted at the min) -- vector
function fun(theta)
  n = length(theta)
  return (1 / 4) * sum(sum(A[i, j] * (1 - cos(theta[i] - theta[j])) for j in 1:n) for i in 1:n)
end

# Plots a vector of theta values on a unit circle
# function plot_unit_circles(theta_array, titles_array)
#   if length(theta_array) != length(titles_array)
#     throw(ArgumentError("Input lists must have the same length"))
#   end
#
#   for (theta_values, title) in zip(theta_array, titles_array)
#     fig, ax = subplots()
#     ax.set_aspect("equal", adjustable="box")
#     ax.set_xlim(-1.2, 1.2)
#     ax.set_ylim(-1.2, 1.2)
#     ax.set_xlabel("x")
#     ax.set_ylabel("y")
#     ax.set_title(title)
#
#     # Plot the unit circle outline
#     t = range(0, stop=2π, length=100)
#     x_outline = cos.(t)
#     y_outline = sin.(t)
#     ax.plot(x_outline, y_outline, color="black", linestyle="-", linewidth=1, label="")
#
#     # Plot lines from the origin to each point on the unit circle
#     for (i, theta) in enumerate(theta_values)
#       x = cos(theta)
#       y = sin(theta)
#       color = plt.cm.viridis(i / length(theta_values))  # Color based on theta value
#       ax.plot([0, x], [0, y], linestyle="-", color=color, linewidth=1, label="θ = $theta")
#       ax.scatter([x], [y], color=color, label="", s=25)
#     end
#
#     ax.legend(loc="lower right")
#     show()
#   end
# end


# Modified burer_heuristic to just local_search and return opt_theta values
function local_search(adj_matrix, n, adj, N)

  global A = adj_matrix
  global adj_list = adj
  k = 0
  gamma = -Inf
  best_cut = []


  temp = rand(n)
  theta_init = 2 * π .* temp

  w1norm = sum(sum(A[i, j] for j in 1:n) for i in 1:n)

  p = π / n

  # minimization happens here, this is a vector of theta values
  opt_theta = linesearch(theta_init, A, w1norm, n)
  theta_init = [opt_theta[i] + rand([-π, π]) * 0.2 for i in 1:n]
  opt_theta_searched = linesearch(theta_init, A, w1norm, n)

  for i = 1:n
    if opt_theta[i] > (2 * π)
        opt_theta[i] = opt_theta[i] % (2 * π)
    elseif opt_theta[i] < 0
        while opt_theta[i] < 0
            opt_theta[i] = opt_theta[i] + 2 * π
        end
    end
  end

  return opt_theta, opt_theta_searched

end

opt_theta = []
opt_theta2 = []
titles = []
vals = []
vals_2 = []
names = []
ratio = []
ratio_2 = []

open("/Users/reneemirka/Downloads/max-cut-experiments/simple_files.txt") do f
  # read till end of file
  i = 7
  while !eof(f)
    #read a new / next line for every iteration
    file = readline(f)
    println(file)
    push!(names, file)
    adj = Array[]
    M = MatrixMarket.mmread("$file")
    size = M.m
    I, J, V = findnz(M)
    # println(I)
    # println(J)
    A = zeros(size, size)
    for s = 1:size
      push!(adj, Int[])
    end

    for k = 1:length(I)
      if I[k] != J[k] #ignore self-loops
        push!(adj[I[k]], J[k])
        A[I[k], J[k]] = V[k]
        A[J[k], I[k]] = V[k]
      end
    end
    # println(LinearAlgebra.issymmetric(A))
    # println(A)
    # 10[1]??
    res = local_search(A, size, adj, 1)
    println(res[1])
    # println(fun(res[1]))
    # println(fun(res[1])/(i-1))
    push!(opt_theta, res[1])
    push!(opt_theta2, res[2])
    push!(vals, fun(res[1]))
    push!(vals_2, fun(res[2]))
    push!(ratio, fun(res[1]) / (size - 1))
    push!(ratio_2, fun(res[2]) / (size - 1))
    #push!(titles, string(i, " local search"))
    #push!(titles, string(i, " optimized"))
    i = i + 2

  end
  #plot_unit_circles(opt_theta, titles)
end
header = (["Graph\\Procedure", "Local Function Value", "Optimized Function Value", "Local : Opt", "Optimized : Opt"])
data = hcat(names, vals, vals_2, ratio, ratio_2)
data_str = pretty_table(String, data; header=header)
output = open("/Users/reneemirka/Downloads/max-cut-experiments/odd_cycle_table_RM.txt", "w")
write(output, "Odd Length Cycle Data \n")
write(output, data_str)
close(output)

# 5k runs
# rep each as angle
# V0 = vector 0, each angle relative to this
# bmz min, this MatrixMarket
# balanced V0 doesn't appear -- read abt in paper
# ms - bipartite - max best_cut
# try to find unbalanced instances
# when balanced, literals appearing pos / neg end up cancelling out in obj function
# write code can handle as well unbalanced to start
