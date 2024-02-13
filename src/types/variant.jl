"""
Represents a screened sequence with its fitness value.

    Variant(sequence::Vector{Char}, fitness::Float64)

# Arguments
- `sequence::Vector{Char}`: The sequence.
- `fitness::Float64`: Fitness value of the sequence.
"""
struct Variant
    sequence::Vector{Char}
    fitness::Float64
end

Base.copy(v::Variant) = Variant(v.sequence, v.fitness)
Base.deepcopy(v::Variant) = Variant(copy(v.sequence), v.fitness)

Base.hash(v::Variant, h::UInt) = hash(v.sequence, hash(:Variant, h))
Base.isequal(a::Variant, b::Variant) = Base.isequal(hash(a), hash(b))
