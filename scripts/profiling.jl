include("de_sandbox.jl")

"""
A simple function for profiling `de!()`.

Select different DE modules (`Screening`, `SelectionStrategy`, `Mutagenesis`) and `initial_population`
in `de_sandbox.jl` to profile different modules.
"""
function run_de(n::Int)
    for _ in 1:n
        ss = SequenceSpace{Nothing}(initial_population)
        de!(
            ss;
            screening,
            selection_strategy,
            mutagenesis,
            n_iterations=10,
        )
    end
end

"""
A simple function for profiling `de_evaluation()`.

Select different DE modules (`Screening`, `SelectionStrategy`, `Mutagenesis`) and `initial_population`
in `de_sandbox.jl` to profile different modules.
"""
function run_de_evaluation(n::Int)
    de_evaluation(
        SequenceSpace{Nothing}(initial_population),
        n;
        screening,
        selection_strategy,
        mutagenesis,
        n_iterations=10,
        parallel=false,
    )
end

# Use your preferred profiling tool, for example:
# @profview run_de(10000)
