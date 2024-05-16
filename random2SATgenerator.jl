import Random
using StatsBase: sample

n = 100 #number of variables
m = Int(round(n + n^(2 / 3))) #number of clauses
files = open("random2SAT_2x.txt", "w")
for n = 100:200
    m = Int(round(n * 2))
    output = open("Random2SAT_2x/Random2SAT($n,$m)", "w")
    write(output, "p wcnf $n $m $(m+1) \n")

    for i = 1:m
        clause = sample(1:n, 2, replace=false)
        if rand() < 0.5
            clause[1] = -clause[1]
        end
        if rand() < 0.5
            clause[2] = -clause[2]
        end
        write(output, "1 $(clause[1]) $(clause[2]) 0 \n")
    end
    close(output)
    write(files, "Random2SAT_2x/Random2SAT($n,$m) \n")
end
close(files)

#accidentally ran this in random 2SAT ones so need to restart that