"""
    TODO ... = de(...)

# Arguments

- `parents`
- `screen::Function`: Assigns fitness value to a sequence. Signature screen(::Vector{Char}), returns T where {T<:Real}.
- `selection`
- `mutagenesis`
- `n_iterations::Integer=1`: Specifies the number of iteration of DE. Has to be greater than 0.
"""
function de!(
    sequence_space::SequenceSpace;
    screening::Screening,
    selection_strategy::SelectionStrategy,
    mutagenesis::Mutagenesis,
    n_iterations::Int=1,
)
    @assert n_iterations > 0
    #assure_parents_from_alphabet(parents, alphabet)

    for _ in 1:n_iterations
        sequence_space.population = mutagenesis(sequence_space.population)
        variants = screeen_mutants(sequence_space.population, screening)
        push_variants!(sequence_space, variants)
        sequence_space.population = selection_strategy(variants)
    end
end

function screeen_mutants(sequences::AbstractVector{<:AbstractVector{Char}}, screening::Screening)
    variants = Vector{Variant}(undef, length(sequences))
    for (idx, sequence) in enumerate(sequences)
        variants[idx] = Variant(sequence, screening(sequence))
    end
    return variants
end

#function assure_parents_from_alphabet(parents, alphabet)
#    for parent in parents
#        if !sequence_from_alphabet(parent, alphabet)
#            error("`parents` cannot contain characters which are not from the `alphabet`.")
#        end
#    end
#end
