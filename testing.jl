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


# * is best bound we have
function burer_iter(it, A, size, adj, limit)
    f_value = burer_heuristic(A, size, adj, 10)
    return f_value
end

function burer_iter_post(it, A, size, adj, limit)
    cut = []
    cut_val = -Inf
    temp = burer_heuristic(A, size, adj, 10)
    cut_val = temp[1]
    cut = temp[2]
    return cut_val, cut
end

opt_found = [116, 211, 377, 524, 311, 782, 1416, 2035, 1296, 2975, 5542, 7904, 3735, 8709, 16482, 23967, 7532, 17399, 33234, 48576, 3209864, 42693, 53990, 470726, 23415237, 2318887, 46339280, 1888108, 2525606, 12938532, 107144, 2156667, 30696595, 16002489, 11660800, 5897368, 126, 3036, 992, 1279, 122, 427, 557, 108.12, 636, 1773, 126, 1036, 1938, 33521, 1816, 3885]
# Anything not defined is said to be 0
opt_actual = [116, 211, 377, 524, 311, 782, 1416, 2035, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3.21 * 10^6, 4.269 * 10^4, 5.399 * 10^4, 4.707 * 10^5, 2.342 * 10^7, 2.319 * 10^6, 0, 1.888 * 10^6, 2.526 * 10^6, 1.294 * 10^7, 1.071 * 10^5, 2.157 * 10^6, 3.070 * 10^7, 1.6 * 10^7, 1.166 * 10^7, 5.897 * 10^6, 3.21 * 10^6, 126, 0, 992, 0, 122, 427, 557, 108.1, 0, 0, 126, 0, 1928, 0, 0, 0]

#run these to prep the '@timed' function without having to process the function
@timed burer_iter(1, [0.0 1.0; 1.0 0.0], 2, [[2], [1]], 10)

files = [:a280, :bayg29, :bays29, :berlin52, :bier127, :brazil58, :brg180, :ch130, :ch150, :d198, :eil101, :gr120, :gr137, :gr202, :gr96, :kroA100]

header = (["Graph\\Procedure", "Function Value", "Optimal Found", "Actual Optimal", "Value : Optimal Found", "Value : Actual Optimal"])

#random graphs with 50,100, 200, 350, 500 vertices and edge probs of .1, .25, .5, .75
sizes = [50, 100, 200, 350, 500]
p = [0.1, 0.25, 0.5, 0.75]

burer_cut_vals_random = []
actual_random = []
found_random = []
ratio_found_random = []
ratio_actual_random = []

burer_cut_vals_TSPLIB = []
actual_TSPLIB = []
found_TSPLIB = []
ratio_found_TSPLIB = []
ratio_actual_TSPLIB = []

burer_cut_vals_files = []
actual_files = []
found_files = []
ratio_found_files = []
ratio_actual_files = []


file_names = []

