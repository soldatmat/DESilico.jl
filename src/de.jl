"""
    de!(sequence_space::SequenceSpace; kwargs...)

Perform directed `n_iterations` of directed evolution and save results into `sequence_space`.

# Arguments
- `sequence_space::SequenceSpace`: Maintains the current population of mutants and library of screened variants.

# Keywords
- `screening::Screening`: Assigns fitness value to a sequence.
- `selection_strategy::SelectionStrategy`: Defines the algorithm used to select new parents from a pool of screened variants.
- `mutagenesis:Mutagenesis`: Defines the algorithm used to create new mutants from current population.
- `n_iterations::Integer=1`: Specifies the number of iteration of DE. Has to be greater than 0.

# Examples
See 'https://github.com/soldamatlab/DESilico.jl/blob/master/scripts/de_example.jl' for example of usage.
See 'https://github.com/soldamatlab/DESilico.jl/blob/master/scripts/custom_modules_example.jl' for example of usage with custom
    Screening, SelectionStrategy and Mutagenesis modules.
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

function screeen_mutants(sequences::AbstractVector{Vector{Char}}, screening::Screening)
    fitness = screening(sequences)
    map((s, f) -> Variant(s, f), sequences, fitness)
end
