@testset "alphabet_extractor.jl" begin
    ae = DESilico.AlphabetExtractor()
    @test typeof(ae) == DESilico.AlphabetExtractor

    parents = [
        ['A', 'A', 'A'],
        ['A', 'B', 'C'],
    ]
    alphabets = ae(parents)
    @test length(alphabets) == 3
    @test alphabets[1] == Set(['A'])
    @test alphabets[2] == Set(['A', 'B'])
    @test alphabets[3] == Set(['A', 'C'])
end
