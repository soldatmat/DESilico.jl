struct Variant
    sequence::Vector{Char}
    fitness::Float64
    Variant(sequence, fitness) = new(sequence, fitness)
end

Base.copy(v::Variant) = Variant(v.sequence, v.fitness)
Base.deepcopy(v::Variant) = Variant(copy(v.sequence), v.fitness)

Base.hash(v::Variant, h::UInt) = hash(v.sequence, hash(:Variant, h))
Base.isequal(a::Variant, b::Variant) = Base.isequal(hash(a), hash(b))
