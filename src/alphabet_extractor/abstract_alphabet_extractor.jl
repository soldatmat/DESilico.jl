"""
Extracts an alphabet for each position of sequences with same length.

Structures derived from this type have to implement the following method:
`(::CustomAlphabetExtractor)(sequences::AbstractVector{Vector{Char}}, positions::AbstractVector{Int})`
This method should return an alphabet from `sequences` for each position in `positions` as a subtype of `AbstractVector{Set{Char}}`.
This method can assume that `sequences` have the same length.

To extract alphabets at all positions, the following call can be used:
`(::CustomAlphabetExtractor)(sequences::AbstractVector{Vector{Char}})`
"""
abstract type AbstractAlphabetExtractor end

(ae::AbstractAlphabetExtractor)(sequences::AbstractVector{Vector{Char}}) = ae(sequences, collect(eachindex(sequences[1])))
