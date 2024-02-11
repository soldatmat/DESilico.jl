struct SingleMutation <: Mutagenesis
    alphabet::Set{Char}
end
function (m::SingleMutation)(parents::AbstractVector{<:AbstractVector{Char}})
    len_sequence = length(parents[1])
    mutant_library = Vector{Vector{Char}}(undef, length(parents) * len_sequence * length(m.alphabet))
    for (p, parent) in enumerate(parents)
        for pos in 1:len_sequence
            mutant = copy(parent)
            for (s, symbol) in enumerate(m.alphabet)
                mutant[pos] = symbol
                mutant_library[(p-1)*len_sequence*length(m.alphabet)+(pos-1)*length(m.alphabet)+s] = copy(mutant)
            end
        end
    end
    return collect(Set(mutant_library))
end
