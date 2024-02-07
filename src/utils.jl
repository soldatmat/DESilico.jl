function sequence_from_alphabet(sequence::AbstractVector{Char}, alphabet::Set{Char})
    for symbol in sequence
        if symbol ∉ alphabet
            return false
        end
    end
    return true
end
