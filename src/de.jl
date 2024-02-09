"""
    TODO ... = de(...)

# Arguments

- `parents`
- `screen::Function`: Assigns fitness value to a sequence. Signature screen(::Vector{Char}), returns T where {T<:Real}.
- `selection`
- `mutagenesis`
- `n_iterations::Integer=1`: Specifies the number of iteration of DE. Has to be greater than 0.
"""
function de(
    parents::AbstractVector{<:AbstractVector{Char}},
    screening::Screening,
    selection_strategy::SelectionStrategy,
    mutagenesis::Mutagenesis;
    n_iterations::Int=1,
)
    @assert n_iterations > 0
    #assure_parents_from_alphabet(parents, alphabet)

    top_variant = nothing
    top_fitness = nothing

    function update_top_variant!(variant_fitness_pairs::AbstractVector{<:Tuple{<:AbstractVector{Char},<:Real}})
        if isnothing(top_fitness)
            top_fitness = variant_fitness_pairs[1][2]
            top_variant = variant_fitness_pairs[1][1]
        end
        for (variant, fitness) in variant_fitness_pairs
            if fitness >= top_fitness
                top_fitness = fitness
                top_variant = copy(variant)
            end
        end
    end

    for _ in 1:n_iterations
        variant_library = mutagenesis(parents)
        variant_fitness_pairs = screen_variants(variant_library, screening)
        update_top_variant!(variant_fitness_pairs)
        parents = selection_strategy(variant_fitness_pairs)
    end

    return top_variant, top_fitness
end

function screen_variants(variant_library::AbstractVector{<:AbstractVector{Char}}, screening::Screening)
    variant_fitness_pairs = Vector{Tuple{Vector{Char},Real}}(undef, length(variant_library))
    for (idx, variant) in enumerate(variant_library)
        variant_fitness_pairs[idx] = (variant, screening(variant))
    end
    return variant_fitness_pairs
end

#function assure_parents_from_alphabet(parents, alphabet)
#    for parent in parents
#        if !sequence_from_alphabet(parent, alphabet)
#            error("`parents` cannot contain characters which are not from the `alphabet`.")
#        end
#    end
#end
