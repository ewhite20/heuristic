include("sat_bmz.jl")
using PrettyTables
# 2x
opt_2 = [4, 3, 5, 5, 2, 4, 5, 6, 3, 4, 6, 5, 5, 5, 5, 5, 3, 6, 2, 6, 6, 5, 4, 5, 3, 6, 5, 4, 6, 9, 7, 5, 8, 5, 5, 7, 8, 3, 10, 8, 6, 4, 5, 7, 5, 4, 7, 6, 7, 7, 2, 5, 7, 6, 7, 6, 4, 6, 4, 9, 6, 6, 8, 7, 4, 5, 5, 7, 7, 9, 7, 6, 9, 11, 10, 8, 8, 6, 9, 10, 5, 8, 8, 9, 7, 9, 9, 7, 8, 7, 8, 9, 8, 9, 10, 5, 7, 9, 7, 9, 9]
# 1.5x
opt_1_5 = [2, 1, 1, 0, 1, 1, 1, 3, 0, 0, 1, 0, 3, 2, 0, 1, 0, 0, 1, 2, 2, 1, 0, 0, 1, 0, 0, 0, 3, 2, 2, 3, 0, 1, 2, 1, 4, 3, 3, 1, 2, 1, 2, 1, 0, 1, 4, 2, 3, 1, 2, 1, 1, 2, 2, 1, 2, 3, 0, 2, 0, 0, 1, 1, 2, 3, 1, 0, 3, 1, 2, 3, 2, 1, 0, 1, 1, 2, 2, 0, 1, 2, 3, 0, 1, 3, 2, 5, 3, 3, 3, 2, 3, 1, 1, 1, 4, 2, 4, 1, 1]
# og
opt = [0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 2, 1, 0, 1, 0, 0]

