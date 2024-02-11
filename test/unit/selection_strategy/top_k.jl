@testset "top_k.jl" begin
    @test_throws ArgumentError DESilico.TopK(0)
    @test_throws ArgumentError DESilico.TopK(-1)

    variants = [
        Variant(['A', 'C'], 0.0),
        Variant(['A', 'A'], -0.3),
        Variant(['A', 'D'], 10),
        Variant(['A', 'B'], -0.7),
        Variant(['X', 'X', 'X'], 0.5),
    ]

    selection = DESilico.TopK(1)(variants)
    selection_set = Set(selection)
    @test length(selection) == length(selection_set)
    @test selection_set == Set([['A', 'D']])

    selection = DESilico.TopK(2)(variants)
    selection_set = Set(selection)
    @test length(selection) == length(selection_set)
    @test selection_set == Set([['A', 'D'], ['X', 'X', 'X']])

    selection = DESilico.TopK(3)(variants)
    selection_set = Set(selection)
    @test length(selection) == length(selection_set)
    @test selection_set == Set([['A', 'D'], ['X', 'X', 'X'], ['A', 'C']])

    selection = DESilico.TopK(4)(variants)
    selection_set = Set(selection)
    @test length(selection) == length(selection_set)
    @test selection_set == Set([['A', 'D'], ['X', 'X', 'X'], ['A', 'C'], ['A', 'A']])

    selection = DESilico.TopK(5)(variants)
    selection_set = Set(selection)
    @test length(selection) == length(selection_set)
    @test selection_set == Set([['A', 'D'], ['X', 'X', 'X'], ['A', 'C'], ['A', 'A'], ['A', 'B']])

    ss = DESilico.TopK(6)
    @test_throws AssertionError ss(variants)
end
