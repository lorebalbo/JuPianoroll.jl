module JuPianoroll

using MIDI

include("types/index.jl")
include("processing/index.jl")
include("utils/index.jl")
include("pattern/index.jl")

include("input.jl")

export read_midi

# Processing
export binarize, binarize!
export transpose, transpose!
export attack_only
export movingwindow
export diatonic, diatonic!

# Utils
export key_distance
export parsekey
export get_pitches_in_scale
export get_pitches_range

# Pattern
export sia, plot_mtp
export siatec, plot_siatec_result


end
