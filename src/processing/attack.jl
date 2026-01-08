"""
	attack_only(pianoroll::AbstractMatrix)::AbstractMatrix

Extracts note onset positions by detecting rising edges in each pitch column of the
pianoroll matrix. The function identifies transitions from zero to one, preserving only the
first timestep of each note while discarding sustained values.

# Arguments
- `pianoroll::AbstractMatrix`: Input pianoroll matrix where rows represent pitches and columns represent timesteps.

# Returns
- `AbstractMatrix`: Modified pianoroll matrix containing only attack phase markers for each note onset.
"""
function attack_only(pianoroll::AbstractMatrix)::AbstractMatrix
    for j in axes(pianoroll, 2)
        col = pianoroll[:, j]
        if any(col .== 1)
            v = zeros(Int, length(col))
            idxs = findall(diff(col) .== 1) .+ 1
            v[idxs] .= 1
            pianoroll[:, j] .= v
        end
    end

    return pianoroll
end

"""
	attack_only(multitrack::AbstractMultitrack)::AbstractMultitrack

Applies attack-only processing to all tracks within a multitrack object by iterating through
each track and extracting note onset positions.
The function modifies each track's pianoroll in-place to retain only attack phase
information across all tracks.

# Arguments
- `multitrack::AbstractMultitrack`: Multitrack object containing multiple tracks with pianoroll data to process.

# Returns
- `AbstractMultitrack`: Modified multitrack object with attack-only pianorolls applied to all contained tracks.
"""
function attack_only(multitrack::AbstractMultitrack)::AbstractMultitrack
    for track in multitrack.tracks
        track.pianoroll = attack_only(track.pianoroll)
    end

    return multitrack
end