header = ["Instance", "Found cost", "Loop Costs", "Ratio"]
# Renee Made Random Instances
#file_names = ["Random2SAT(100,122)", "Random2SAT(101,123)", "Random2SAT(102,124)", "Random2SAT(103,125)", "Random2SAT(104,126)", "Random2SAT(105,127)", "Random2SAT(106,128)", "Random2SAT(107,130)", "Random2SAT(108,131)", "Random2SAT(109,132)", "Random2SAT(110,133)", "Random2SAT(111,134)", "Random2SAT(112,135)", "Random2SAT(113,136)", "Random2SAT(114,138)", "Random2SAT(115,139)", "Random2SAT(116,140)", "Random2SAT(117,141)", "Random2SAT(118,142)", "Random2SAT(119,143)", "Random2SAT(120,144)", "Random2SAT(121,145)", "Random2SAT(122,147)", "Random2SAT(123,148)", "Random2SAT(124,149)", "Random2SAT(125,150)", "Random2SAT(126,151)", "Random2SAT(127,152)", "Random2SAT(128,153)", "Random2SAT(129,155)", "Random2SAT(130,156)", "Random2SAT(131,157)", "Random2SAT(132,158)", "Random2SAT(133,159)", "Random2SAT(134,160)", "Random2SAT(135,161)", "Random2SAT(136,162)", "Random2SAT(137,164)", "Random2SAT(138,165)", "Random2SAT(139,166)", "Random2SAT(140,167)", "Random2SAT(141,168)", "Random2SAT(142,169)", "Random2SAT(143,170)", "Random2SAT(144,171)", "Random2SAT(145,173)", "Random2SAT(146,174)", "Random2SAT(147,175)", "Random2SAT(148,176)", "Random2SAT(149,177)", "Random2SAT(150,178)", "Random2SAT(151,179)", "Random2SAT(152,180)", "Random2SAT(153,182)", "Random2SAT(154,183)", "Random2SAT(155,184)", "Random2SAT(156,185)", "Random2SAT(157,186)", "Random2SAT(158,187)", "Random2SAT(159,188)", "Random2SAT(160,189)", "Random2SAT(161,191)", "Random2SAT(162,192)", "Random2SAT(163,193)", "Random2SAT(164,194)", "Random2SAT(165,195)", "Random2SAT(166,196)", "Random2SAT(167,197)", "Random2SAT(168,198)", "Random2SAT(169,200)", "Random2SAT(170,201)", "Random2SAT(171,202)", "Random2SAT(172,203)", "Random2SAT(173,204)", "Random2SAT(174,205)", "Random2SAT(175,206)", "Random2SAT(176,207)", "Random2SAT(177,209)", "Random2SAT(178,210)", "Random2SAT(179,211)", "Random2SAT(180,212)", "Random2SAT(181,213)", "Random2SAT(182,214)", "Random2SAT(183,215)", "Random2SAT(184,216)", "Random2SAT(185,217)", "Random2SAT(186,219)", "Random2SAT(187,220)", "Random2SAT(188,221)", "Random2SAT(189,222)", "Random2SAT(190,223)", "Random2SAT(191,224)", "Random2SAT(192,225)", "Random2SAT(193,226)", "Random2SAT(194,228)", "Random2SAT(195,229)", "Random2SAT(196,230)", "Random2SAT(197,231)", "Random2SAT(198,232)", "Random2SAT(199,233)", "Random2SAT(200,234)"]
# Phrases with 2x more clauses than vars
#file_names = ["Random2SAT_2x/Random2SAT(100,200)", "Random2SAT_2x/Random2SAT(101,202)", "Random2SAT_2x/Random2SAT(102,204)", "Random2SAT_2x/Random2SAT(103,206)", "Random2SAT_2x/Random2SAT(104,208)", "Random2SAT_2x/Random2SAT(105,210)", "Random2SAT_2x/Random2SAT(106,212)", "Random2SAT_2x/Random2SAT(107,214)", "Random2SAT_2x/Random2SAT(108,216)", "Random2SAT_2x/Random2SAT(109,218)", "Random2SAT_2x/Random2SAT(110,220)", "Random2SAT_2x/Random2SAT(111,222)", "Random2SAT_2x/Random2SAT(112,224)", "Random2SAT_2x/Random2SAT(113,226)", "Random2SAT_2x/Random2SAT(114,228)", "Random2SAT_2x/Random2SAT(115,230)", "Random2SAT_2x/Random2SAT(116,232)", "Random2SAT_2x/Random2SAT(117,234)", "Random2SAT_2x/Random2SAT(118,236)", "Random2SAT_2x/Random2SAT(119,238)", "Random2SAT_2x/Random2SAT(120,240)", "Random2SAT_2x/Random2SAT(121,242)", "Random2SAT_2x/Random2SAT(122,244)", "Random2SAT_2x/Random2SAT(123,246)", "Random2SAT_2x/Random2SAT(124,248)", "Random2SAT_2x/Random2SAT(125,250)", "Random2SAT_2x/Random2SAT(126,252)", "Random2SAT_2x/Random2SAT(127,254)", "Random2SAT_2x/Random2SAT(128,256)", "Random2SAT_2x/Random2SAT(129,258)", "Random2SAT_2x/Random2SAT(130,260)", "Random2SAT_2x/Random2SAT(131,262)", "Random2SAT_2x/Random2SAT(132,264)", "Random2SAT_2x/Random2SAT(133,266)", "Random2SAT_2x/Random2SAT(134,268)", "Random2SAT_2x/Random2SAT(135,270)", "Random2SAT_2x/Random2SAT(136,272)", "Random2SAT_2x/Random2SAT(137,274)", "Random2SAT_2x/Random2SAT(138,276)", "Random2SAT_2x/Random2SAT(139,278)", "Random2SAT_2x/Random2SAT(140,280)", "Random2SAT_2x/Random2SAT(141,282)", "Random2SAT_2x/Random2SAT(142,284)", "Random2SAT_2x/Random2SAT(143,286)", "Random2SAT_2x/Random2SAT(144,288)", "Random2SAT_2x/Random2SAT(145,290)", "Random2SAT_2x/Random2SAT(146,292)", "Random2SAT_2x/Random2SAT(147,294)", "Random2SAT_2x/Random2SAT(148,296)", "Random2SAT_2x/Random2SAT(149,298)", "Random2SAT_2x/Random2SAT(150,300)", "Random2SAT_2x/Random2SAT(151,302)", "Random2SAT_2x/Random2SAT(152,304)", "Random2SAT_2x/Random2SAT(153,306)", "Random2SAT_2x/Random2SAT(154,308)", "Random2SAT_2x/Random2SAT(155,310)", "Random2SAT_2x/Random2SAT(156,312)", "Random2SAT_2x/Random2SAT(157,314)", "Random2SAT_2x/Random2SAT(158,316)", "Random2SAT_2x/Random2SAT(159,318)", "Random2SAT_2x/Random2SAT(160,320)", "Random2SAT_2x/Random2SAT(161,322)", "Random2SAT_2x/Random2SAT(162,324)", "Random2SAT_2x/Random2SAT(163,326)", "Random2SAT_2x/Random2SAT(164,328)", "Random2SAT_2x/Random2SAT(165,330)", "Random2SAT_2x/Random2SAT(166,332)", "Random2SAT_2x/Random2SAT(167,334)", "Random2SAT_2x/Random2SAT(168,336)", "Random2SAT_2x/Random2SAT(169,338)", "Random2SAT_2x/Random2SAT(170,340)", "Random2SAT_2x/Random2SAT(171,342)", "Random2SAT_2x/Random2SAT(172,344)", "Random2SAT_2x/Random2SAT(173,346)", "Random2SAT_2x/Random2SAT(174,348)", "Random2SAT_2x/Random2SAT(175,350)", "Random2SAT_2x/Random2SAT(176,352)", "Random2SAT_2x/Random2SAT(177,354)", "Random2SAT_2x/Random2SAT(178,356)", "Random2SAT_2x/Random2SAT(179,358)", "Random2SAT_2x/Random2SAT(180,360)", "Random2SAT_2x/Random2SAT(181,362)", "Random2SAT_2x/Random2SAT(182,364)", "Random2SAT_2x/Random2SAT(183,366)", "Random2SAT_2x/Random2SAT(184,368)", "Random2SAT_2x/Random2SAT(185,370)", "Random2SAT_2x/Random2SAT(186,372)", "Random2SAT_2x/Random2SAT(187,374)", "Random2SAT_2x/Random2SAT(188,376)", "Random2SAT_2x/Random2SAT(189,378)", "Random2SAT_2x/Random2SAT(190,380)", "Random2SAT_2x/Random2SAT(191,382)", "Random2SAT_2x/Random2SAT(192,384)", "Random2SAT_2x/Random2SAT(193,386)", "Random2SAT_2x/Random2SAT(194,388)", "Random2SAT_2x/Random2SAT(195,390)", "Random2SAT_2x/Random2SAT(196,392)", "Random2SAT_2x/Random2SAT(197,394)", "Random2SAT_2x/Random2SAT(198,396)", "Random2SAT_2x/Random2SAT(199,398)", "Random2SAT_2x/Random2SAT(200,400)"]
# Phrases with 50% clauses compared to vars
file_names = ["Random2SAT_50%/Random2SAT(100,50)", "Random2SAT_50%/Random2SAT(101,50)", "Random2SAT_50%/Random2SAT(102,51)", "Random2SAT_50%/Random2SAT(103,52)", "Random2SAT_50%/Random2SAT(104,52)", "Random2SAT_50%/Random2SAT(105,52)", "Random2SAT_50%/Random2SAT(106,53)", "Random2SAT_50%/Random2SAT(107,54)", "Random2SAT_50%/Random2SAT(108,54)", "Random2SAT_50%/Random2SAT(109,54)", "Random2SAT_50%/Random2SAT(110,55)", "Random2SAT_50%/Random2SAT(111,56)", "Random2SAT_50%/Random2SAT(112,56)", "Random2SAT_50%/Random2SAT(113,56)", "Random2SAT_50%/Random2SAT(114,57)", "Random2SAT_50%/Random2SAT(115,58)", "Random2SAT_50%/Random2SAT(116,58)", "Random2SAT_50%/Random2SAT(117,58)", "Random2SAT_50%/Random2SAT(118,59)", "Random2SAT_50%/Random2SAT(119,60)", "Random2SAT_50%/Random2SAT(120,60)", "Random2SAT_50%/Random2SAT(121,60)", "Random2SAT_50%/Random2SAT(122,61)", "Random2SAT_50%/Random2SAT(123,62)", "Random2SAT_50%/Random2SAT(124,62)", "Random2SAT_50%/Random2SAT(125,62)", "Random2SAT_50%/Random2SAT(126,63)", "Random2SAT_50%/Random2SAT(127,64)", "Random2SAT_50%/Random2SAT(128,64)", "Random2SAT_50%/Random2SAT(129,64)", "Random2SAT_50%/Random2SAT(130,65)", "Random2SAT_50%/Random2SAT(131,66)", "Random2SAT_50%/Random2SAT(132,66)", "Random2SAT_50%/Random2SAT(133,66)", "Random2SAT_50%/Random2SAT(134,67)", "Random2SAT_50%/Random2SAT(135,68)", "Random2SAT_50%/Random2SAT(136,68)", "Random2SAT_50%/Random2SAT(137,68)", "Random2SAT_50%/Random2SAT(138,69)", "Random2SAT_50%/Random2SAT(139,70)", "Random2SAT_50%/Random2SAT(140,70)", "Random2SAT_50%/Random2SAT(141,70)", "Random2SAT_50%/Random2SAT(142,71)", "Random2SAT_50%/Random2SAT(143,72)", "Random2SAT_50%/Random2SAT(144,72)", "Random2SAT_50%/Random2SAT(145,72)", "Random2SAT_50%/Random2SAT(146,73)", "Random2SAT_50%/Random2SAT(147,74)", "Random2SAT_50%/Random2SAT(148,74)", "Random2SAT_50%/Random2SAT(149,74)", "Random2SAT_50%/Random2SAT(150,75)", "Random2SAT_50%/Random2SAT(151,76)", "Random2SAT_50%/Random2SAT(152,76)", "Random2SAT_50%/Random2SAT(153,76)", "Random2SAT_50%/Random2SAT(154,77)", "Random2SAT_50%/Random2SAT(155,78)", "Random2SAT_50%/Random2SAT(156,78)", "Random2SAT_50%/Random2SAT(157,78)", "Random2SAT_50%/Random2SAT(158,79)", "Random2SAT_50%/Random2SAT(159,80)", "Random2SAT_50%/Random2SAT(160,80)", "Random2SAT_50%/Random2SAT(161,80)", "Random2SAT_50%/Random2SAT(162,81)", "Random2SAT_50%/Random2SAT(163,82)", "Random2SAT_50%/Random2SAT(164,82)", "Random2SAT_50%/Random2SAT(165,82)", "Random2SAT_50%/Random2SAT(166,83)", "Random2SAT_50%/Random2SAT(167,84)", "Random2SAT_50%/Random2SAT(168,84)", "Random2SAT_50%/Random2SAT(169,84)", "Random2SAT_50%/Random2SAT(170,85)", "Random2SAT_50%/Random2SAT(171,86)", "Random2SAT_50%/Random2SAT(172,86)", "Random2SAT_50%/Random2SAT(173,86)", "Random2SAT_50%/Random2SAT(174,87)", "Random2SAT_50%/Random2SAT(175,88)", "Random2SAT_50%/Random2SAT(176,88)", "Random2SAT_50%/Random2SAT(177,88)", "Random2SAT_50%/Random2SAT(178,89)", "Random2SAT_50%/Random2SAT(179,90)", "Random2SAT_50%/Random2SAT(180,90)", "Random2SAT_50%/Random2SAT(181,90)", "Random2SAT_50%/Random2SAT(182,91)", "Random2SAT_50%/Random2SAT(183,92)", "Random2SAT_50%/Random2SAT(184,92)", "Random2SAT_50%/Random2SAT(185,92)", "Random2SAT_50%/Random2SAT(186,93)", "Random2SAT_50%/Random2SAT(187,94)", "Random2SAT_50%/Random2SAT(188,94)", "Random2SAT_50%/Random2SAT(189,94)", "Random2SAT_50%/Random2SAT(190,95)", "Random2SAT_50%/Random2SAT(191,96)", "Random2SAT_50%/Random2SAT(192,96)", "Random2SAT_50%/Random2SAT(193,96)", "Random2SAT_50%/Random2SAT(194,97)", "Random2SAT_50%/Random2SAT(195,98)", "Random2SAT_50%/Random2SAT(196,98)", "Random2SAT_50%/Random2SAT(197,98)", "Random2SAT_50%/Random2SAT(198,99)", "Random2SAT_50%/Random2SAT(199,100)", "Random2SAT_50%/Random2SAT(200,100)"]
#file_names = ["Random2SAT_1.5x/Random2SAT(100,150)", "Random2SAT_1.5x/Random2SAT(101,152)", "Random2SAT_1.5x/Random2SAT(102,153)", "Random2SAT_1.5x/Random2SAT(103,154)", "Random2SAT_1.5x/Random2SAT(104,156)", "Random2SAT_1.5x/Random2SAT(105,158)", "Random2SAT_1.5x/Random2SAT(106,159)", "Random2SAT_1.5x/Random2SAT(107,160)", "Random2SAT_1.5x/Random2SAT(108,162)", "Random2SAT_1.5x/Random2SAT(109,164)", "Random2SAT_1.5x/Random2SAT(110,165)", "Random2SAT_1.5x/Random2SAT(111,166)", "Random2SAT_1.5x/Random2SAT(112,168)", "Random2SAT_1.5x/Random2SAT(113,170)", "Random2SAT_1.5x/Random2SAT(114,171)", "Random2SAT_1.5x/Random2SAT(115,172)", "Random2SAT_1.5x/Random2SAT(116,174)", "Random2SAT_1.5x/Random2SAT(117,176)", "Random2SAT_1.5x/Random2SAT(118,177)", "Random2SAT_1.5x/Random2SAT(119,178)", "Random2SAT_1.5x/Random2SAT(120,180)", "Random2SAT_1.5x/Random2SAT(121,182)", "Random2SAT_1.5x/Random2SAT(122,183)", "Random2SAT_1.5x/Random2SAT(123,184)", "Random2SAT_1.5x/Random2SAT(124,186)", "Random2SAT_1.5x/Random2SAT(125,188)", "Random2SAT_1.5x/Random2SAT(126,189)", "Random2SAT_1.5x/Random2SAT(127,190)", "Random2SAT_1.5x/Random2SAT(128,192)", "Random2SAT_1.5x/Random2SAT(129,194)", "Random2SAT_1.5x/Random2SAT(130,195)", "Random2SAT_1.5x/Random2SAT(131,196)", "Random2SAT_1.5x/Random2SAT(132,198)", "Random2SAT_1.5x/Random2SAT(133,200)", "Random2SAT_1.5x/Random2SAT(134,201)", "Random2SAT_1.5x/Random2SAT(135,202)", "Random2SAT_1.5x/Random2SAT(136,204)", "Random2SAT_1.5x/Random2SAT(137,206)", "Random2SAT_1.5x/Random2SAT(138,207)", "Random2SAT_1.5x/Random2SAT(139,208)", "Random2SAT_1.5x/Random2SAT(140,210)", "Random2SAT_1.5x/Random2SAT(141,212)", "Random2SAT_1.5x/Random2SAT(142,213)", "Random2SAT_1.5x/Random2SAT(143,214)", "Random2SAT_1.5x/Random2SAT(144,216)", "Random2SAT_1.5x/Random2SAT(145,218)", "Random2SAT_1.5x/Random2SAT(146,219)", "Random2SAT_1.5x/Random2SAT(147,220)", "Random2SAT_1.5x/Random2SAT(148,222)", "Random2SAT_1.5x/Random2SAT(149,224)", "Random2SAT_1.5x/Random2SAT(150,225)", "Random2SAT_1.5x/Random2SAT(151,226)", "Random2SAT_1.5x/Random2SAT(152,228)", "Random2SAT_1.5x/Random2SAT(153,230)", "Random2SAT_1.5x/Random2SAT(154,231)", "Random2SAT_1.5x/Random2SAT(155,232)", "Random2SAT_1.5x/Random2SAT(156,234)", "Random2SAT_1.5x/Random2SAT(157,236)", "Random2SAT_1.5x/Random2SAT(158,237)", "Random2SAT_1.5x/Random2SAT(159,238)", "Random2SAT_1.5x/Random2SAT(160,240)", "Random2SAT_1.5x/Random2SAT(161,242)", "Random2SAT_1.5x/Random2SAT(162,243)", "Random2SAT_1.5x/Random2SAT(163,244)", "Random2SAT_1.5x/Random2SAT(164,246)", "Random2SAT_1.5x/Random2SAT(165,248)", "Random2SAT_1.5x/Random2SAT(166,249)", "Random2SAT_1.5x/Random2SAT(167,250)", "Random2SAT_1.5x/Random2SAT(168,252)", "Random2SAT_1.5x/Random2SAT(169,254)", "Random2SAT_1.5x/Random2SAT(170,255)", "Random2SAT_1.5x/Random2SAT(171,256)", "Random2SAT_1.5x/Random2SAT(172,258)", "Random2SAT_1.5x/Random2SAT(173,260)", "Random2SAT_1.5x/Random2SAT(174,261)", "Random2SAT_1.5x/Random2SAT(175,262)", "Random2SAT_1.5x/Random2SAT(176,264)", "Random2SAT_1.5x/Random2SAT(177,266)", "Random2SAT_1.5x/Random2SAT(178,267)", "Random2SAT_1.5x/Random2SAT(179,268)", "Random2SAT_1.5x/Random2SAT(180,270)", "Random2SAT_1.5x/Random2SAT(181,272)", "Random2SAT_1.5x/Random2SAT(182,273)", "Random2SAT_1.5x/Random2SAT(183,274)", "Random2SAT_1.5x/Random2SAT(184,276)", "Random2SAT_1.5x/Random2SAT(185,278)", "Random2SAT_1.5x/Random2SAT(186,279)", "Random2SAT_1.5x/Random2SAT(187,280)", "Random2SAT_1.5x/Random2SAT(188,282)", "Random2SAT_1.5x/Random2SAT(189,284)", "Random2SAT_1.5x/Random2SAT(190,285)", "Random2SAT_1.5x/Random2SAT(191,286)", "Random2SAT_1.5x/Random2SAT(192,288)", "Random2SAT_1.5x/Random2SAT(193,290)", "Random2SAT_1.5x/Random2SAT(194,291)", "Random2SAT_1.5x/Random2SAT(195,292)", "Random2SAT_1.5x/Random2SAT(196,294)", "Random2SAT_1.5x/Random2SAT(197,296)", "Random2SAT_1.5x/Random2SAT(198,297)", "Random2SAT_1.5x/Random2SAT(199,298)", "Random2SAT_1.5x/Random2SAT(200,300)"]

found_costs = []
loop_costs = []
found_times = []
ratio = []
k = 1
@timed bmz(2, [0 -1/4 1/4; -1/4 0 1/4; 1/4 1/4 0], [0 1 1; 1 0 1; 1 1 0], 10)

flush(stdout)
open("random2SAT_2x.txt") do f

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
      if (best_cost == n)
        best_cost = 0
      end
      res = (n - best_cost) / (100 - opt[k])
      push!(ratio, res)

    end
  end
end

output = open("60_ran2x_output.txt", "w")
data = hcat(file_names, found_costs, loop_costs, ratio, opt)
str = pretty_table(String, data; header=header)
write(output, "Random 2SAT instances \n")
write(output, str)
close(output)
