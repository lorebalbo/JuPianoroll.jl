module JuPianoroll

using MIDI
using Makie
using CairoMakie
using Plots

include("types/index.jl")
include("processing/index.jl")
include("utils/index.jl")
include("pattern/index.jl")
include("analysis/index.jl")
include("plotting/index.jl")

include("input.jl")

export read_midi

# Types
export AbstractTrack, AbstractMultitrack, AbstractKey
export Track, Multitrack, Key

# Analysis
export n_tracks, tracks_name

# Processing
export binarize, binarize!
export transpose, transpose!
export attack_only
export movingwindow
export diatonic, diatonic!
export is_monophonic, is_polyphonic
export mark_on_going

# Utils
export key_distance
export parsekey
export get_pitches_in_scale
export get_pitches_range

# Pattern
export sia, plot_mtp
export siatec, plot_siatec_result

# Plotting
export plot_pianoroll


end
