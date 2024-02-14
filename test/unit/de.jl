@testset "de.jl" begin
    wild_type = Variant(['A', 'A', 'A', 'A'], 1.0)

    # Define a custom screening oracle
    fitness_dict = Dict([
        (['A', 'A', 'A', 'A'], 1.0),
        (['A', 'B', 'A', 'A'], 0.7),
        (['A', 'C', 'A', 'A'], 2.1),
        (['A', 'D', 'A', 'A'], 3.0),
        (['A', 'E', 'A', 'A'], 0.0),
    ])
    struct DummyScreening <: DESilico.Screening end
    (::DummyScreening)(sequence::Vector{Char}) = fitness_dict[sequence]
    (s::DummyScreening)(sequences::AbstractVector{Vector{Char}}) = map(sequence -> s(sequence), sequences)

    # Define a custom SelectionStrategy
    struct DummySelectionStrategy <: DESilico.SelectionStrategy end
    function (::DummySelectionStrategy)(variants::Vector{Variant})
        [variants[1].sequence]
    end

    # Define a custom Mutagenesis
    struct DummyMutagenesis <: DESilico.Mutagenesis end
    function (::DummyMutagenesis)(parents::Vector{Vector{Char}})
        new_parent = copy(parents[1])
        new_parent[2] = new_parent[2] + 1
        return [new_parent]
    end

    # Run directed evolution of the wild type sequence
    ss = SequenceSpace([wild_type])
    de!(
        ss,
        screening=DummyScreening(),
        selection_strategy=DummySelectionStrategy(),
        mutagenesis=DummyMutagenesis(),
        n_iterations=length(fitness_dict) - 1,
    )

    @test ss.variants == Set([
        Variant(['A', 'A', 'A', 'A'], 1.0),
        Variant(['A', 'B', 'A', 'A'], 0.7),
        Variant(['A', 'C', 'A', 'A'], 2.1),
        Variant(['A', 'D', 'A', 'A'], 3.0),
        Variant(['A', 'E', 'A', 'A'], 0.0),
    ])
    @test ss.population == [['A', 'E', 'A', 'A']]
    @test ss.top_variant.sequence == ['A', 'D', 'A', 'A']
    @test ss.top_variant.fitness == 3.0
end
