"""
Selects `k` sequences with the highest fitness.

    TopK(k::Int)

# Arguments
- `k::Int`: Defines the number of sequences which will be selected.
"""
struct TopK <: SelectionStrategy
    k::Int
    TopK(k::Int) = k > 0 ? new(k) : throw(ArgumentError("`k` needs to be greater than 0"))
end

function (ss::TopK)(variants::AbstractVector{Variant})
    @assert length(variants) >= ss.k
    sort!(variants, by=x -> x.fitness, rev=true)
    selection = Vector{Vector{Char}}(undef, ss.k)
    for (idx, variant) in enumerate(variants[1:ss.k])
        selection[idx] = variant.sequence
    end
    return selection
end
