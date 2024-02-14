"""
    de_evaluation(sequence_space::SequenceSpace, runs::Int; kwargs...)

Perform directed evolution through `de!()` with defined options `runs` times.
Returns the top fitness obtained in each run as a `Vector{Float64}`.

# Arguments
- `sequence_space::SequenceSpace`: Initial `SeqeunceSpace` which will be used in each run of `de!()`.
- `runs::Int`: Number of times `de!()` will be called.

# Keywords
- `screening::Screening`: Assigns fitness value to a sequence.
- `selection_strategy::SelectionStrategy`: Defines the algorithm used to select new parents from a pool of screened variants.
- `mutagenesis:Mutagenesis`: Defines the algorithm used to create new mutants from current population.
- `n_iterations::Integer`: Specifies the number of iteration of `de!()`.
- `parallel::Bool=false`: If true, the calls of `de!()` will be run in parallel.
"""
function de_evaluation(
    sequence_space::SequenceSpace,
    runs::Int;
    screening::Screening,
    selection_strategy::SelectionStrategy,
    mutagenesis::Mutagenesis,
    n_iterations::Int,
    parallel::Bool=false,
)
    @assert runs > 0
    results = Vector{Float64}(undef, runs)
    get_sequence_space = r -> SequenceSpace{Nothing}(sequence_space.population, sequence_space.top_variant)
    if parallel
        _run_de_parallel!(results, get_sequence_space, runs; screening, selection_strategy, mutagenesis, n_iterations)
    else
        _run_de_sequential!(results, get_sequence_space, runs; screening, selection_strategy, mutagenesis, n_iterations)
    end
    return results
end

"""
    de_evaluation(sequence_space::SequenceSpace, runs::Int; kwargs...)

Perform directed evolution through `de!()` with defined options `runs` times.
Returns the top fitness obtained in each run as a `Vector{Float64}`.

# Arguments
- `starting_variants::AbstractVector{Variant}`: Each of the `starting_variants` will be used as the sole initial parent in one run of `de!()`.

# Keywords
- `screening::Screening`: Assigns fitness value to a sequence.
- `selection_strategy::SelectionStrategy`: Defines the algorithm used to select new parents from a pool of screened variants.
- `mutagenesis:Mutagenesis`: Defines the algorithm used to create new mutants from current population.
- `n_iterations::Integer`: Specifies the number of iteration of `de!()`.
- `parallel::Bool=false`: If true, the calls of `de!()` will be run in parallel.
"""
function de_evaluation(
    starting_variants::AbstractVector{Variant};
    screening::Screening,
    selection_strategy::SelectionStrategy,
    mutagenesis::Mutagenesis,
    n_iterations::Int,
    parallel::Bool=false,
)
    @assert length(starting_variants) > 0
    results = Vector{Float64}(undef, length(starting_variants))
    get_sequence_space = r -> SequenceSpace([starting_variants[r]])
    if parallel
        _run_de_parallel!(results, get_sequence_space, length(starting_variants); screening, selection_strategy, mutagenesis, n_iterations)
    else
        _run_de_sequential!(results, get_sequence_space, length(starting_variants); screening, selection_strategy, mutagenesis, n_iterations)
    end
    return results
end

function _run_de_sequential!(
    results::Vector{Float64},
    get_sequence_space::Function,
    runs::Int;
    screening::Screening,
    selection_strategy::SelectionStrategy,
    mutagenesis::Mutagenesis,
    n_iterations::Int,
)
    for r = 1:runs
        ss = get_sequence_space(r)
        de!(
            ss;
            screening,
            selection_strategy,
            mutagenesis,
            n_iterations,
        )
        results[r] = ss.top_variant.fitness
    end
end

function _run_de_parallel!(
    results::Vector{Float64},
    get_sequence_space::Function,
    runs::Int;
    screening::Screening,
    selection_strategy::SelectionStrategy,
    mutagenesis::Mutagenesis,
    n_iterations::Int,
)
    Threads.@threads :static for r = 1:runs
        ss = get_sequence_space(r)
        de!(
            ss;
            screening,
            selection_strategy,
            mutagenesis,
            n_iterations,
        )
        results[r] = ss.top_variant.fitness
    end
end
