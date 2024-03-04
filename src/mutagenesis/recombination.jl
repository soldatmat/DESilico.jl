"""
Creates all recombinations of parents sequences.

    Recombination{T}(alphabet_extractor::T)
    Recombination(alphabet_extractor::T)

Constructs `Recombination{T}`.

# Arguments
- `alphabet_extractor::T`: Structure called to obtained positional alphabets from parent sequences.

    Recombination()

Constructs `Recombination{AlphabetExctractor}`.
"""
struct Recombination{T} <: Mutagenesis where {T<:AbstractAlphabetExtractor}
    alphabet_extractor::T
end

Recombination() = Recombination(AlphabetExctractor())

function (m::Recombination)(parents::AbstractVector{Vector{Char}})
    @assert DESilico.same_length_sequences(parents)
    length(parents) == 0 && return Vector{Vector{Char}}([])
    alphabets = m.alphabet_extractor(parents)
    _recombine_symbols(alphabets)
end

function _recombine_symbols(alphabets::Vector{Set{Char}})
    sequence = map(alphabet -> [symbol for symbol in alphabet][1], alphabets)
    mutant_library = Vector{Vector{Char}}([sequence])
    for position in 1:length(alphabets)
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
