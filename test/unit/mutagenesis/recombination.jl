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
        @test typeof(m) == DESilico.Recombination{DESilico.AlphabetExtractor}
        @test typeof(m.alphabet_extractor) == DESilico.AlphabetExtractor
        @test isnothing(m.n)

        ae = DESilico.AlphabetExtractor()
        m = DESilico.Recombination(ae)
        @test typeof(m) == DESilico.Recombination{DESilico.AlphabetExtractor}
        @test typeof(m.alphabet_extractor) == DESilico.AlphabetExtractor
        @test isnothing(m.n)

        ae = DESilico.AlphabetExtractor()
        m = DESilico.Recombination{DESilico.AlphabetExtractor}(ae)
        @test typeof(m) == DESilico.Recombination{DESilico.AlphabetExtractor}
        @test typeof(m.alphabet_extractor) == DESilico.AlphabetExtractor
        @test isnothing(m.n)

        m = DESilico.Recombination(; n=3)
        @test typeof(m) == DESilico.Recombination{DESilico.AlphabetExtractor}
        @test typeof(m.alphabet_extractor) == DESilico.AlphabetExtractor
        @test m.n == 3

        ae = DESilico.AlphabetExtractor()
        m = DESilico.Recombination(ae, 3)
        @test typeof(m) == DESilico.Recombination{DESilico.AlphabetExtractor}
        @test typeof(m.alphabet_extractor) == DESilico.AlphabetExtractor
        @test m.n == 3

        ae = DESilico.AlphabetExtractor()
        m = DESilico.Recombination(ae; n=3)
        @test typeof(m) == DESilico.Recombination{DESilico.AlphabetExtractor}
        @test typeof(m.alphabet_extractor) == DESilico.AlphabetExtractor
        @test m.n == 3

        ae = DESilico.AlphabetExtractor()
        m = DESilico.Recombination{DESilico.AlphabetExtractor}(ae, 3)
        @test typeof(m) == DESilico.Recombination{DESilico.AlphabetExtractor}
        @test typeof(m.alphabet_extractor) == DESilico.AlphabetExtractor
        @test m.n == 3

        ae = DESilico.AlphabetExtractor()
        m = DESilico.Recombination{DESilico.AlphabetExtractor}(ae; n=3)
        @test typeof(m) == DESilico.Recombination{DESilico.AlphabetExtractor}
        @test typeof(m.alphabet_extractor) == DESilico.AlphabetExtractor
        @test m.n == 3
    end

    @testset "Recombination call" begin
        parents = [
            ['A', 'A', 'B'],
            ['C', 'A', 'D'],
        ]
        m = DESilico.Recombination()
        mutants = m(parents)
        @test length(mutants) == 4
        @test Set(mutants) == Set([
            ['A', 'A', 'B'],
            ['A', 'A', 'D'],
            ['C', 'A', 'B'],
            ['C', 'A', 'D'],
        ])
        @test m(Vector{Vector{Char}}([])) == Vector{Vector{Char}}([])
        @test parents == [['A', 'A', 'B'], ['C', 'A', 'D']]

        m = DESilico.Recombination(; n=5)
        @test_throws Exception m(parents)

        parents = [
            ['A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A'],
            ['B', 'B', 'B', 'B', 'B', 'B', 'B', 'B', 'B', 'B'],
        ]
        m = DESilico.Recombination(; n=1023)
        mutants = m(parents)
        @test length(mutants) == 1023
        @test length(Set(mutants)) == 1023
        @test m(Vector{Vector{Char}}([])) == Vector{Vector{Char}}([])
        @test parents == [
            ['A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A'],
            ['B', 'B', 'B', 'B', 'B', 'B', 'B', 'B', 'B', 'B'],
        ]
    end
end
