"""
	is_monophonic(track::AbstractTrack)::Bool

Determines whether a track contains only monophonic content by analyzing the attack-only
pianoroll representation. Each time step is examined to ensure no more than two
simultaneous non-zero elements exist, indicating at most one note plays at any given moment.

# Arguments
- `track::AbstractTrack`: Track object containing pianoroll data to be analyzed for monophonic properties.

# Returns
- `Bool`: True if the track is monophonic, false otherwise.
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
	is_polyphonic(track::AbstractTrack)::Bool

Determines whether a track contains polyphonic content by negating the result of the
monophonic check. Returns true when multiple notes play simultaneously at any time step
within the track's pianoroll representation.

# Arguments
- `track::AbstractTrack`: Track object containing pianoroll data to be analyzed for polyphonic properties.

# Returns
- `Bool`: True if the track is polyphonic, false otherwise.
"""
function is_polyphonic(track::AbstractTrack)::Bool
    return !is_monophonic(track)
end
