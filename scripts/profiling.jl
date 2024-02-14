include("de_sandbox.jl")

"""
A simple function for profiling de!().

Select different DE modules (Screening, SelectionStrategy, Mutagenesis) and `initial_population`
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

# Use your preferred profiling tool, for example:
# @profview run_de2(10000)
