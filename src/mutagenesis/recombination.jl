using StatsBase

"""
Creates all recombinations of parents sequences.

    Recombination{T}(alphabet_extractor::T, n::Union{Int,Nothing})
    Recombination(alphabet_extractor::T, n::Union{Int,Nothing})
    Recombination{T}(alphabet_extractor::T; n::Union{Int,Nothing}=nothing)
    Recombination(alphabet_extractor::T; n::Union{Int,Nothing}=nothing)

Constructs `Recombination{T}`.

# Arguments
- `alphabet_extractor::T`: Structure called to obtained positional alphabets from parent sequences.
- `n::Union{Int,Nothing}`: If not `nothing`, `n` sequences will be sampled randomly from the recombined mutants.

    Recombination(; n=nothing)

Constructs `Recombination{AlphabetExctractor}`.

# Keywords
- `n::Union{Int,Nothing}`: If not `nothing`, `n` sequences will be sampled randomly from the recombined mutants.
"""
struct Recombination{T} <: Mutagenesis where {T<:AbstractAlphabetExtractor}
    alphabet_extractor::T
    n::Union{Int,Nothing}
end

Recombination{T}(alphabet_extractor::T; n=nothing) where {T} = Recombination(alphabet_extractor, n)
Recombination(alphabet_extractor::AbstractAlphabetExtractor; n=nothing) = Recombination(alphabet_extractor, n)
Recombination(; n=nothing) = Recombination(AlphabetExctractor(); n)

function (m::Recombination)(parents::AbstractVector{Vector{Char}})
    @assert DESilico.same_length_sequences(parents)
    length(parents) == 0 && return Vector{Vector{Char}}([])
    alphabets = m.alphabet_extractor(parents)
    mutants = _recombine_symbols(alphabets)
    if !isnothing(m.n)
        mutants = sample(mutants, m.n, replace=false)
    end
    return mutants
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
