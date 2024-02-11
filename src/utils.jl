function sequence_from_alphabet(sequence::AbstractVector{Char}, alphabet::Set{Char})
    length(sequence) == 0 && return true
    mapreduce(symbol -> symbol ∈ alphabet, &, sequence)
end

function same_length_sequences(sequences::AbstractVector{<:AbstractVector{Char}})
    length(sequences) == 0 && return true
    mapreduce((s) -> length(s) == length(sequences[1]), &, sequences)
end
