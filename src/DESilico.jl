module DESilico

export Variant, SequenceSpace
export de!, de_evaluation

include("types/include.jl")
include("de.jl")
include("de_evaluation.jl")
include("selection_strategy/include.jl")
include("mutagenesis/include.jl")
include("screening/include.jl")
include("alphabet.jl")
include("utils.jl")

end
