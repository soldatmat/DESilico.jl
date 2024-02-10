@testset "utils.jl" begin
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
