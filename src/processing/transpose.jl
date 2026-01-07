"""
    _transpose(pianoroll::AbstractMatrix, semitones::Integer)::AbstractMatrix

Transpose a pianoroll matrix by the specified amount of semitones.

The transposition is obtained by shifting the columns of pianoroll matrix by `semitones` positions.

# Arguments
- `pianoroll::AbstractMatrix`: The input pianoroll matrix to shift.
- `semitones::Integer`: The number of columns to shift.
    - If `semitones > 0`, shifts columns to the right by `semitones` positions, filling with zeros on the left.
    - If `semitones < 0`, shifts columns to the left by `abs(semitones)` positions, filling with zeros on the right.
    - If `semitones == 0`, returns a copy of `pianoroll` with no shift.

# Returns
- A new matrix of the same size as `pianoroll`, with columns shifted as specified.
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
    transpose!(multitrack::AbstractMultitrack, semitones::Integer)::AbstractMultitrack

Transpose in-place all the pianoroll matrix of each track of an AbstractMultitrack object by the specified
amount of semitones.

See `_transpose(pianoroll::AbstractMatrix, semitones::Integer)` for more details.

# Arguments
- `multitrack::AbstractMultitrack`: The multitrack object containing tracks with pianorolls to be transposed (modified in-place).
- `semitones::Integer`: The number of semitones to transpose the pianorolls by.

# Returns
- `AbstractMultitrack`: The modified multitrack object with transposed pianorolls (same as input).
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

    return multitrack
end

"""
    transpose(multitrack::AbstractMultitrack, semitones::Integer)::AbstractMultitrack

Creates a copy of the multitrack and transposes all the pianoroll matrix of each track by the specified
amount of semitones.

See `_transpose(pianoroll::AbstractMatrix, semitones::Integer)` for more details.

# Arguments
- `multitrack::AbstractMultitrack`: The multitrack object containing tracks with pianorolls to be transposed.
- `semitones::Integer`: The number of semitones to transpose the pianorolls by.

# Returns
- `AbstractMultitrack`: A new multitrack object with transposed pianorolls (the original is not modified).
"""
function transpose(multitrack::AbstractMultitrack, semitones::Integer)::AbstractMultitrack
    return transpose!(deepcopy(multitrack), semitones)
end
