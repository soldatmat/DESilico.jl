@testset "sequence_space.jl" begin
    @testset "vector constructor" begin
        ss = SequenceSpace([Variant(['A'], 0), Variant(['B'], 1)])

        @test typeof(ss) == SequenceSpace
        @test length(ss.population) == 2
        @test Set(ss.population) == Set([['A'], ['B']])
        @test ss.variants == Set([Variant(['A'], 0), Variant(['B'], 1)])
        @test isequal(ss.top_variant, Variant(['B'], 1))
    end

    @testset "set constructor" begin
        ss = SequenceSpace(Set([Variant(['A'], 0), Variant(['B'], 1)]))

        @test typeof(ss) == SequenceSpace
        @test length(ss.population) == 2
        @test Set(ss.population) == Set([['A'], ['B']])
        @test ss.variants == Set([Variant(['A'], 0), Variant(['B'], 1)])
        @test isequal(ss.top_variant, Variant(['B'], 1))
    end

    @testset "push_variants!" begin
        ss = SequenceSpace([Variant(['A'], 0), Variant(['B'], 1)])
        DESilico.push_variants!(ss, [Variant(['C'], 1.5), Variant(['D'], -1)])

        @test length(ss.population) == 2
        @test Set(ss.population) == Set([['A'], ['B']])
        @test ss.variants == Set([Variant(['A'], 0), Variant(['B'], 1), Variant(['C'], 1.5), Variant(['D'], -1)])
        @test isequal(ss.top_variant, Variant(['C'], 1.5))
    end
end
