module DESilico

export Variant
export de!, SequenceSpace

include("types/include.jl")
include("de.jl")
include("selection_strategy/include.jl")
include("mutagenesis/include.jl")
include("screening/include.jl")
include("alphabet.jl")
include("utils.jl")

end
