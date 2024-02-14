"""
Creates all single-symbol mutants for each parent sequence.

    SingleMutation(alphabet::Set{Char})

# Arguments
`alphabet::Set{Char}`: Contains the characters which will be used to create mutants.
"""
struct SingleMutation <: Mutagenesis
    alphabet::Set{Char}
end

function (m::SingleMutation)(parents::AbstractVector{Vector{Char}})
    # more efficient implementation for a single parent
    function single_parent_mutation(parent::Vector{Char})
        mutant_library = Vector{Vector{Char}}(undef, 1 + length(parent) * (length(m.alphabet) - 1))
        mutant_library[1] = copy(parent)
        n_mutants = 1
        mutant = copy(parent)
        for pos in 1:length(parent)
            for symbol in m.alphabet
                symbol == parent[pos] && continue
                mutant[pos] = symbol
                n_mutants += 1
                mutant_library[n_mutants] = copy(mutant)
            end
            mutant[pos] = parent[pos]
        end
        return mutant_library
    end

    function multi_parent_mutation(parents::AbstractVector{Vector{Char}})
        mutant_library = Set{Vector{Char}}([])
        for parent in parents
            for pos in 1:length(parents[1])
                mutant = copy(parent)
                for symbol in m.alphabet
                    mutant[pos] = symbol
                    push!(mutant_library, copy(mutant))
                end
            end
        end
        return collect(mutant_library)
    end

    if length(parents) == 1
        return single_parent_mutation(parents[1])
    else
        return multi_parent_mutation(parents)
    end
end