"""
construct and test random graphs here
"""
#
# open("random.txt") do f
#     i = 1
#     # read till end of file
#     while !eof(f)
#
#         # read a new / next line for every iteration
#         file = readline(f)
#         #println("$(file)")
#
#         open(file) do g
#             graph = readline(g)
#             sizes = split(graph, " ")
#             n = parse(Int, sizes[1])
#             m = parse(Int, sizes[2])
#             A = zeros(n, n)
#             adj = Array[]
#
#             for i = 1:m
#                 temp = readline(g)
#                 edge = split(temp, " ")
#                 j = parse(Int, edge[1])
#                 k = parse(Int, edge[2])
#                 a = parse(Float64, edge[3])
#                 A[j, k] = 1
#                 A[k, j] = 1
#             end
#
#             for i = 1:n
#                 push!(adj, filter(j -> A[i, j] == 1, collect(1:n)))
#             end
#             #
#             #
#             #avg_time = 0
#             #avg_cut = 0
#
#             for p = 1:10
#
#                 t5 = @timed burer_iter(1, A, n, adj, 10)
#                 push!(burer_cut_vals_random, t5[1])
#                 push!(found_random, opt_found[i])
#                 push!(ratio_found_random, t5[1] / opt_found[i])
#                 if 0 != opt_actual[i]
#                     push!(ratio_actual_random, t5[1] / opt_actual[i])
#                     push!(actual_random, opt_actual[i])
#                 else
#                     push!(ratio_actual_random, "NaN")
#                     push!(actual_random, "NaN")
#                 end
#                 push!(file_names, file)
#                 println("$(file)")
#                 #println(t5[1])
#                 #avg_time += t5[2]
#                 #avg_cut += t5[1][1]
#
#                 # println("burer cut value: ", t5[1][1])
#                 # println("burer time: ", t5[2])
#             end
#             i = i + 1
#             #avg_time = avg_time / 3
#             #avg_cut = avg_cut / 3
#
#             #push!(burer_times, avg_time)
#             #push!(burer_cut_vals, avg_cut)
#             #println("average burer time: ", avg_time / 3)
#             #println("average burer cut: ", avg_cut / 3)
#             # #
#         end
#     end
# end
#
# random_cut_data = hcat(file_names, burer_cut_vals_random, found_random, actual_random, ratio_found_random, ratio_actual_random)
# random_cut_str = pretty_table(String, random_cut_data; header=header)
# output = open("output.txt", "w")
# write(output, "Random Graphs \n ")
# write(output, random_cut_str)
#
# """
# test the TSPLIB graphs here
# """
# file_names = []
#
# for i = 1:length(files)
#     println(files[i])
#     tsp = readTSPLIB(files[i])
#
#     A_mat = tsp.weights
#     size = tsp.dimension
#     adj = Array[]
#     for s = 1:size
#         push!(adj, filter(x -> x != s, collect(1:size)))
#     end
#
#
#     edgecount = (size * (size - 1)) / 2
#     #open("$(files[i]).txt", "w") do file
#     #println(file, "$size $edgecount")
#     for k = 1:size
#         for l = k+1:size
#             #println(file, "$k $l $(A_mat[k,l])")
#         end
#     end
#
#     for p = 1:10
#         t5 = @timed burer_iter(1, A_mat, size, adj, 10)
#         push!(burer_cut_vals_TSPLIB, t5[1])
#         # Add 20 so we are indexing to our TSPLIB values
#         push!(ratio_found_TSPLIB, t5[1] / opt_found[i+20])
#         push!(found_TSPLIB, opt_found[i+20])
#         if 0 != opt_actual[i+20]
#             push!(ratio_actual_TSPLIB, t5[1] / opt_actual[i+20])
#             push!(actual_TSPLIB, opt_actual[i+20])
#         else
#             push!(ratio_actual_TSPLIB, "NaN")
#             push!(actual_TSPLIB, "NaN")
#         end
#         push!(file_names, files[i])
#         print(opt_found[i+20])
#         println(files[i])
#         #println(t5[1])
#
#     end
# end
#
# random_cut_data = hcat(file_names, burer_cut_vals_TSPLIB, found_TSPLIB, actual_TSPLIB, ratio_found_TSPLIB, ratio_actual_TSPLIB)
# random_cut_str = pretty_table(String, random_cut_data; header=header)
# write(output, "TSPLIB Graphs \n")
# write(output, random_cut_str)


"""
test the Network Repository graphs here
"""


# vertices, probability edge
# random, complete, real world graphs (# vertices, # edges)
# complete = # is number of vertices
# start:
# compute local min and repeat
# from bmz get minimization pt, stop and see what function value is and compare opt values
# compute local min once and compare to opt first, could multiple times look for min
# how far are local min from max
# is there local min more than factor 2 away
# function value at min
# do for all

file_names = []

open("/Users/reneemirka/Downloads/max-cut-experiments/files.txt") do f
    i = 1
    # read till end of file
    while !eof(f)

        #read a new / next line for every iteration
        file = readline(f)

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
                if (A[I[k], J[k]] != 0)
                    #println("duplicate")
                end
                A[I[k], J[k]] = V[k]
            end
        end
        println(LinearAlgebra.issymmetric(A))

        # for p = 1:10
        #     t5 = @timed burer_iter(1, A, size, adj, 10)
        #     push!(burer_cut_vals_files, t5[1])
        #     push!(ratio_found_files, t5[1] / opt_found[i+20+16])
        #     push!(found_files, opt_found[i+20+16])
        #     if 0 != opt_actual[i+20+16]
        #         push!(ratio_actual_files, t5[1] / opt_actual[i+20+16])
        #         push!(actual_files, opt_actual[i+20+16])
        #     else
        #         push!(ratio_actual_files, "NaN")
        #         push!(actual_files, "NaN")
        #     end
        #     push!(file_names, file)
        #     println(file)
        #     #println(t5[1])
        # end
        i = i + 1
    end

end

random_cut_data = hcat(file_names, burer_cut_vals_files, found_files, actual_files, ratio_found_files, ratio_actual_files)
random_cut_str = pretty_table(String, random_cut_data; header=header)
write(output, "Network Repo Graphs \n")
write(output, random_cut_str)
close(output)
