"""
Specifies the algorithm used to select new parent sequences from a library of sequence-fitness pairs.
Inherit this type to define a custom selection stratgy.

Structures derived from this type have to implement the following method:
`(::CustomSelectionStrategy)(variant_fitness_pairs::Vector{Tuple{Vector{Char},Real}})`
This method should return vector of selected sequences as `Vector{Vector{Char}}`.
"""
abstract type SelectionStrategy end

"""
Specifies the algorithm used to create new sequences from a library of parent sequences.
Inherit this type to define a custom mutagenesis.

Structures derived from this type have to implement the following method:
`(::CustomMutagenesis)(parents::Vector{Vector{Char}})`
This method should return vector of newly created sequences as `Vector{Vector{Char}}`.
"""
abstract type Mutagenesis end
