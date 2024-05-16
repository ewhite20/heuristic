include("sat_bmz.jl")
using PrettyTables

#Instances on complete track in one or more years from 2018-2022
header = ["Instance", "Num Vars", "Num Clauses", "Found cost", "OPT cost", "Year", "Loop Costs"]
opt_costs = [238, 252, 249, 192, 422, 284,
  404, 250, 269, 237, 236, 400,
  200, 832, 441, 400, 770, 422, 404, 418, 399,
  214,]
file_names = ["maxcut-brock200_1.clq.wcnf", "maxcut-brock400_2.clq.wcnf", "maxcut-brock400_4.clq.wcnf", "maxcut-hamming6-4.clq.wcnf", "maxcut-MANN_a9.clq.wcnf", "maxcut-p_hat500-3.clq.wcnf",
  "maxcut/dimacs_mod/MANN_a27.clq.wcnf", "maxcut/dimacs_mod/keller5.clq.wcnf", "maxcut/dimacs_mod/p_hat300-3.clq.wcnf", "maxcut/dimacs_mod/san200_0.7_1.clq.wcnf", "maxcut/dimacs_mod/san400_0.7_2.clq.wcnf", "maxcut/dimacs_mod/hamming10-2.clq.wcnf",
  "c-fat500-10.clq.wcnf", "hamming6-2.clq.wcnf", "hamming8-2.clq.wcnf", "hamming10-2.clq.wcnf", "johnson8-4-4.clq.wcnf", "MANN_a9.clq.wcnf", "MANN_a27.clq.wcnf", "MANN_a45.clq.wcnf", "MANN_a81.clq.wcnf",
  "brock200_3.clq.wcnf",
]
#removed:  "bip.maxcut-140-630-0.7-13.wcnf.xz", "bip.maxcut-140-630-0.7-37.wcnf.xz",  "bip.maxcut-140-630-0.7-42.wcnf.xz", "bip.maxcut-140-630-0.7-44.wcnf.xz", "bip.maxcut-140-630-0.8-24.wcnf.xz",   "ran.max_cut_60_600_4.asc.wcnf.xz", "ran.max_cut_60_600_9.asc.wcnf.xz"
# 169, 170, 161, 163, 165, 213, 218
#2020 SAT-like kc          
# for 2019 used maxut - dimacs_mod, non bipartite
# leave out bipartite
year = [2018, 2018, 2018, 2018, 2018, 2018,
  2019, 2019, 2019, 2019, 2019, 2019,
  2020, 2020, 2020, 2020, 2020, 2020, 2020, 2020, 2020,
  2021]
found_costs = []
loop_costs = []
found_times = []
vars = []
clauses = []

@timed bmz(2, [0 -1/4 1/4; -1/4 0 1/4; 1/4 1/4 0], [0 1 1; 1 0 1; 1 1 0], 10)

flush(stdout)
open("inc_files.txt") do f

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

      # make sure none are running more than 1 min / file
      stopper = true
      best_cost = m
      best_costs = []
      push!(best_costs, m)
      t = time()
      while stopper
        results = @timed bmz(n, W, num_clauses, 10)
        if time() > t + 60
          stopper = false
        else
          if (m - results[1][2]) < best_cost
            best_cost = m - results[1][2]
            push!(best_costs, best_cost)
          end
        end
      end

      push!(found_costs, best_cost)
      push!(loop_costs, best_costs)
      println("cost: ", best_cost)

    end
  end
end

output = open("60_output.txt", "w")
data = hcat(file_names, vars, clauses, found_costs, opt_costs, year, loop_costs)
str = pretty_table(String, data; header=header)
write(output, "Instances from incomplete track 2018-2022 \n")
write(output, str)
close(output)


# below a ratio of clauses to and above is hard below is easy
# two sat solver to download?? check email
# email renee both txt files
# print out each run for bmz(is it opt each time??)
# try these for the runs given
# print in whilte look where results = time