"""
	_transpose(pianoroll::AbstractMatrix, semitones::Integer)::AbstractMatrix

Transposes a pianoroll matrix by shifting columns according to the specified semitone offset.
Positive values shift right, negative values shift left, and zero returns a copy without modification.

# Arguments
- `pianoroll::AbstractMatrix`: Input pianoroll matrix to be transposed.
- `semitones::Integer`: Number of semitones to shift; positive shifts right, negative shifts left.

# Returns
- `AbstractMatrix`: New matrix with columns shifted by the specified semitone offset.
"""
function _transpose(pianoroll::AbstractMatrix, semitones::Integer)::AbstractMatrix
    rows, cols = size(pianoroll)

    if semitones == 0
        # No shift
        return copy(pianoroll)
    elseif semitones < 0
        # Move to the left
        shift = abs(semitones)
        if shift >= cols
            # All columns are shifted out
            return zeros(eltype(pianoroll), rows, cols)
        else
            return hcat(pianoroll[:, (shift+1):end], zeros(eltype(pianoroll), rows, shift))
        end
    else
        # Move to the right
        if semitones >= cols
            # All columns are shifted out
            return zeros(eltype(pianoroll), rows, cols)
        else
            return hcat(zeros(eltype(pianoroll), rows, semitones), pianoroll[:, 1:(cols-semitones)])
        end
    end
end

"""
	transpose!(multitrack::AbstractMultitrack, key::AbstractKey)::AbstractMultitrack

Transposes all pianorolls in a multitrack object in-place to match the specified musical key.
Computes semitone distance from the current key and applies transposition to each track.
Errors if no key information exists.

# Arguments
- `multitrack::AbstractMultitrack`: Multitrack object to be transposed in-place.
- `key::AbstractKey`: Target musical key for transposition.

# Returns
- `AbstractMultitrack`: The modified multitrack object with transposed pianorolls.
"""
function transpose!(multitrack::AbstractMultitrack, key::AbstractKey)::AbstractMultitrack
    if !isnothing(multitrack.key)
        if multitrack.key == key
            @warn "The multitrack is already in the specified key. No transposition applied."
            return multitrack
        else
            semitones = key_distance(multitrack.key, key)
        end
    else
        error("Cannot transpose a multitrack with no key information.")
    end

    for track in multitrack.tracks
        track.pianoroll = _transpose(track.pianoroll, semitones)
    end

    multitrack.key = key

    return multitrack
end

"""
	transpose(multitrack::AbstractMultitrack, key::AbstractKey)::AbstractMultitrack

Creates a deep copy of the multitrack object and transposes all pianorolls to the specified
musical key. The original multitrack remains unmodified while the copy undergoes
transposition via the in-place variant.

# Arguments
- `multitrack::AbstractMultitrack`: Multitrack object to be transposed non-destructively.
- `key::AbstractKey`: Target musical key for transposition.

# Returns
- `AbstractMultitrack`: New multitrack object with transposed pianorolls.
"""
function transpose(multitrack::AbstractMultitrack, key::AbstractKey)::AbstractMultitrack
    return transpose!(deepcopy(multitrack), key)
end
