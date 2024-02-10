@testset "variant.jl" begin
    @testset "isequal" begin
        a = Variant(['A', 'A'], 0)
        b = Variant(['A', 'A'], 1.0)

        @test isequal(a, b) == true

        a = Variant(['A', 'A'], 0)
        b = Variant(['A', 'B'], 0)

        @test isequal(a, b) == false

        a = Variant(['A', 'A'], 0)
        b = Variant(['A'], 0)

        @test isequal(a, b) == false
    end

    @testset "hash & Set" begin
        a = Variant(['A', 'A'], 0)
        b = Variant(['A', 'A'], 1.0)
        s = Set([a, b])

        @test hash(a) == hash(b)
        @test length(s) == 1
        s_elem = collect(s)[1]
        @test s_elem.sequence == b.sequence
        @test s_elem.fitness == b.fitness

        a = Variant(['A', 'A'], 0)
        b = Variant(['A', 'B'], 0)
        s = Set([a, b])

        @test hash(a) != hash(b)
        @test length(s) == 2

        a = Variant(['A', 'A'], 0)
        b = Variant(['A'], 0)
        s = Set([a, b])

        @test hash(a) != hash(b)
        @test length(s) == 2
    end

    @testset "copy" begin
        a = Variant(['A', 'A'], 0)
        b = copy(a)

        @test a != b
        @test a.sequence == b.sequence
        @test a.fitness == b.fitness
    end
end
