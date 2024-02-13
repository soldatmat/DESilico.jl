using DESilico

# This example demonstrates usage of DESilico for simulation
# of a directed evolution of GB1 (protein G domain B1).
#
# We will use the dataset generated in
# Wu et al. “Adaptation in protein fitness landscapes is facilitated by indirect paths”. In: Elife 5 (2016), e16965.
# which is available at
# https://www.ncbi.nlm.nih.gov/bioproject/PRJNA278685/

# The script assumes the file with GB1 dataset is saved in the scripts folder.
# You can change the path here:
GB1_PATH = joinpath(@__DIR__, "elife-16965-supp1.xlsx")

# In the GB1 dataset, the wild type protein is mutated at four, predefined positions.
# We will use the four mutated amino acids instead of the full sequence.
wild_type = Variant(['V', 'D', 'G', 'V'], 1.0)

# For the simulation of directed evolution, we need to specify three modules:

# 1) `Screening` module specifies the oracle used to evaluate fitness of a sequence.
# A `Screening` structure can be constructed from a .xlsx file using `DESilico.DictScreening`.
screening = DESilico.DictScreening(GB1_PATH, 0.0)

# 2) `SelectionStrategy` specifies the algorithm used to select new parent sequences from a library of sequence-fitness pairs.
# We will use `DESilico.TopK` with `k=1`, which simlpy chooses the sequence with the top fitness.
selection_strategy = DESilico.TopK(1)

# 3) `Mutagenesis` specifies the algorithm used to create new sequences from a library of parent sequences.
# We will use `DESilico.SingleMutation` which creates all mutants which differ in one amino acid from the parent sequence/s.
#
# Most `Mutagenesis` structures require an alphabet.
# An alphabet is simply a `Set{Char}`.
# It can be imported from `DESilico.alphabet`.
alphabet = DESilico.alphabet.protein
mutagenesis = DESilico.SingleMutation(alphabet)

# We need to initiate `SequenceSpace`
ss = SequenceSpace([wild_type])

# Finally, we run `n_iterations` of directed evolution with the chosen modules.
de!(
    ss;
    screening,
    selection_strategy,
    mutagenesis,
    n_iterations=5,
)
println(ss.top_variant)
