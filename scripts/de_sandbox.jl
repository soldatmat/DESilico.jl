"""
A simple de!() sandbox.

Select different DE modules (Screening, SelectionStrategy, Mutagenesis) and `initial_population`
to try different modules.
"""

# GB1 data from
# Wu et al. “Adaptation in protein fitness landscapes is facilitated by indirect paths”. In: Elife 5 (2016), e16965.
# is available at
# https://www.ncbi.nlm.nih.gov/bioproject/PRJNA278685/
GB1_PATH = joinpath(@__DIR__, "elife-16965-supp1.xlsx")
GB1_dict = DESilico.load_dict(GB1_PATH)
wild_type = Variant(['V', 'D', 'G', 'V'], 1.0)

# ___ Select Initial Population ________________________________
initial_population = [wild_type]
#initial_population = [wild_type, Variant(['F', 'W', 'G', 'V'], 3.18091081527), Variant(['Y', 'M', 'G', 'S'], 1.06536574309)]

# ___ Select Screening module __________________________________
screening = DESilico.DictScreening(GB1_dict, 0.0)

# ___ Select SelectionStrategy module __________________________
selection_strategy = DESilico.TopK(1)
#selection_strategy = DESilico.SamplingSelect(1)
#selection_strategy = DESilico.SamplingSelect(1, weighting=0.5)
#selection_strategy = DESilico.WeightedSamplingSelect(1)

# ___ Select Mutaegnesis module ________________________________
mutagenesis = DESilico.SingleMutation(DESilico.alphabet.protein)
#mutagenesis = DESilico.Recombination()
# ______________________________________________________________

ss = SequenceSpace(initial_population)
de!(
    ss;
    screening,
    selection_strategy,
    mutagenesis,
    n_iterations=10,
)
