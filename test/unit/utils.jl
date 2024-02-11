@testset "utils.jl" begin
    @testset "sequence_from_alphabet" begin
        alphabet = Set(['A', 'B'])
        @test DESilico.sequence_from_alphabet(Vector{Char}([]), alphabet) == true
        @test DESilico.sequence_from_alphabet(['B'], alphabet) == true
        @test DESilico.sequence_from_alphabet(['B', 'A', 'B', 'B'], alphabet) == true
        @test DESilico.sequence_from_alphabet([' '], alphabet) == false
        @test DESilico.sequence_from_alphabet(['C'], alphabet) == false
        @test DESilico.sequence_from_alphabet(['B', 'A', 'C', 'B'], alphabet) == false

        alphabet = Set{Char}([])
        @test DESilico.sequence_from_alphabet(Vector{Char}([]), alphabet) == true
        @test DESilico.sequence_from_alphabet([' '], alphabet) == false
        @test DESilico.sequence_from_alphabet(['A'], alphabet) == false
    end

    @testset "same_length_sequences" begin
        sequences = [['A'], ['A'], ['A']]
        @test DESilico.same_length_sequences(sequences) == true

        sequences = [['A'], ['A', 'A'], ['A']]
        @test DESilico.same_length_sequences(sequences) == false

        sequences = Vector{Vector{Char}}([['A'], []])
        @test DESilico.same_length_sequences(sequences) == false

        sequences = Vector{Vector{Char}}([])
        @test DESilico.same_length_sequences(sequences) == true
    end
end
