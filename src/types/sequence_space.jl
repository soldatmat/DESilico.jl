"""
TODO
"""
mutable struct SequenceSpace
    population::Vector{Vector{Char}}
    variants::Set{Variant}
    top_variant::Variant

    SequenceSpace(population, variants, top_variant) = new(population, variants, top_variant)
    SequenceSpace(variants::Set{Variant}) = new([v.sequence for v in collect(variants)], variants, get_top_variant(collect(variants)))
    SequenceSpace(variants::AbstractVector{Variant}) = new([v.sequence for v in variants], Set(variants), get_top_variant(variants))

    get_top_variant(variants::AbstractVector{Variant}) = sort(variants, by=x -> x.fitness, rev=true)[1]
end

function push_variants!(ss::SequenceSpace, variants::AbstractVector{Variant})
    for variant in variants
        push!(ss.variants, variant)
        if variant.fitness > ss.top_variant.fitness
            ss.top_variant = copy(variant)
        end
    end
end
