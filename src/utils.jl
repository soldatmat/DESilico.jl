function sequence_from_alphabet(sequence::AbstractVector{Char}, alphabet::Set{Char})
    for symbol in sequence
        if symbol ∉ alphabet
            return false
        end
    end
    return true
end

function same_length_sequences(sequences::AbstractVector{<:AbstractVector{Char}})
    length(sequences) == 0 && return true
    mapreduce((s) -> length(s) == length(sequences[1]), &, sequences) 
end
