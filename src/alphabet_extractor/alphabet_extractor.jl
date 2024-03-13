"""
Creates complete alphabet of all seen symbols at each position in provided sequences.

    AlphabetExtractor()

Constructs `AlphabetExtractor`.
"""
struct AlphabetExtractor <: AbstractAlphabetExtractor end

function (::AlphabetExtractor)(sequences::AbstractVector{Vector{Char}}, positions::AbstractVector{Int})
    alphabets = Vector{Set{Char}}(undef, length(positions))
    for (pos, position) in enumerate(positions)
        symbols = Vector{Char}(undef, length(sequences))
        for (p, parent) in enumerate(sequences)
            symbols[p] = parent[position]
        end
        alphabets[pos] = Set(symbols)
    end
    return alphabets
end
