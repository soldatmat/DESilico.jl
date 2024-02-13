@testset "sequence_space.jl" begin
    @testset "constructors" begin
        @testset "SequeneSpace{Set{Variant}}" begin
            @testset "basic constructor" begin
                @testset "explicit" begin
                    variants = [Variant(['A'], 0), Variant(['B'], 1)]
                    ss = SequenceSpace{Set{Variant}}([['A'], ['B']], Set(variants), variants[2])

                    @test typeof(ss) == SequenceSpace{Set{Variant}}
                    @test length(ss.population) == 2
                    @test Set(ss.population) == Set([['A'], ['B']])
                    @test typeof(ss.variants) == Set{Variant}
                    @test ss.variants == Set(variants)
                    @test isequal(ss.top_variant, variants[2])
                end
                @testset "implicit" begin
                    variants = [Variant(['A'], 0), Variant(['B'], 1)]
                    ss = SequenceSpace([['A'], ['B']], Set(variants), variants[2])

                    @test typeof(ss) == SequenceSpace{Set{Variant}}
                    @test length(ss.population) == 2
                    @test Set(ss.population) == Set([['A'], ['B']])
                    @test typeof(ss.variants) == Set{Variant}
                    @test ss.variants == Set(variants)
                    @test isequal(ss.top_variant, variants[2])
                end
            end

            @testset "vector constructor" begin
                ss = SequenceSpace{Set{Variant}}([Variant(['A'], 0), Variant(['B'], 1)])

                @test typeof(ss) == SequenceSpace{Set{Variant}}
                @test length(ss.population) == 2
                @test Set(ss.population) == Set([['A'], ['B']])
                @test typeof(ss.variants) == Set{Variant}
                @test ss.variants == Set([Variant(['A'], 0), Variant(['B'], 1)])
                @test isequal(ss.top_variant, Variant(['B'], 1))
            end

            @testset "set constructor" begin
                ss = SequenceSpace{Set{Variant}}(Set([Variant(['A'], 0), Variant(['B'], 1)]))

                @test typeof(ss) == SequenceSpace{Set{Variant}}
                @test length(ss.population) == 2
                @test Set(ss.population) == Set([['A'], ['B']])
                @test typeof(ss.variants) == Set{Variant}
                @test ss.variants == Set([Variant(['A'], 0), Variant(['B'], 1)])
                @test isequal(ss.top_variant, Variant(['B'], 1))
            end
        end

        @testset "SequeneSpace{Vector{Variant}}" begin
            @testset "basic constructor" begin
                @testset "explicit" begin
                    variants = [Variant(['A'], 0), Variant(['B'], 1)]
                    ss = SequenceSpace{Vector{Variant}}([['A'], ['B']], variants, variants[2])

                    @test typeof(ss) == SequenceSpace{Vector{Variant}}
                    @test length(ss.population) == 2
                    @test Set(ss.population) == Set([['A'], ['B']])
                    @test typeof(ss.variants) == Vector{Variant}
                    @test ss.variants == variants
                    @test isequal(ss.top_variant, variants[2])
                end
                @testset "implicit" begin
                    variants = [Variant(['A'], 0), Variant(['B'], 1)]
                    ss = SequenceSpace([['A'], ['B']], variants, variants[2])

                    @test typeof(ss) == SequenceSpace{Vector{Variant}}
                    @test length(ss.population) == 2
                    @test Set(ss.population) == Set([['A'], ['B']])
                    @test typeof(ss.variants) == Vector{Variant}
                    @test ss.variants == variants
                    @test isequal(ss.top_variant, variants[2])
                end
            end

            @testset "vector constructor" begin
                ss = SequenceSpace{Vector{Variant}}([Variant(['A'], 0), Variant(['B'], 1)])

                @test typeof(ss) == SequenceSpace{Vector{Variant}}
                @test length(ss.population) == 2
                @test Set(ss.population) == Set([['A'], ['B']])
                @test typeof(ss.variants) == Vector{Variant}
                @test isequal(ss.variants, [Variant(['A'], 0), Variant(['B'], 1)])
                @test isequal(ss.top_variant, Variant(['B'], 1))
            end

            @testset "set constructor" begin
                ss = SequenceSpace{Vector{Variant}}(Set([Variant(['A'], 0), Variant(['B'], 1)]))

                @test typeof(ss) == SequenceSpace{Vector{Variant}}
                @test length(ss.population) == 2
                @test Set(ss.population) == Set([['A'], ['B']])
                @test typeof(ss.variants) == Vector{Variant}
                @test isequal(Set(ss.variants), Set([Variant(['A'], 0), Variant(['B'], 1)]))
                @test isequal(ss.top_variant, Variant(['B'], 1))
            end
        end

        @testset "SequeneSpace{Nothing}" begin
            @testset "basic constructor" begin
                @testset "explicit" begin
                    ss = SequenceSpace{Nothing}([['A'], ['B']], nothing, Variant(['B'], 1))

                    @test typeof(ss) == SequenceSpace{Nothing}
                    @test length(ss.population) == 2
                    @test Set(ss.population) == Set([['A'], ['B']])
                    @test typeof(ss.variants) == Nothing
                    @test isnothing(ss.variants)
                    @test isequal(ss.top_variant, Variant(['B'], 1))
                end
                @testset "implicit" begin
                    ss = SequenceSpace([['A'], ['B']], nothing, Variant(['B'], 1))

                    @test typeof(ss) == SequenceSpace{Nothing}
                    @test length(ss.population) == 2
                    @test Set(ss.population) == Set([['A'], ['B']])
                    @test typeof(ss.variants) == Nothing
                    @test isnothing(ss.variants)
                    @test isequal(ss.top_variant, Variant(['B'], 1))
                end
            end

            @testset "vector constructor" begin
                ss = SequenceSpace{Nothing}([Variant(['A'], 0), Variant(['B'], 1)])

                @test typeof(ss) == SequenceSpace{Nothing}
                @test length(ss.population) == 2
                @test Set(ss.population) == Set([['A'], ['B']])
                @test typeof(ss.variants) == Nothing
                @test isnothing(ss.variants)
                @test isequal(ss.top_variant, Variant(['B'], 1))
            end

            @testset "set constructor" begin
                ss = SequenceSpace{Nothing}(Set([Variant(['A'], 0), Variant(['B'], 1)]))

                @test typeof(ss) == SequenceSpace{Nothing}
                @test length(ss.population) == 2
                @test Set(ss.population) == Set([['A'], ['B']])
                @test typeof(ss.variants) == Nothing
                @test isnothing(ss.variants)
                @test isequal(ss.top_variant, Variant(['B'], 1))
            end
        end

        @testset "default parameter" begin
            variants = [Variant(['A'], 0)]

            ss = SequenceSpace(variants)
            @test typeof(ss) == SequenceSpace{Set{Variant}}

            ss = SequenceSpace(Set(variants))
            @test typeof(ss) == SequenceSpace{Set{Variant}}
        end
    end

    @testset "update_top_variant!" begin
        @testset "single variant" begin
            ss = SequenceSpace([Variant(['A'], 0), Variant(['B'], 1)])
            DESilico.update_top_variant!(ss, Variant(['C'], 0.5))
            @test isequal(ss.top_variant, Variant(['B'], 1))

            ss = SequenceSpace([Variant(['A'], 0), Variant(['B'], 1)])
            DESilico.update_top_variant!(ss, Variant(['C'], 1.5))
            @test isequal(ss.top_variant, Variant(['C'], 1.5))
        end

        @testset "mutliple variants" begin
            ss = SequenceSpace([Variant(['A'], 0), Variant(['B'], 1)])
            DESilico.update_top_variant!(ss, [Variant(['C'], 0.5), Variant(['D'], 0.6)])
            @test isequal(ss.top_variant, Variant(['B'], 1))

            ss = SequenceSpace([Variant(['A'], 0), Variant(['B'], 1)])
            DESilico.update_top_variant!(ss, [Variant(['C'], 1.5), Variant(['D'], 2.0)])
            @test isequal(ss.top_variant, Variant(['D'], 2.0))

            ss = SequenceSpace([Variant(['A'], 0), Variant(['B'], 1)])
            DESilico.update_top_variant!(ss, [Variant(['C'], 2.0), Variant(['D'], 1.5)])
            @test isequal(ss.top_variant, Variant(['C'], 2.0))
        end
    end

    @testset "update_variants!" begin
        @testset "SequenceSpace{Set{Variant}}" begin
            ss = SequenceSpace([Variant(['A'], 0), Variant(['B'], 1)])
            DESilico.update_variants!(ss, [Variant(['C'], 1.5), Variant(['B'], 1.5), Variant(['D'], -1)])
            @test ss.variants == Set([Variant(['A'], 0), Variant(['B'], 1), Variant(['C'], 1.5), Variant(['D'], -1)])
        end

        @testset "SequenceSpace{Vector{Variant}}" begin
            ss = SequenceSpace{Vector{Variant}}([Variant(['A'], 0), Variant(['B'], 1)])
            DESilico.update_variants!(ss, [Variant(['C'], 1.5), Variant(['B'], 1.5), Variant(['D'], -1)])
            @test isequal(ss.variants, [Variant(['A'], 0), Variant(['B'], 1), Variant(['C'], 1.5), Variant(['B'], 1.5), Variant(['D'], -1)])
        end

        @testset "SequenceSpace{Nothing}" begin
            ss = SequenceSpace{Nothing}([Variant(['A'], 0), Variant(['B'], 1)])
            DESilico.update_variants!(ss, [Variant(['C'], 1.5), Variant(['B'], 1.5), Variant(['D'], -1)])
            @test isnothing(ss.variants)
        end
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
