struct TopK <: SelectionStrategy
    k::Int
    TopK(k) = k > 0 ? new(k) : error("`k` needs to be greater than 0")
end
function (ss::TopK)(sequence_fitness_pairs::AbstractVector{<:Tuple{<:AbstractVector{Char}, Real}})
    sort!(sequence_fitness_pairs, by=x -> x[2], rev=true)
    selection = Vector{Vector{Char}}(undef, ss.k)
    for (idx, pair) in enumerate(sequence_fitness_pairs[1:ss.k])
        selection[idx] = pair[1]
    end
    return selection
end
