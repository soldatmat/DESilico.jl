"""
Specifies the algorithm used to select new parent sequences from a library of sequence-fitness pairs.
Inherit this type to define a custom selection stratgy.

Structures derived from this type should have a constructor with signature:
`CustomSelectionStrategy(k::Int)`
`k` specifies the number of sequences that should be selected.
`k` can be ignored but it might not be possible to use the stucture in combination with certain
Mutagenesis implementations which require a specific amount of selected sequences.

Structures derived from this type have to implement the following method:
`(::CustomSelectionStrategy)(sequence_fitness_pairs::Vector{Tuple{Vector{Char},Real}})`
This method should return vector of selected sequences as `Vector{Vector{Char}}`.
"""
abstract type SelectionStrategy end

"""
Specifies the algorithm used to create new sequences from a library of parent sequences.
Inherit this type to define a custom mutagenesis.

Structures derived from this type need to have a constructor with signature:
`CustomMutagenesis(m::Int, alphabet::Set{Char})`
`m` specifies the number of new sequences that should be created.
`m` can be ignored but it might not be possible to use the stucture in combination with certain
SelectionStrategy implementations which require a specific amount of screened sequences.
`alphabet` is a set of all characters which can be used in the sequences.

Structures derived from this type have to implement the following method:
`(::CustomMutagenesis)(parents::Vector{Vector{Char}})`
This method should return vector of newly created sequences as `Vector{Vector{Char}}`.
"""
abstract type Mutagenesis end
