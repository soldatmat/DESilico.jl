@testset "recombination.jl" begin
    @testset "get_alphabets" begin
        parents = [
            ['A', 'A', 'A'],
            ['A', 'B', 'C'],
        ]
        alphabets = DESilico.get_alphabets(parents)
        @test length(alphabets) == 3
        @test alphabets[1] == Set(['A'])
        @test alphabets[2] == Set(['A', 'B'])
        @test alphabets[3] == Set(['A', 'C'])
    end

    @testset "recombine_symbols" begin
        alphabets = [
            Set(['A', 'C']),
            Set(['A']),
            Set(['B', 'D']),
        ]
        first_parent = ['A', 'A', 'B']
        mutants = DESilico.recombine_symbols(alphabets, first_parent)
        @test length(mutants) == 4
        @test Set(mutants) == Set([
            ['A', 'A', 'B'],
            ['A', 'A', 'D'],
            ['C', 'A', 'B'],
            ['C', 'A', 'D'],
        ])
    end

    @testset "Recomination call" begin
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

        @test m(Vector{Vector{Char}}([])) == Vector{Vector{Char}}([])
    end
end
