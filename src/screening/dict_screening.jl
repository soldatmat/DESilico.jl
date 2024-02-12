using XLSX

"""
Uses a sequence-fitness dictionary to simulate the screening.

Can be constructed with dictionary:
    DictScreening(fitness_dict::Dict{Vector{Char},Float64})
or path to a .xlsx file:
    DictScreening(file_path::String; sheet::int=1, sequence_column::String="Variants", fitness_column::String="Fitness")

Adding a `default::Float64` argument to one of the constructers returns a `DictScreeningWithDefault`.
"""
struct DictScreening <: Screening
    fitness_dict::Dict{Vector{Char},Float64}

    function load_dict(file_path::String; sheet::Int, sequence_column::String, fitness_column::String)
        xf = XLSX.readxlsx(file_path)
        dt = XLSX.readtable(file_path, XLSX.sheetnames(xf)[sheet])

        variants_idx = dt.column_label_index[Symbol(sequence_column)]
        variants = Vector{String}(dt.data[variants_idx])
        variants = collect.(variants)

        fitness_idx = dt.column_label_index[Symbol(fitness_column)]
        fitness = Vector{Float64}(dt.data[fitness_idx])

        Dict(variants .=> fitness)
    end

    function DictScreening(fitness_dict)
        new(fitness_dict)
    end
    function DictScreening(fitness_dict, default)
        DictScreeningWithDefault(fitness_dict, default)
    end

    function DictScreening(file_path::String; sheet::Int=1, sequence_column::String="Variants", fitness_column::String="Fitness")
        new(load_dict(file_path; sheet, sequence_column, fitness_column))
    end
    function DictScreening(file_path::String, default::Float64; sheet::Int=1, sequence_column::String="Variants", fitness_column::String="Fitness")
        DictScreeningWithDefault(load_dict(file_path; sheet, sequence_column, fitness_column), default)
    end
end
function (s::DictScreening)(sequence::Vector{Char})
    s.fitness_dict[sequence]
end

"""
Uses a sequence-fitness dictionary to simulate the screening.

Can be constructed directly with dictionary and default fitness value:
    DictScreeningWithDefault(fitness_dict::Dict{Vector{Char},Float64}, default::Float6)
or via `DictScreening` constructors by adding the default fitness value:
    DictScreening(fitness_dict::Dict{Vector{Char},Float64}, default::Float64)
    DictScreening(file_path::String, default::Float64; sheet::Int=1, sequence_column::String="Variants", fitness_column::String="Fitness")
"""
struct DictScreeningWithDefault <: Screening
    fitness_dict::Dict{Vector{Char},Float64}
    default::Float64
end
function (s::DictScreeningWithDefault)(sequence::Vector{Char})
    get(s.fitness_dict, sequence, s.default)
end
