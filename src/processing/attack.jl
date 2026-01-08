"""
	attack_only(pianoroll::AbstractMatrix)::AbstractMatrix

Extracts note onset positions by detecting rising edges in each pitch column of the
pianoroll matrix. The function identifies transitions from zero to one, preserving only the
first timestep of each note while discarding sustained values.

# Arguments
- `pianoroll::AbstractMatrix`: Input pianoroll matrix where rows represent pitches and columns represent timesteps.

# Returns
- `AbstractMatrix`: New pianoroll matrix containing only attack phase markers for each note onset.
"""
function attack_only(pianoroll::AbstractMatrix)::AbstractMatrix
    result = copy(pianoroll)
    for j in axes(result, 2)
        col = result[:, j]
        if any(col .== 1)
            v = zeros(Int, length(col))
            idxs = findall(diff(col) .== 1) .+ 1
            v[idxs] .= 1

            if col[1] == 1
                v[1] = 1
            end

            result[:, j] .= v
        end
    end

    return result
end

"""
	attack_only(multitrack::AbstractMultitrack)::AbstractMultitrack

Applies attack-only processing to all tracks within a multitrack object by iterating through
each track and extracting note onset positions. Returns a new multitrack object without
modifying the original.

# Arguments
- `multitrack::AbstractMultitrack`: Multitrack object containing multiple tracks with pianoroll data to process.

# Returns
- `AbstractMultitrack`: New multitrack object with attack-only pianorolls applied to all contained tracks.
"""
function attack_only(multitrack::AbstractMultitrack)::AbstractMultitrack
    result = deepcopy(multitrack)
    for track in result.tracks
        track.pianoroll = attack_only(track.pianoroll)
    end

    return result
end