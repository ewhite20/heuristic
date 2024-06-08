include("BMZdicut.jl")
using PrettyTables
using MatrixMarket
using SparseArrays


found_vals = []
found_times = []
vars = []
clauses = []

results = @timed bmz(2, [[],[3],[2]], [0 0 0; 0 0 1; 0 1 0], 10)
println(results)

flush(stdout)
open("/Users/reneemirka/Downloads/max-cut-experiments/dicut_files.txt") do f

    while !eof(f)

        # read a new / next line for every iteration
        file = readline(f)
        println("$(file)")

        total_weight = 0

        open(file) do g
            adj_list = Array[]
            line = readline(g)

            while split(line," ")[1] != "p"
                line = readline(g)
            end
            #
            # graph = readline(g)
            sizes = split(line)
            n = parse(Int, sizes[3])
            m = parse(Int, sizes[4])
            W = zeros(n+1, n+1)

            push!(vars, n)
            push!(clauses, m)
            adj_list = Array[]
            for s = 1:n+1
                push!(adj_list, Int[])
            end

            for i = 1:m
                temp = readline(g)
                clause = split(temp)
                if clause[1] == "a"
                    j = parse(Int, clause[2]) + 1
                    k = parse(Int, clause[3]) + 1
                    W[j,k] += parse(Int, clause[5])
                    total_weight += parse(Int, clause[5])
                    push!(adj_list[j], k)
                end
            end

            println(total_weight)

            # best_cut_val = 0
            # stopper = true
            # t = time()
            # while stopper
            #     results = @timed bmz(n, adj_list, W, 10)
            #     if time() > t + 60
            #         stopper = false
            #     else
            #         if (m-results[1][2]) < best_cost
            #             best_cost = m - results[1][2]
            #         end
            #     end
            # end
            #
            # push!(found_costs, best_cost)
            # println("cost: ", best_cost)

            results = @timed bmz(n, adj_list, W, 10)
            val = results[1][2]
            time = results[2]
            push!(found_vals, val)
            push!(found_times, time)

            println("time: ", time)
            println("val: ", val)
            println("ratio: ", val/total_weight)

        end
    end
end

open("/Users/reneemirka/Downloads/max-cut-experiments/MM_dicut_files.txt") do f
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
        A = zeros(size+1, size+1)
        for s = 1:size+1
            push!(adj, Int[])
        end

        for k = 1:length(I)
            if I[k] != J[k] #ignore self-loops
                push!(adj[I[k]+1], J[k]+1)
                A[I[k]+1, J[k]+1] = V[k]
            end
        end

        results = @timed bmz(size, adj, A, 10)
        val = results[1][2]
        time = results[2]
        push!(found_vals, val)
        push!(found_times, time)

        println("time: ", time)
        println("val: ", val)
        # println("ratio: ", val/total_weight)
    end


end
