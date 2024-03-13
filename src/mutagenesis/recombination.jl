using StatsBase

"""
Creates all recombinations of parents sequences.

    Recombination{T}(alphabet_extractor::T, mutation_positions::Union{Vector{Int},Nothing}, n::Union{Int,Nothing})
    Recombination(alphabet_extractor::T, mutation_positions::Union{Vector{Int},Nothing}, n::Union{Int,Nothing})
    Recombination{T}(alphabet_extractor::T; mutation_positions::Union{Vector{Int},Nothing}, n::Union{Int,Nothing}=nothing)
    Recombination(alphabet_extractor::T; mutation_positions::Union{Vector{Int},Nothing}, n::Union{Int,Nothing}=nothing)

Constructs `Recombination{T}`.

# Arguments
- `alphabet_extractor::T`: Structure called to obtained positional alphabets from parent sequences.
- `mutation_positions::Union{Vector{Int},Nothing}`: If provided, `parents` will be recombined only at `mutation_positions`.
                                                    Rest of the sequences will be taken from the first parent.
- `n::Union{Int,Nothing}`: If provided, `n` sequences will be sampled randomly from the recombined mutants.

    Recombination(; mutation_positions::Union{Vector{Int},Nothing}, n=nothing)

Constructs `Recombination{AlphabetExtractor}`.

# Keywords
- `mutation_positions::Union{Vector{Int},Nothing}`: If provided, `parents` will be recombined only at `mutation_positions`.
                                                    Rest of the sequences will be taken from the first parent.
- `n::Union{Int,Nothing}`: If provided, `n` sequences will be sampled randomly from the recombined mutants.
"""
struct Recombination{T} <: Mutagenesis where {T<:AbstractAlphabetExtractor}
    alphabet_extractor::T
    mutation_positions::Union{Vector{Int},Nothing}
    n::Union{Int,Nothing}
end

Recombination{T}(alphabet_extractor::T; mutation_positions=nothing, n=nothing) where {T} = Recombination(alphabet_extractor, mutation_positions, n)
Recombination(alphabet_extractor::AbstractAlphabetExtractor; mutation_positions=nothing, n=nothing) = Recombination(alphabet_extractor, mutation_positions, n)
Recombination(; mutation_positions=nothing, n=nothing) = Recombination(AlphabetExtractor(); mutation_positions, n)

function (m::Recombination)(parents::AbstractVector{Vector{Char}})
    @assert DESilico.same_length_sequences(parents)
    length(parents) == 0 && return Vector{Vector{Char}}([])
    parent_residues = isnothing(m.mutation_positions) ? parents : map(p -> p[m.mutation_positions], parents)
    alphabets = m.alphabet_extractor(parent_residues)
    mutants = _recombine_symbols(alphabets)
    if !isnothing(m.n)
        mutants = sample(mutants, m.n, replace=false)
    end
    if !isnothing(m.mutation_positions)
       mutants = _build_mutants(parents[1], m.mutation_positions, mutants)
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

function _build_mutants(parent::AbstractVector{Char}, mutation_positions::AbstractVector{Int}, mutant_residues::AbstractVector{Vector{Char}})
    part_borders = [0, (pos for pos in mutation_positions)..., length(parent) + 1]
    parent_parts = map(p -> parent[part_borders[p]+1:part_borders[p+1]-1], 1:length(part_borders)-1)
    map(mutant -> vcat(mapreduce(i -> vcat(parent_parts[i], mutant[i]), vcat, eachindex(mutant)), parent_parts[end]), mutant_residues)
end
