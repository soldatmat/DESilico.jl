struct SingleMutation <: Mutagenesis
    alphabet::Set{Char}
end
function (m::SingleMutation)(parents::AbstractVector{<:AbstractVector{Char}})
    len_sequence = length(parents[1])
    variant_library = Vector{Vector{Char}}(undef, length(parents) * len_sequence * length(m.alphabet))
    for (p, parent) in enumerate(parents)
        for pos in 1:len_sequence
            variant = copy(parent)
            for (s, symbol) in enumerate(m.alphabet)
                variant[pos] = symbol
                variant_library[(p-1)*len_sequence*length(m.alphabet)+(pos-1)*length(m.alphabet)+s] = copy(variant)
            end
        end
    end
    return collect(Set(variant_library))
end
