@testset "top_k.jl" begin
    try
        ss = DESilico.TopK(0)
    catch e
        @test typeof(e) == ErrorException
    end
    try
        ss = DESilico.TopK(-1)
    catch e
        @test typeof(e) == ErrorException
    end

    screened_variants = [
        Variant(['A', 'C'], 0.0),
        Variant(['A', 'A'], -0.3),
        Variant(['A', 'D'], 10),
        Variant(['A', 'B'], -0.7),
        Variant(['X', 'X', 'X'], 0.5),
    ]

    selection = DESilico.TopK(1)(screened_variants)
    selection_set = Set(selection)
    @test length(selection) == length(selection_set)
    @test selection_set == Set([['A', 'D']])

    selection = DESilico.TopK(2)(screened_variants)
    selection_set = Set(selection)
    @test length(selection) == length(selection_set)
    @test selection_set == Set([['A', 'D'], ['X', 'X', 'X']])

    selection = DESilico.TopK(3)(screened_variants)
    selection_set = Set(selection)
    @test length(selection) == length(selection_set)
    @test selection_set == Set([['A', 'D'], ['X', 'X', 'X'], ['A', 'C']])

    selection = DESilico.TopK(4)(screened_variants)
    selection_set = Set(selection)
    @test length(selection) == length(selection_set)
    @test selection_set == Set([['A', 'D'], ['X', 'X', 'X'], ['A', 'C'], ['A', 'A']])

    selection = DESilico.TopK(5)(screened_variants)
    selection_set = Set(selection)
    @test length(selection) == length(selection_set)
    @test selection_set == Set([['A', 'D'], ['X', 'X', 'X'], ['A', 'C'], ['A', 'A'], ['A', 'B']])

    ss = DESilico.TopK(6)
    try
        ss(screened_variants)
    catch e
        @test typeof(e) == AssertionError
    end
end
