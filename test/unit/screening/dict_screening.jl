@testset "dict_screening.jl" begin
    fitness_dict = Dict(
        ['V', 'D', 'G', 'V'] => 1,
        ['A', 'D', 'G', 'V'] => 0.0619096557142,
        ['C', 'D', 'G', 'V'] => 0.242237277886,
        ['D', 'D', 'G', 'V'] => 0.00647208961971,
        ['E', 'D', 'G', 'V'] => 0.0327191845926,
        ['F', 'D', 'G', 'V'] => 0.377100728425,
        ['G', 'D', 'G', 'V'] => 0.00829790573568,
        ['H', 'D', 'G', 'V'] => 0.0264798489707,
        ['I', 'D', 'G', 'V'] => 1.4459050863,
    )

    @testset "from Dict" begin
        sd_from_dict = DESilico.DictScreening(fitness_dict)

        for key in keys(fitness_dict)
            @test sd_from_dict(key) == fitness_dict[key]
        end
    end

    @testset "from file" begin
        file_path = "unit/screening/data/test_data.xlsx"
        sd_from_file = DESilico.DictScreening(file_path)
                
        for key in keys(fitness_dict)
            @test sd_from_file(key) == fitness_dict[key]
        end
    end
end
