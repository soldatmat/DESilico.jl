struct Recombination <: Mutagenesis end
function (m::Recombination)(parents::AbstractVector{<:AbstractVector{Char}})
    @assert DESilico.same_length_sequences(parents)
    length(parents) == 0 && return Vector{Vector{Char}}([])
    alphabets = get_alphabets(parents)
    mutant_library = recombine_symbols(alphabets, parents[1])
end

function get_alphabets(parents::AbstractVector{<:AbstractVector{Char}})
    alphabets = Vector{Set{Char}}(undef, length(parents[1]))
    for position in 1:length(parents[1])
        symbols = Vector{Char}(undef, length(parents))
        for (p, parent) in enumerate(parents)
            symbols[p] = parent[position]
        end
        alphabets[position] = Set(symbols)
    end
    return alphabets
end

function recombine_symbols(
    alphabets::Vector{Set{Char}},
    first_parent::AbstractVector{Char},
)
    mutant_library = Vector{Vector{Char}}([first_parent])
    for position in 1:length(first_parent)
        new_mutants = Vector{Vector{Char}}([])
        for mutant in mutant_library
            for symbol in alphabets[position]
                mutant[position] == symbol && continue
                new_mutant = copy(mutant)
                new_mutant[position] = symbol
                push!(new_mutants, new_mutant)
            end
        end
        append!(mutant_library, new_mutants)
    end
    return mutant_library
end
