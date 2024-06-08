include("linesearch.jl")

W = []
num_edges = []
n = 0

function f(theta)
    return sum(sum(W[i,j]*(cos(theta[j]-theta[1])+cos(theta[i]-theta[j])-cos(theta[i]-theta[1])) for j in 1:n) for i in 1:n)
end

function grad_f(theta)
    return [sum(-W[i,j] * (sin(theta[i]-theta[j]) - sin(theta[i]-theta[1])) for j in 1:n) for i in 1:n]
end

function hess_f(theta)
    hess = zeros(n, n)
    for i = 1:n
        for j = 1:n
            if i == j
                hess[i,i] = sum(-W[i,j] * (cos(theta[i]-theta[j]) - cos(theta[i]-theta[1])) for j in 1:n)
            else
                hess[i,j] = W[i,j]*cos(theta[i]-theta[j])
            end
        end
    end
end

function assignment_value(W, assignment)
    val = 0
    for i = 2:n
        for j = 2:n
            val += (1/4)*W[i,j]*(1+assignment[i]*assignment[1])*(1-assignment[j]*assignment[1])
        end
    end
    return val
end

function procedure_assign(theta)
    best_assignment = []
    alpha = 0
    gamma = -Inf
    push!(theta, 2 * π)
    for i = 1:n+1
        assignment = generate_assignment(theta[i], theta)
        assignment_val = assignment_value(W, assignment)
        if assignment_val > gamma
            gamma = assignment_val
            best_assignment = assignment
        end
    end
    return best_assignment, gamma
end

function generate_assignment(alpha, theta)
    if alpha <= π
        assignment = filter(i -> theta[i] < alpha + π && theta[i] >= alpha, 1:n)
    else
        assignment = filter(i -> theta[i] < alpha && theta[i] >= alpha - π, 1:n)
    end

    assignment_vector = zeros(n)
    for i =1:n
        if i ∈ assignment
            assignment_vector[i] = 1
        else
            assignment_vector[i] = -1
        end
    end
    return assignment_vector
end

