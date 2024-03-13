@testset "recombination.jl" begin
    @testset "Constructors" begin
        m = DESilico.Recombination()
        @test typeof(m) == DESilico.Recombination{DESilico.AlphabetExtractor}
        @test typeof(m.alphabet_extractor) == DESilico.AlphabetExtractor
        @test isnothing(m.mutation_positions)
        @test isnothing(m.n)

        ae = DESilico.AlphabetExtractor()
        m = DESilico.Recombination(ae)
        @test typeof(m) == DESilico.Recombination{DESilico.AlphabetExtractor}
        @test typeof(m.alphabet_extractor) == DESilico.AlphabetExtractor
        @test isnothing(m.mutation_positions)
        @test isnothing(m.n)

        ae = DESilico.AlphabetExtractor()
        m = DESilico.Recombination{DESilico.AlphabetExtractor}(ae)
        @test typeof(m) == DESilico.Recombination{DESilico.AlphabetExtractor}
        @test typeof(m.alphabet_extractor) == DESilico.AlphabetExtractor
        @test isnothing(m.mutation_positions)
        @test isnothing(m.n)

        m = DESilico.Recombination(; n=3)
        @test typeof(m) == DESilico.Recombination{DESilico.AlphabetExtractor}
        @test typeof(m.alphabet_extractor) == DESilico.AlphabetExtractor
        @test isnothing(m.mutation_positions)
        @test m.n == 3

        m = DESilico.Recombination(; mutation_positions=[1, 13])
        @test typeof(m) == DESilico.Recombination{DESilico.AlphabetExtractor}
        @test typeof(m.alphabet_extractor) == DESilico.AlphabetExtractor
        @test m.mutation_positions == [1, 13]
        @test isnothing(m.n)

        m = DESilico.Recombination(; mutation_positions=[1, 13], n=3)
        @test typeof(m) == DESilico.Recombination{DESilico.AlphabetExtractor}
        @test typeof(m.alphabet_extractor) == DESilico.AlphabetExtractor
        @test m.mutation_positions == [1, 13]
        @test m.n == 3

        ae = DESilico.AlphabetExtractor()
        m = DESilico.Recombination(ae, [1, 13], 3)
        @test typeof(m) == DESilico.Recombination{DESilico.AlphabetExtractor}
        @test typeof(m.alphabet_extractor) == DESilico.AlphabetExtractor
        @test m.mutation_positions == [1, 13]
        @test m.n == 3

        ae = DESilico.AlphabetExtractor()
        m = DESilico.Recombination(ae; n=3)
        @test typeof(m) == DESilico.Recombination{DESilico.AlphabetExtractor}
        @test typeof(m.alphabet_extractor) == DESilico.AlphabetExtractor
        @test isnothing(m.mutation_positions)
        @test m.n == 3

        ae = DESilico.AlphabetExtractor()
        m = DESilico.Recombination(ae; mutation_positions=[1, 13])
        @test typeof(m) == DESilico.Recombination{DESilico.AlphabetExtractor}
        @test typeof(m.alphabet_extractor) == DESilico.AlphabetExtractor
        @test m.mutation_positions == [1, 13]
        @test isnothing(m.n)

        ae = DESilico.AlphabetExtractor()
        m = DESilico.Recombination(ae; mutation_positions=[1, 13], n=3)
        @test typeof(m) == DESilico.Recombination{DESilico.AlphabetExtractor}
        @test typeof(m.alphabet_extractor) == DESilico.AlphabetExtractor
        @test m.mutation_positions == [1, 13]
        @test m.n == 3

        ae = DESilico.AlphabetExtractor()
        m = DESilico.Recombination{DESilico.AlphabetExtractor}(ae, [1, 13], 3)
        @test typeof(m) == DESilico.Recombination{DESilico.AlphabetExtractor}
        @test typeof(m.alphabet_extractor) == DESilico.AlphabetExtractor
        @test m.mutation_positions == [1, 13]
        @test m.n == 3

        ae = DESilico.AlphabetExtractor()
        m = DESilico.Recombination{DESilico.AlphabetExtractor}(ae; n=3)
        @test typeof(m) == DESilico.Recombination{DESilico.AlphabetExtractor}
        @test typeof(m.alphabet_extractor) == DESilico.AlphabetExtractor
        @test isnothing(m.mutation_positions)
        @test m.n == 3

        ae = DESilico.AlphabetExtractor()
        m = DESilico.Recombination{DESilico.AlphabetExtractor}(ae; mutation_positions=[1, 13])
        @test typeof(m) == DESilico.Recombination{DESilico.AlphabetExtractor}
        @test typeof(m.alphabet_extractor) == DESilico.AlphabetExtractor
        @test m.mutation_positions == [1, 13]
        @test isnothing(m.n)

        ae = DESilico.AlphabetExtractor()
        m = DESilico.Recombination{DESilico.AlphabetExtractor}(ae; mutation_positions=[1, 13], n=3)
        @test typeof(m) == DESilico.Recombination{DESilico.AlphabetExtractor}
        @test typeof(m.alphabet_extractor) == DESilico.AlphabetExtractor
        @test m.mutation_positions == [1, 13]
        @test m.n == 3
    end

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

    @testset "Recombination call" begin
        @testset "without mutation_positions" begin
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
        @testset "with mutation_positions" begin
            parents = [
                ['A', 'B', 'C'],
                ['D', 'E', 'F'],
            ]
            m = DESilico.Recombination(; mutation_positions=[1, 3])
            mutants = m(parents)
            @test length(mutants) == 4
            @test Set(mutants) == Set([
                ['A', 'B', 'C'],
                ['A', 'B', 'F'],
                ['D', 'B', 'C'],
                ['D', 'B', 'F'],
            ])
            @test m(Vector{Vector{Char}}([])) == Vector{Vector{Char}}([])
            @test parents == [['A', 'B', 'C'], ['D', 'E', 'F']]

            parents = [
                ['A', 'B', 'C', 'D', 'E', 'F', 'G'],
                ['H', 'I', 'J', 'K', 'L', 'M', 'N'],
            ]
            m = DESilico.Recombination(; mutation_positions=[3, 6])
            mutants = m(parents)
            @test length(mutants) == 4
            @test Set(mutants) == Set([
                ['A', 'B', 'C', 'D', 'E', 'F', 'G'],
                ['A', 'B', 'C', 'D', 'E', 'M', 'G'],
                ['A', 'B', 'J', 'D', 'E', 'F', 'G'],
                ['A', 'B', 'J', 'D', 'E', 'M', 'G'],
            ])
            @test parents == [['A', 'B', 'C', 'D', 'E', 'F', 'G'], ['H', 'I', 'J', 'K', 'L', 'M', 'N'],]
        end
    end
end
