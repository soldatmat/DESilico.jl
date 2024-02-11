@testset "sampling_select.jl" begin
    @testset "SamplingSelect" begin
        @test_throws ArgumentError DESilico.SamplingSelect(0)
        @test_throws ArgumentError DESilico.SamplingSelect(-1)

        variants = [
            Variant(['A', 'C'], 0.0),
            Variant(['A', 'A'], -0.3),
            Variant(['A', 'D'], 10),
            Variant(['A', 'B'], -0.7),
            Variant(['X', 'X', 'X'], 0.5),
            Variant(['B', 'A'], 0.0),
            Variant(['B', 'B'], 0.0),
            Variant(['B', 'C'], 0.0),
            Variant(['B', 'D'], 0.0),
            Variant(['B', 'E'], 0.0),
        ]

        ss = DESilico.SamplingSelect(9)
        @test ss.k == 9
        selection = ss(variants)
        @test typeof(selection) == Vector{Vector{Char}}
        @test length(selection) == 9
        @test length(selection) == length(Set(selection))

        ss = DESilico.SamplingSelect(11)
        @test_throws AssertionError ss(variants)
    end

    @testset "WeightedSamplingSelect" begin
        @testset "SamplingSelect constructor" begin
            @test_throws ArgumentError DESilico.SamplingSelect(0, weighting=0.5)
            @test_throws ArgumentError DESilico.SamplingSelect(-1, weighting=0.5)
            @test_throws ArgumentError DESilico.SamplingSelect(1, weighting=-0.5)
            @test_throws ArgumentError DESilico.SamplingSelect(1, weighting=1.0)

            ss = DESilico.SamplingSelect(1, weighting=0.5)
            @test typeof(ss) == DESilico.WeightedSamplingSelect
            @test ss.k == 1
            @test ss.weighting == 0.5
        end

        @testset "direct constructor" begin
            @test_throws ArgumentError DESilico.WeightedSamplingSelect(0, weighting=0.5)
            @test_throws ArgumentError DESilico.WeightedSamplingSelect(-1, weighting=0.5)
            @test_throws ArgumentError DESilico.WeightedSamplingSelect(1, weighting=-0.5)
            @test_throws ArgumentError DESilico.WeightedSamplingSelect(1, weighting=1.0)

            ss = DESilico.WeightedSamplingSelect(2, weighting=0.5)
            @test ss.k == 2
            @test ss.weighting == 0.5
        end

        variants = [
            Variant(['A', 'C'], 0.0),
            Variant(['A', 'A'], -0.3),
            Variant(['A', 'D'], 10),
            Variant(['A', 'B'], -0.7),
            Variant(['X', 'X', 'X'], 0.5),
            Variant(['B', 'A'], 0.0),
            Variant(['B', 'B'], 0.0),
            Variant(['B', 'C'], 0.0),
            Variant(['B', 'D'], 0.0),
            Variant(['B', 'E'], 0.0),
        ]

        ss = DESilico.WeightedSamplingSelect(9, weighting=0.5)
        selection = ss(variants)
        @test typeof(selection) == Vector{Vector{Char}}
        @test length(selection) == 9
        @test length(selection) == length(Set(selection))

        ss = DESilico.WeightedSamplingSelect(11, weighting=0.5)
        @test_throws AssertionError ss(variants)

        ss = DESilico.WeightedSamplingSelect(9)
        @test ss.k == 9
        @test ss.weighting == 1-eps()
        @test ss.weighting < 1
        selection = ss(variants)
        @test typeof(selection) == Vector{Vector{Char}}
        @test length(selection) == 9
        @test length(selection) == length(Set(selection))
    end
end
