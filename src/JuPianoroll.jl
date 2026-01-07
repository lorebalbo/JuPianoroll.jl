module JuPianoroll

using MIDI

include("types/index.jl")
include("processing/index.jl")
include("utils/index.jl")
include("pattern/index.jl")
include("analysis/index.jl")

include("input.jl")

export read_midi

# Analysis
export n_tracks, tracks_name

# Processing
export binarize, binarize!
export transpose, transpose!
export attack_only
export movingwindow
export diatonic, diatonic!
export is_monophonic, is_polyphonic

# Utils
export key_distance
export parsekey
export get_pitches_in_scale
export get_pitches_range

# Pattern
export sia, plot_mtp
export siatec, plot_siatec_result


end
