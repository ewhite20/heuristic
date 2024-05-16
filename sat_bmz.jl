include("linesearch.jl")

W = []
num_clauses = []

function f(theta)
    n = length(theta) - 1
    return sum(sum(W[i, j] * cos(theta[i] - theta[j]) for j in 1:n+1) for i in 1:n+1)
end

function grad_f(theta)
    n = length(theta) - 1
    return [sum(-W[j, k] * sin(theta[j] - theta[k]) for k in 1:n+1) for j in 1:n+1]
end

function hess_f(theta)
    n = length(theta) - 1
    hess = zeros(n + 1, n + 1)
    for i = 1:n+1
        for j = 1:n+1
            if i == j
                hess[i, i] = -sum(W[k, i] * cos(theta[k] - theta[i]) for k in 1:n+1)
            else
                hess[i, j] = W[i, j] * cos(theta[i] - theta[j])
            end
        end
    end
    return hess
end

function assignment_value(W, assignment)
    n = Int(sqrt(length(W)) - 1)
    val = 0
    for i = 1:n+1
        for j = i:n+1
            val += (1 / 4) * num_clauses[i, j] + W[i, j] * assignment[i] * assignment[j]
        end
    end
    return val
end

function procedure_assign(theta)
    n = length(theta) - 1
    best_assignment = []
    alpha = 0
    gamma = -Inf
    push!(theta, 2 * π)
    for i = 1:n+2
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
    n = length(theta) - 1
    if alpha <= π
        assignment = filter(i -> theta[i] < alpha + π && theta[i] >= alpha, 1:n)
    else
        assignment = filter(i -> theta[i] < alpha && theta[i] >= alpha - π, 1:n)
    end

    assignment_vector = zeros(n + 1)
    for i = 1:n+1
        if i ∈ assignment
            assignment_vector[i] = 1
        else
            assignment_vector[i] = -1
        end
    end
    return assignment_vector
end


function local_search(W, assignment, assignment_val)
    n = Int(sqrt(length(W)) - 1)
    updates = zeros(n + 1)
    temp_assignment = assignment

    for i = 1:n+1
        if assignment[i] == 1
            temp_assignment[i] = -1
            updates[i] = assignment_value(W, temp_assignment) - assignment_val
            temp_assignment[i] = 1
        else
            temp_assignment[i] = 1
            updates[i] = assignment_value(W, temp_assignment) - assignment_val
            temp_assignment[i] = -1
        end
    end

    while findmax(updates)[1] > 0
        flip = argmax(updates)
        assignment_val += updates[flip]
        if assignment[flip] == 1
            assignment[flip] = -1
        else
            assignment[flip] = 1
        end

        for i = 1:n+1
            if assignment[i] == 1
                temp_assignment[i] = -1
                updates[i] = assignment_value(W, temp_assignment) - assignment_val
                temp_assignment[i] = 1
            else
                temp_assignment[i] = 1
                updates[i] = assignment_value(W, temp_assignment) - assignment_val
                temp_assignment[i] = -1
            end
        end

    end
    return assignment, assignment_val
end



function bmz(n, weights, nums, N)
    global W = weights
    global num_clauses = nums

    k = 0
    gamma = -Inf
    best_assignment = []

    temp = rand(n + 1)
    theta_init = 2 * π .* temp

    while k < N

        result = line_search(f, theta_init, grad_f, hess_f)
        opt_theta = result[length(result)]

        for i = 1:n+1
            if opt_theta[i] > (2 * π)
                opt_theta[i] = opt_theta[i] % (2 * π)
            elseif opt_theta[i] < 0
                while opt_theta[i] < 0
                    opt_theta[i] = opt_theta[i] + 2 * π
                end
            end
        end

        assignment, assignment_val = procedure_assign(opt_theta)
        assignment, assignment_val = local_search(W, assignment, assignment_val)
        # local search here?

        if assignment_val > gamma
            gamma = assignment_val
            best_assignment = assignment
            k = 0
        else
            k = k + 1
        end

        y = zeros(n + 1)
        for i = 1:n+1
            if assignment[i] == 1
                y[i] = π
            end
        end

        theta_init = [y[i] + rand([-π, π]) * 0.2 for i in 1:n+1]

    end

    # println(best_assignment)
    # println(gamma)
    return (best_assignment, gamma)

end