function local_search(W, adj_list, assignment, cut_value)
    updates = zeros(n)

    # current_cont = cut_value
    # flip_cont = reduce(+, reduce(+, W[j,i] for i ∈ filter(i -> assignment[i] == assignment[1], 1:n); init=0) for j ∈ filter(j -> assignment[j] != assignment[1], 1:n); init=0)
    # # flip_cont = sum(sum(W[j,i] for i ∈ filter(i -> assignment[i] == assignment[1], 1:n); init=0) for j ∈ filter(j -> assignment[j] != assignment[1], 1:n); init=0)
    # updates[1] = flip_cont - current_cont
    updates[1] = 0

    for i = 2:n
        relevant_row = W[i, :]
        relevant_col = W[:, i]
        if assignment[i] == assignment[1]
            current_cont = sum([relevant_row[j] for j ∈ filter(j -> relevant_row[j] != 0 && !(assignment[j] == assignment[1]), 1:n)])
            flip_cont = sum([relevant_col[j] for j ∈ filter(j -> relevant_col[j] != 0 && (assignment[j] == assignment[1]), 1:n)])
            updates[i] = flip_cont - current_cont
        else
            current_cont = sum([relevant_col[j] for j ∈ filter(j -> relevant_col[j] != 0 && (assignment[j] == assignment[1]), 1:n)])
            flip_cont = sum([relevant_row[j] for j ∈ filter(j -> relevant_row[j] != 0 && !(assignment[j] == assignment[1]), 1:n)])
            updates[i] = flip_cont - current_cont
        end
    end
    while findmax(updates)[1] > 0
        flip = argmax(updates)
        # println(flip)
        # println(updates[flip])
        cut_value += updates[flip]
        updates[flip] = -updates[flip]
        if flip == 1
            # println("flipping 1")
            # println(updates[flip])
            for i = 2:n
                relevant_row = W[i, :]
                relevant_col = W[:, i]
                if assignment[i] == assignment[1]
                    current_cont = sum([relevant_row[j] for j ∈ filter(j -> relevant_row[j] != 0 && !(assignment[j] == assignment[1]), 1:n)])
                    flip_cont = sum([relevant_col[j] for j ∈ filter(j -> relevant_col[j] != 0 && (assignment[j] == assignment[1]), 1:n)])
                    updates[i] = flip_cont - current_cont
                else
                    current_cont = sum([relevant_col[j] for j ∈ filter(j -> relevant_col[j] != 0 && (assignment[j] == assignment[1]), 1:n)])
                    flip_cont = sum([relevant_row[j] for j ∈ filter(j -> relevant_row[j] != 0 && !(assignment[j] == assignment[1]), 1:n)])
                    updates[i] = flip_cont - current_cont
                end
            end
            assignment[1] = -assignment[1]
        elseif assignment[flip] == assignment[1]
            # println("flipping something else")
            updatechange = 0
            for j in filter(j -> W[j,flip] != 0 && assignment[j] == assignment[1], 2:n)
                updates[j] = updates[j] - W[j,flip]
                updatechange -= W[j,flip]
            end
            for j in filter(j -> W[j,flip] != 0 && assignment[j] != assignment[1], 2:n)
                updates[j] = updates[j] + W[j, flip]
            end
            for j in filter(j -> W[flip,j] != 0 && assignment[j] == assignment[1], 2:n)
                updates[j] = updates[j] - W[flip,j]
                updatechange += W[flip,j]
            end
            for j in filter(j -> W[flip,j] !=0 && assignment[j] != assignment[1], 2:n)
                updates[j] = updates[j] + W[flip,j]
            end
            # updates[1] += updatechange
            assignment[flip] = -assignment[flip]
        else
            # println("flipping something else")
            updatechange = 0
            for j in filter(j -> W[j,flip] != 0 && assignment[j] == assignment[1], 2:n)
                updates[j] = updates[j] + W[j,flip]
            end
            for j in filter(j -> W[j,flip] != 0 && assignment[j] != assignment[1], 2:n)
                updates[j] = updates[j] - W[j, flip]
                updatechange += W[j,flip]
            end
            for j in filter(j -> W[flip, j] != 0 && assignment[j] == assignment[1], 2:n)
                updates[j] = updates[j] + W[flip,j]
            end
            for j in filter(j -> W[flip,j] != 0 && assignment[j] != assignment[1], 2:n)
                updates[j] = updates[j] - W[flip,j]
                updatechange -= W[flip,j]
            end
            assignment[flip] = -assignment[flip]
            # updates[1] += updatechange
        end
    end
    return assignment, cut_value
end

function bmz(nn, adj_list, weights, N)
    global W = weights
    global n = nn + 1

    k = 0
    gamma = -Inf
    best_assignment = []

    temp = rand(n)
    theta_init = 2 * π .* temp

    while k < N

        result = line_search(f,theta_init,grad_f, hess_f)
        opt_theta = result[length(result)]

        for i = 1:n
            if opt_theta[i] > (2 * π)
                opt_theta[i] = opt_theta[i] % (2 * π)
            elseif opt_theta[i] < 0
                while opt_theta[i] < 0
                    opt_theta[i] = opt_theta[i] + 2 * π
                end
            end
        end

        assignment, assignment_val = procedure_assign(opt_theta)
        # println(assignment_val)
        # println("before search")
        assignment, assignment_val = local_search(W, adj_list, assignment, assignment_val)
        # println(assignment_val)
        # local search here?

        if assignment_val > gamma
            gamma = assignment_val
            best_assignment = assignment
            k = 0
        else
            k = k + 1
        end

        y = zeros(n)
        for i = 1:n
            if assignment[i] == 1
                y[i] = π
            end
        end

        theta_init = [y[i] + rand([-π, π]) * 0.5 for i in 1:n]

    end
    return (best_assignment, gamma)
end
