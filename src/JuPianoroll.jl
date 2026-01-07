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

# Utils
export key_distance

# Pattern
export sia, plot_mtp
export siatec, plot_siatec_result

end
