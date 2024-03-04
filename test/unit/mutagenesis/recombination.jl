@testset "recombination.jl" begin
    @testset "_recombine_symbols" begin
        alphabets = [
            Set(['A', 'C']),
            Set(['A']),
            Set(['B', 'D']),
        ]
        mutants = DESilico._recombine_symbols(alphabets)
        @test length(mutants) == 4
        @test Set(mutants) == Set([
            ['A', 'A', 'B'],
            ['A', 'A', 'D'],
            ['C', 'A', 'B'],
            ['C', 'A', 'D'],
        ])
    end

    @testset "Constructors" begin
        m = DESilico.Recombination()
        @test typeof(m) == DESilico.Recombination{DESilico.AlphabetExctractor}
        @test typeof(m.alphabet_extractor) == DESilico.AlphabetExctractor

        ae = DESilico.AlphabetExctractor()
        m = DESilico.Recombination(ae)
        @test typeof(m) == DESilico.Recombination{DESilico.AlphabetExctractor}
        @test typeof(m.alphabet_extractor) == DESilico.AlphabetExctractor

        ae = DESilico.AlphabetExctractor()
        m = DESilico.Recombination{DESilico.AlphabetExctractor}(ae)
        @test typeof(m) == DESilico.Recombination{DESilico.AlphabetExctractor}
        @test typeof(m.alphabet_extractor) == DESilico.AlphabetExctractor
    end

    @testset "Recombination call" begin
        m = DESilico.Recombination()
        parents = [
            ['A', 'A', 'B'],
            ['C', 'A', 'D'],
        ]
        mutants = m(parents)
        @test length(mutants) == 4
        @test Set(mutants) == Set([
            ['A', 'A', 'B'],
            ['A', 'A', 'D'],
            ['C', 'A', 'B'],
            ['C', 'A', 'D'],
        ])
        @test parents == [['A', 'A', 'B'], ['C', 'A', 'D']]

        @test m(Vector{Vector{Char}}([])) == Vector{Vector{Char}}([])
    end
end
