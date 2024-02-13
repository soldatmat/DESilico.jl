"""
Represents the progress of the directed evolution process.

# Fields
- `population::Vector{Vector{Char}}`: The current population of sequences.
- `variants::T`: Contains the information about screened variants.
- `top_variant::Variant`: The variants with the highest fitness value so far.

    SequenceSpace{T}(population::Vector{Vector{Char}}, variants::T, top_variant::Variant)
    SequenceSpace(population::Vector{Vector{Char}}, variants::T, top_variant::Variant)

Constructs `SequenceSpace{T}`.

# Arguments
- `population::Vector{Vector{Char}}`: The current population of sequences.
- `variants::T`: Contains the information about screened variants.
- `top_variant::Variant`: The variants with the highest fitness value so far.

    SequenceSpace{Set{Variant}}(variants::Set{Variant})
    SequenceSpace(variants::Set{Variant})
    
Constructs `SequenceSpace{Set{Variant}}`.

# Arguments
- `variants::Set{Variant}`: Used to create both `population` and `variants` fields.
                            The variant with the highest fitness is used as `top_variant` field.

    SequenceSpace{Set{Variant}}(variants::AbstractVector{Variant})
    SequenceSpace(variants::AbstractVector{Variant})

Constructs `SequenceSpace{Set{Variant}}`.

# Arguments
- `variants::AbstarctVector{Variant}`:  Used to create both `population` and `variants` fields.
                                        The variant with the highest fitness is used as `top_variant` field.

    SequenceSpace{Vector{Variant}}(variants::Set{Variant})

Constructs `SequenceSpace{Vector{Variant}}`.

# Arguments
- `variants::Set{Variant}`: Used to create both `population` and `variants` fields.
                            The variant with the highest fitness is used as `top_variant` field.

    SequenceSpace{Vector{Variant}}(variants::AbstractVector{Variant})

Constructs `SequenceSpace{Vector{Variant}}`.

# Arguments
- `variants::AbstarctVector{Variant}`:  Used to create both `population` and `variants` fields.
                                        The variant with the highest fitness is used as `top_variant` field.

    SequenceSpace{Nothing}(population, top_variant) = new{Nothing}(population, nothing, top_variant)

Constructs `SequenceSpace{Nothing}`.

# Arguments
- `population::Vector{Vector{Char}}`: The current population of sequences.
- `top_variant::Variant`: The variants with the highest fitness value so far.

    SequenceSpace{Nothing}(variants::Set{Variant})

Constructs `SequenceSpace{Nothing}`.

# Arguments
- `variants::Set{Variant}`: Used to create the `population` field.
                            The variant with the highest fitness is used as `top_variant` field.

    SequenceSpace{Nothing}(variants::AbstractVector{Variant})

Constructs `SequenceSpace{Nothing}`.

# Arguments
- `variants::AbstarctVector{Variant}`:  Used to create the `population` field.
                                        The variant with the highest fitness is used as `top_variant` field.
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

    SequenceSpace{Nothing}(population, top_variant) = new{Nothing}(population, nothing, top_variant)
    SequenceSpace{Nothing}(variants::Set{Variant}) = new{Nothing}([v.sequence for v in collect(variants)], nothing, get_top_variant(collect(variants)))
    SequenceSpace{Nothing}(variants::AbstractVector{Variant}) = new{Nothing}([v.sequence for v in variants], nothing, get_top_variant(variants))

    get_top_variant(variants::AbstractVector{Variant}) = sort(variants, by=x -> x.fitness, rev=true)[1]
end

function update_variants!(ss::SequenceSpace{Set{Variant}}, variants::AbstractVector{Variant})
    map(variant -> push!(ss.variants, variant), variants)
end
function update_variants!(ss::SequenceSpace{Vector{Variant}}, variants::AbstractVector{Variant})
    map(variant -> push!(ss.variants, variant), variants)
end
function update_variants!(ss::SequenceSpace{Nothing}, variants) end

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
