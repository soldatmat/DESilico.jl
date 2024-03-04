"""
Creates complete alphabet of all seen symbols at each position in provided sequences.

    AlphabetExtractor()

Constructs `AlphabetExtractor`.
"""
struct AlphabetExtractor <: AbstractAlphabetExtractor end

function (::AlphabetExtractor)(sequences::AbstractVector{Vector{Char}})
    alphabets = Vector{Set{Char}}(undef, length(sequences[1]))
    for position in 1:length(sequences[1])
        symbols = Vector{Char}(undef, length(sequences))
        for (p, parent) in enumerate(sequences)
            symbols[p] = parent[position]
        end
        alphabets[position] = Set(symbols)
    end
    return alphabets
end
