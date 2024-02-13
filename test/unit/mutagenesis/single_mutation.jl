@testset "single_mutation.jl" begin
    alphabet = Set(['A', 'B', 'C'])
    mutagenesis = DESilico.SingleMutation(alphabet)

    @testset "single parent" begin
        parents = [['A', 'A', 'A']]

        variant_library = mutagenesis(parents)
        set_vl = Set(variant_library)

        library_length = 7
        correct_set = Set([
            ['A', 'A', 'A'], ['B', 'A', 'A'], ['C', 'A', 'A'], ['A', 'B', 'A'], ['A', 'C', 'A'], ['A', 'A', 'B'], ['A', 'A', 'C'],
        ])

        @test length(variant_library) == library_length
        @test length(set_vl) == library_length
        @test set_vl == correct_set
        @test parents == [['A', 'A', 'A']]
    end

    @testset "multiple parents" begin
        parents = [['A', 'A', 'A'], ['B', 'B', 'B']]

        variant_library = mutagenesis(parents)
        set_vl = Set(variant_library)

        library_length = 14
        correct_set = Set([
            ['A', 'A', 'A'], ['B', 'A', 'A'], ['C', 'A', 'A'], ['A', 'B', 'A'], ['A', 'C', 'A'], ['A', 'A', 'B'], ['A', 'A', 'C'],
            ['B', 'B', 'B'], ['A', 'B', 'B'], ['C', 'B', 'B'], ['B', 'A', 'B'], ['B', 'C', 'B'], ['B', 'B', 'A'], ['B', 'B', 'C'],
        ])

        @test length(variant_library) == library_length
        @test length(set_vl) == library_length
        @test set_vl == correct_set
        @test parents == [['A', 'A', 'A'], ['B', 'B', 'B']]
    end
end
