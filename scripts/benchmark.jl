using BenchmarkTools

include("de_sandbox.jl")

"""
A simple benchmark showcasing the speed-up achieved via parallelization of `de_evaluation`.
"""
function parallel_benchmark(runs::Int=160000, n_iterations::Int=5)
    ss = SequenceSpace{Nothing}(initial_population)
    seq = @elapsed de_evaluation(
        ss,
        runs;
        screening,
        selection_strategy,
        mutagenesis,
        n_iterations,
        parallel=false,
    )

    ss = SequenceSpace{Nothing}(initial_population)
    par = @elapsed de_evaluation(
        ss,
        runs;
        screening,
        selection_strategy,
        mutagenesis,
        n_iterations,
        parallel=true,
    )

    println("SEQUENTIAL de_evaluation: $seq")
    println("PARALLEL de_evaluation  : $par")
end
