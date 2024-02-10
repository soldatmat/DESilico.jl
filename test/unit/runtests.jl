@testset "Unit Tests" begin
    include("types/variant.jl")
    include("types/sequence_space.jl")

    include("screening/dict_screening.jl")
    include("selection_strategy/top_k.jl")
    include("mutagenesis/single_mutation.jl")

    include("de.jl")
end
