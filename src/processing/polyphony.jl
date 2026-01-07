"""
    is_monophonic(pianoroll::AbstractMatrix)::Bool

Checks if the given pianoroll Abstractmatrix represents a monophonic sequence (only one note is
played at a time)

# Arguments
- `pianoroll::AbstractMatrix`: A pianoroll matrix to check whether is monophonic.

# Returns
- `Bool`: Returns `true` if the pianoroll is monophonic, otherwise returns `false`.
"""
function is_monophonic(track::AbstractTrack)::Bool
    # Keep only the attack phase of each note in the pianoroll
    ao_pianoroll = attack_only(track.pianoroll)

    # For each row checks if row has 2 non-zero elements
    for row in eachrow(ao_pianoroll)
        if count(row .!= 0) > 2
            return false
        end
    end

    return true
end

"""
    is_polyphonic(pianoroll::AbstractMatrix)::Bool

Checks if the given pianoroll Abstractmatrix represents a polyphonic sequence (more than one note is
played simultaneously)

# Arguments
- `pianoroll::AbstractMatrix`: A pianoroll Abstractmatrix to check whether is polyphonic.

# Returns
- `Bool`: Returns `true` if the pianoroll is polyphonic, otherwise returns `false`.
"""
function is_polyphonic(track::AbstractTrack)::Bool
    return !is_monophonic(track)
end
