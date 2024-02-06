@testset "de.jl" begin
    wt_sequence = ['A', 'A', 'A', 'A']
    alphabet = Set(['A', 'B', 'C', 'D', 'E'])

    # Define a screening oracle
    fitness_dict = Dict([
        (['A', 'A', 'A', 'A'], 1.0),
        (['A', 'B', 'A', 'A'], 0.7),
        (['A', 'C', 'A', 'A'], 2.1),
        (['A', 'D', 'A', 'A'], 3.0),
        (['A', 'E', 'A', 'A'], 0.0),
    ])
    dict_screen(sequence) = fitness_dict[sequence]

    # Define a custom dummy SelectionStrategy
    struct DummySelectionStrategy <: DESilico.SelectionStrategy end
    function (::DummySelectionStrategy)(sequence_fitness_pairs::Vector{Tuple{Vector{Char},T}}) where {T<:Real}
        [sequence_fitness_pairs[1][1]]
    end

    # Define a custom dummy Mutagenesis
    struct DummyMutagenesis <: DESilico.Mutagenesis end
    function (::DummyMutagenesis)(parents::Vector{Vector{Char}})
        new_parent = parents[1]
        new_parent[2] = new_parent[2] + 1
        return [new_parent]
    end

    # Run directed evolution of the wild type sequence
    top_variant, top_fitness = de(
        [wt_sequence],
        dict_screen,
        DummySelectionStrategy(),
        DummyMutagenesis(),
        length(fitness_dict) - 1,
    )

    @test top_variant == ['A', 'D', 'A', 'A']
    @test top_fitness == 3.0
end