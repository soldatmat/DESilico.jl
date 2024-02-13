"""
TODO
"""
mutable struct SequenceSpace{T}
    population::Vector{Vector{Char}}
    variants::T
    top_variant::Variant

    SequenceSpace{T}(population, variants, top_variant) where {T} = new{T}(population, variants, top_variant)
    SequenceSpace(population, variants::T, top_variant) where {T} = new{T}(population, variants, top_variant)

    SequenceSpace(variants::Set{Variant}) = SequenceSpace{Set{Variant}}(variants)
    SequenceSpace(variants::AbstractVector{Variant}) = SequenceSpace{Set{Variant}}(variants)

    SequenceSpace{Set{Variant}}(variants::Set{Variant}) = new{Set{Variant}}([v.sequence for v in collect(variants)], variants, get_top_variant(collect(variants)))
    SequenceSpace{Set{Variant}}(variants::AbstractVector{Variant}) = new{Set{Variant}}([v.sequence for v in variants], Set(variants), get_top_variant(variants))

    SequenceSpace{Vector{Variant}}(variants::Set{Variant}) = new{Vector{Variant}}([v.sequence for v in collect(variants)], collect(variants), get_top_variant(collect(variants)))
    SequenceSpace{Vector{Variant}}(variants::AbstractVector{Variant}) = new{Vector{Variant}}([v.sequence for v in variants], variants, get_top_variant(variants))

    get_top_variant(variants::AbstractVector{Variant}) = sort(variants, by=x -> x.fitness, rev=true)[1]
end

function update_variants!(ss::SequenceSpace{Set{Variant}}, variants::AbstractVector{Variant})
    map(variant -> push!(ss.variants, variant), variants)
end
function update_variants!(ss::SequenceSpace{Vector{Variant}}, variants::AbstractVector{Variant})
    map(variant -> push!(ss.variants, variant), variants)
end

function update_top_variant!(ss::SequenceSpace, variant::Variant)
    variant.fitness > ss.top_variant.fitness && (ss.top_variant = variant)
end
function update_top_variant!(ss::SequenceSpace, variants::AbstractVector{Variant})
    map(variant -> update_top_variant!(ss, variant), variants)
end

function push_variants!(ss::SequenceSpace, variants::AbstractVector{Variant})
    update_variants!(ss, variants)
    update_top_variant!(ss, variants)
end
