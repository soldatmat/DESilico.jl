# DESilico (Directed Evolution in Silico)

[![Build Status](https://github.com/soldamatlab/DESilico.jl/actions/workflows/CI.yml/badge.svg?branch=master)](https://github.com/soldamatlab/DESilico.jl/actions/workflows/CI.yml?query=branch%3Amaster)

DESilico is a julia package for in silico directed evolution (DE). It provides a general DE algortihm which consists of three modular steps. Each step is defined by a simple interface which allows for arbitrary combination of existing modules as well as easy implementation of custom modules.

## Directed Evolution
Directed evolution (DE) is an iterative process which mimics Darwinian evolution to design biological sequences with improved properties. One iteration of DE consists of three steps. **Mutagenesis**, where a population of sequences is mutated to create new variants. **Screening**, where the mutated variants are evaluated and assigned fitness, a numerical value representing the quality of the sequence. **Selection**, where screened variants are selected based on their fitness to form a new population of parents. The three modules of the algorithm each corresond to one of the steps of DE. An iteration of the algorithm simply contains a single call of each module, starting with a population of sequences and ending with a new one to replace it.

## Installation
DESilico is a WIP and as such is not yet registered. Use the following code for installation.
```
using Pkg

Pkg.add("https://github.com/soldamatlab/DESilico.jl")
```

## Usage
The DE algorithm is called via `de!(sequence_space::SequenceSpace; kwargs...)`

Arguments
- `sequence_space::SequenceSpace`: Maintains the current population of mutants and library of screened variants.

Keywords
- `screening::Screening`: Assigns fitness value to a sequence.
- `selection_strategy::SelectionStrategy`: Defines the algorithm used to select new parents from a pool of screened variants.
- `mutagenesis:Mutagenesis`: Defines the algorithm used to create new mutants from current population.
- `n_iterations::Integer=1`: Specifies the number of iteration of DE. Has to be greater than 0.

The `SequenceSpace` structure contains the current population of sequences as well as information about the sequence space learned through previous iterations of DE. It is helpful for consecutive runs of the algorithm (possibly with different modules).

`Screening`, `SelectionStrategy` and `Mutagenesis` are abstract types which correspond to the three steps of DE. A module is defined as a structure derived from one of the types. New modules only need to implement a single method dictated by their respective type.

### Mutagenesis
Structures derived from `Mutagenesis` have to implement the following method:  
`(::CustomMutagenesis)(parents::AbstractVector{Vector{Char}})`  
which should return a vector of newly created sequences as a subtype of `AbstractVector{Vector{Char}}`.

### Screening
Structures derived from `Screening` have to implement the following method:  
`(::CustomScreening)(sequence::Vector{Char})`  
which should return the sequence's fitness value as a subtype of `Float64`.

### SelectionStrategy
Structures derived from `SelectionStrategy` have to implement the following method:  
`(::CustomMutagenesis)(parents::AbstractVector{Vector{Char}})`  
which should return a vector of newly created sequences as a subtype of `AbstractVector{Vector{Char}}`.  
This method should not alter `parents`!

## Examples
For example of usage with predefined modules, see  
https://github.com/soldamatlab/DESilico.jl/blob/master/scripts/de_example.jl

For example of definition and use of custom modules, see  
https://github.com/soldamatlab/DESilico.jl/blob/master/scripts/custom_modules_example.jl


