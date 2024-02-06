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
    parents::Vector{Vector{Char}}, # TODO define `Sequence` type with constrained alphabet
    screen::Function,
    selection_strategy::Type{<:SelectionStrategy},
    mutagenesis::Type{<:Mutagenesis},
    alphabet::Set{Char},
    n_iterations::Integer=1,
    k_selected::Integer=1,
    m_mutated::Integer=1,
)
    @assert n_iterations > 0
    assure_parents_from_alphabet(parents, alphabet)

    mutate = mutagenesis(m_mutated, alphabet)
    select = selection_strategy(k_selected)

    top_variant = nothing
    top_fitness = -1. # TODO define as min of screen return type

    function update_top_variant!(variant_fitness_pairs)
        #function Base.isless(::Nothing, ::Real)
        #    true
        #end
        #function Base.isless(::Real, ::Nothing)
        #    false
        #end

        for (variant, fitness) in variant_fitness_pairs
            if fitness >= top_fitness
                top_fitness = fitness
                top_variant = copy(variant)
            end
        end
    end

    for iter in 1:n_iterations
        variant_library = mutate(parents)
        variant_fitness_pairs = screen_variants(variant_library, screen)
        update_top_variant!(variant_fitness_pairs)
        parents = select(variant_fitness_pairs)
    end

    return top_variant, top_fitness
end

function assure_parents_from_alphabet(parents, alphabet)
    for parent in parents
        if !sequence_from_alphabet(parent, alphabet)
            error("`parents` cannot contain characters which are not from the `alphabet`.")
        end
    end
end

function screen_variants(variant_library::Vector{Vector{Char}}, screen::Function)
    # TODO make Tuple{Vector{Char}, T} where {T is return type of `screen`}
    variant_fitness_pairs = Vector{Tuple{Vector{Char}, Real}}(undef, length(variant_library))
    for (idx, variant) in enumerate(variant_library)
        variant_fitness_pairs[idx] = (variant, screen(variant))
    end
    return variant_fitness_pairs
end
