@testset "Unit Tests" begin
    include("types/variant.jl")
    include("types/sequence_space.jl")

    include("alphabet_extractor/alphabet_extractor.jl")
    include("screening/dict_screening.jl")
    include("selection_strategy/top_k.jl")
    include("selection_strategy/sampling_select.jl")
    include("mutagenesis/single_mutation.jl")
    include("mutagenesis/recombination.jl")

    include("utils.jl")
    include("de.jl")
end
