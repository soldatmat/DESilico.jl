"""
Specifies the algorithm used to select new parent sequences from a library of sequence-fitness pairs.
Inherit this type to define a custom selection stratgy.

Structures derived from this type have to implement the following method:
`(::CustomSelectionStrategy)(sequence_fitness_pairs::AbstractVector{Variant})`
This method should return vector of selected sequences as a subtype of `AbstractVector{<:AbstractVector{Char}}`.

Structures derived from this type can have a parameter `k` which specifies the number of sequences that should be selected.
This can be useful with some Mutagenesis implementations that require a specific amount of selected sequences as input.
"""
abstract type SelectionStrategy end

"""
Specifies the algorithm used to create new sequences from a library of parent sequences.
Inherit this type to define a custom mutagenesis.

Structures derived from this type have to implement the following method:
`(::CustomMutagenesis)(parents::AbstractVector{Vector{Char}})`
This method should return vector of newly created sequences as a subtype of `AbstractVector{Vector{Char}}`.
This method should not alter `parents`!

Structures derived from this type can have a parameter `m` which specifies the number of sequences that should be created.
This can be useful with some SelectionStrategy implementations that require a specific amount of selected sequences as input.

Structures derived from this type can have a parameter `alphabet` which specifies the allowed characters in the sequences.
"""
abstract type Mutagenesis end

"""
Specifies the oracle used to evaluate fitness of a sequence.

Structures derived from this type have to implement the following method:
`(::CustomScreening)(sequence::Vector{Char})`
This method should return the sequence's fitness value as a subtype of `Float64`.
"""
abstract type Screening end
