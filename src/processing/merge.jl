"""
	_transform_matrix(mat::Matrix{Int})

Marks note onset positions in a piano roll matrix by inserting sentinel values immediately
before active notes that follow silent positions. This transformation facilitates downstream
note boundary detection during multi-track merging operations.

# Arguments
- `mat::Matrix{Int}`: Input piano roll matrix where rows represent pitches and columns
  represent time steps.

# Returns
- `Matrix{Int}`: Transformed matrix with sentinel value 900 marking note onsets.
"""
function _transform_matrix(mat::Matrix{Int})
    mat_copy = copy(mat)
    rows, cols = size(mat_copy)
    for j in 1:cols
        for i in 2:rows  # Start at 2 because the first item is unprecedented
            if mat_copy[i] != 0 && mat_copy[i-1] == 0
                mat_copy[i-1] = 900
            end
        end
    end
    return mat_copy
end

"""
	merge_pianorolls(multitrack::Multitrack)::Multitrack

Combines all piano roll matrices from individual tracks into a single merged track by
applying element-wise maximum operations, preserving the highest velocity values at each
time-pitch coordinate. The merged track is appended to the multitrack object.

# Arguments
- `multitrack::Multitrack`: Input multitrack object containing multiple tracks with piano
  roll data.

# Returns
- `Multitrack`: Modified multitrack object with an additional merged track appended.
"""
function merge_pianorolls!(
        multitrack::Multitrack
    )::Multitrack
    pianorolls = Vector{AbstractMatrix{Int}}()

    for track in multitrack.tracks
        pianoroll = track.pianoroll
        transformed = _transform_matrix(pianoroll)
        push!(pianorolls, transformed)
    end

    # Ensure all pianorolls have the same dimensions by padding with zeros
    max_rows = maximum(size(pr, 1) for pr in pianorolls)
    max_cols = maximum(size(pr, 2) for pr in pianorolls)

    padded_pianorolls = Vector{Matrix{Int}}()
    for pr in pianorolls
        rows, cols = size(pr)
        if rows < max_rows || cols < max_cols
            padded = zeros(Int, max_rows, max_cols)
            padded[1:rows, 1:cols] = pr
            push!(padded_pianorolls, padded)
        else
            push!(padded_pianorolls, pr)
        end
    end

    merged_pianoroll = max.(padded_pianorolls...)

    merged_pianoroll[merged_pianoroll .== 900] .= 0

    merged_track = Track(
        "Merged Track",
        merged_pianoroll
    )

    push!(multitrack.tracks, merged_track)

    return multitrack
end
