using XLSX

"""
Uses a sequence-fitness dictionary to simulate the screening.

Can be constructed with dictionary:
    DictScreening(fitness_dict::Dict{<:AbstractVector{Char},<:Real})
or path to a .xlsx file:
    DictScreening(file_path::String; sheet::int=1, sequence_column::String="Variants", fitness_column::String="Fitness")
"""
struct DictScreening <: Screening
    fitness_dict::Dict{<:AbstractVector{Char},<:Real}

    function DictScreening(fitness_dict::Dict{<:AbstractVector{Char},<:Real})
        new(fitness_dict)
    end

    function DictScreening(file_path::String; sheet::Int=1, sequence_column::String="Variants", fitness_column::String="Fitness")
        xf = XLSX.readxlsx(file_path)
        dt = XLSX.readtable(file_path, XLSX.sheetnames(xf)[1])

        variants_idx = dt.column_label_index[Symbol(sequence_column)]
        variants = Vector{String}(dt.data[variants_idx])
        #variants = reduce(vcat, permutedims.(collect.(variants))) # Creates an array instead
        variants = collect.(variants)

        fitness_idx = dt.column_label_index[Symbol(fitness_column)]
        fitness = Vector{Real}(dt.data[fitness_idx])

        new(Dict(variants .=> fitness))
    end
end
function (s::DictScreening)(sequence::AbstractVector{Char})
    s.fitness_dict[sequence]
end
