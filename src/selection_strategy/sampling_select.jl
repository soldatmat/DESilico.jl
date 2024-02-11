using StatsBase

struct SamplingSelect <: SelectionStrategy
    k::Int
    function SamplingSelect(k::Int; weighting::Union{Real,Nothing}=nothing)
        isnothing(weighting) || return WeightedSamplingSelect(k; weighting)
        k > 0 ? new(k) : throw(ArgumentError("`k` needs to be greater than 0"))
    end
end
function (ss::SamplingSelect)(variants::AbstractVector{Variant})
    @assert length(variants) >= ss.k
    map(variant -> variant.sequence, sample(variants, ss.k, replace=false))
end

struct WeightedSamplingSelect <: SelectionStrategy
    k::Int
    weighting::Real

    function WeightedSamplingSelect(k::Int; weighting::Real=1.0-eps())
        ((0.0 <= weighting) && (weighting < 1.0)) || throw(ArgumentError("`weighting` needs to be from <0,1)"))
        k > 0 || throw(ArgumentError("`k` needs to be greater than 0"))
        new(k, weighting)
    end
end
function (ss::WeightedSamplingSelect)(variants::AbstractVector{Variant})
    @assert length(variants) >= ss.k
    fitness = map(variant -> variant.fitness, variants)
    fitness = (abs(minimum(fitness)) .+ fitness) ./ maximum(fitness)
    weights = Weights((1.0 - ss.weighting) .+ (ss.weighting * fitness))
    map(variant -> variant.sequence, sample(variants, weights, ss.k, replace=false))
end
