"""
    TODO ... = de(...)

# Arguments

- `sequence_space::SequenceSpace`:
- `screening::Screening`: Assigns fitness value to a sequence.
- `selection_strategy::SelectionStrategy`:
- `mutagenesis:Mutagenesis`:
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
