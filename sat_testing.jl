include("sat_bmz.jl")
using PrettyTables

# /Users/reneemirka/Downloads/max-cut-experiments/MAXSAT 2022/bip.maxcut-140-630-0.7-13.wcnf
# /Users/reneemirka/Downloads/max-cut-experiments/MAXSAT 2022/bip.maxcut-140-630-0.7-37.wcnf
# /Users/reneemirka/Downloads/max-cut-experiments/MAXSAT 2022/bip.maxcut-140-630-0.7-42.wcnf
# /Users/reneemirka/Downloads/max-cut-experiments/MAXSAT 2022/bip.maxcut-140-630-0.7-44.wcnf 2
# /Users/reneemirka/Downloads/max-cut-experiments/MAXSAT 2022/bip.maxcut-140-630-0.8-24.wcnf

#Instances on complete track in one or more years from 2018-2022
header = ["Instance", "Num Vars", "Num Clauses", "Found cost", "OPT cost", "Time", "OPT time", "Year"]
opt_costs = ["N/A", "N/A", "N/A", "N/A", 192, 49, "N/A", 154, 146, "N/A", "N/A", "N/A", "N/A", "N/A", "N/A", "N/A",
    "N/A", "N/A", "N/A", "N/A", "N/A", "N/A", 75, "N/A", "N/A", "N/A", "N/A", "N/A", 75, "N/A", "N/A", "N/A", "N/A", "N/A", "N/A", "N/A", "N/A", "N/A", "N/A"]
#, "N/A", "N/A", "N/A", "N/A", "N/A"]
opt_times = [3600, 3600, 3600, 3600, 462.426, 2.33857, 3600, 285.043, 620.409, 3600, 3600, 3600, 3600, 3600, 3600, 3600,
    3600, 3600, 3600, 3600, 3600, 3600, 3.76, 3600, 3600, 3600, 3600, 3600, 1.9699, 3600, 3600, 3600, 3600, 3600, 3600, 3600, 3600, 3600, 3600]
#, 3600, 3600, 3600, 3600, 3600]
file_names = ["brock200_1", "brock400_2", "brock400_4", "hamming6-4", "MANN_a9", "p_hat300-1", "p_hat500-3", "p_hat700-2", "san400_0.5_1", "sanr200_0.7", "p_hat300-3", "hamming8-2", "maxcut-140-630-0.8-34", "maxcut-140-630-0.8-36", "maxcut-140-630-0.7-15", "maxcut-140-630-0.7-48",
    "maxcut-140-630-0.8-3", "san400_0.7_3", "maxcut-140-630-0.8-44", "p_hat500-3", "maxcut-140-630-0.7-3", "maxcut-140-630-0.8-4", "p_hat500-1", "san200_0.9_1", "maxcut-140-630-0.7-49", "maxcut-140-630-0.8-20", "maxcut-140-630-0.7-33", "brock200_3", "johnson8-2-4", "maxcut-140-630-0.7-12", "maxcut-140-630-0.7-20", "maxcut-140-630-0.7-28", "maxcut-140-630-0.7-4", "maxcut-140-630-0.7-45", "maxcut-140-630-0.7-6", "maxcut-140-630-0.8-1", "maxcut-140-630-0.8-18", "maxcut-140-630-0.8-26", "maxcut-140-630-0.8-39"]
#, "bip.maxcut-140-630-0.7-13.wcnf", "bip.maxcut-140-630-0.7-37.wcnf", "bip.maxcut-140-630-0.7-42.wcnf", "bip.maxcut-140-630-0.7-44.wcnf 2", "bip.maxcut-140-630-0.8-24.wcnf"]
year = [2018, 2018, 2018, 2018, 2018, 2018, 2018, 2018, 2019, 2019, 2019, 2019, 2019, 2019, 2019, 2019,
    2020, 2020, 2020, 2020, 2020, 2020, 2020, 2020, 2020, 2020, 2020, 2021, 2021, 2021, 2021, 2021, 2021, 2021, 2021, 2021, 2021, 2021, 2021]
#, 2022, 2022, 2022, 2022, 2022]
found_costs = []
found_times = []
vars = []
clauses = []

@timed bmz(2, [0 -1/4 1/4; -1/4 0 1/4; 1/4 1/4 0], [0 1 1; 1 0 1; 1 1 0], 10)

flush(stdout)
open("/Users/reneemirka/Downloads/max-cut-experiments/2018_sat_files.txt") do f

    while !eof(f)

        # read a new / next line for every iteration
        file = readline(f)
        println("$(file)")

        open(file) do g

            line = readline(g)

            while split(line, " ")[1] != "p"
                line = readline(g)
            end
            #
            # graph = readline(g)
            sizes = split(line, " ")
            n = parse(Int, sizes[3])
            m = parse(Int, sizes[4])
            W = zeros(n + 1, n + 1)
            num_clauses = zeros(n + 1, n + 1)
            push!(vars, n)
            push!(clauses, m)

            for i = 1:m
                temp = readline(g)
                clause = split(temp, " ")
                j = parse(Int, clause[2])
                k = parse(Int, clause[3])
                num_clauses[abs(j), abs(k)] += 1
                num_clauses[abs(k), abs(j)] += 1
                num_clauses[abs(j), n+1] += 1
                num_clauses[n+1, abs(j)] += 1
                num_clauses[n+1, abs(k)] += 1
                num_clauses[abs(k), n+1] += 1
                W[abs(j), n+1] += (1 / 4) * sign(j)
                W[n+1, abs(j)] += (1 / 4) * sign(j)
                W[abs(k), n+1] += (1 / 4) * sign(k)
                W[n+1, abs(k)] += (1 / 4) * sign(k)
                W[abs(j), abs(k)] += (-1 / 4) * sign(j) * sign(k)
                W[abs(k), abs(j)] += (-1 / 4) * sign(j) * sign(k)
            end

            results = @timed bmz(n, W, num_clauses, 10)
            cost = m - results[1][2]
            time = results[2]
            push!(found_costs, cost)
            push!(found_times, time)

            println("time: ", time)
            println("cost: ", cost)

        end
    end
end

output = open("/Users/reneemirka/Downloads/max-cut-experiments/SAToutput.txt", "w")
data = hcat(file_names, vars, clauses, found_costs, opt_costs, found_times, opt_times, year)
str = pretty_table(String, data; header=header)
write(output, "Instances from complete track 2018-2022 \n")
write(output, str)
close(output)
