"""
	diatonic!(multitrack::AbstractMultitrack)::AbstractMultitrack

Filters in-place each track's pianoroll to retain only pitches belonging to the multitrack's
assigned key. Modifies track pianoroll matrices by selecting columns corresponding to
diatonic scale pitches, discarding all non-diatonic pitch data without creating copies.

# Arguments
- `multitrack::AbstractMultitrack`: Multitrack object whose tracks will be filtered in-place based on its key property.

# Returns
- `AbstractMultitrack`: The same multitrack instance with modified track pianorolls containing only diatonic pitches.
"""
function diatonic!(multitrack::AbstractMultitrack)::AbstractMultitrack
    pitches_to_keep = get_pitches_in_scale(multitrack.key)

    for track in multitrack.tracks
        track.pianoroll = track.pianoroll[:, pitches_to_keep]
    end

    return multitrack
end

"""
	diatonic(multitrack::AbstractMultitrack)::AbstractMultitrack

Creates a deep copy of the multitrack and filters each track's pianoroll to retain only
pitches belonging to the multitrack's assigned key. Returns a new multitrack instance with
filtered pianorolls while preserving the original multitrack unchanged.

# Arguments
- `multitrack::AbstractMultitrack`: Multitrack object to be copied and filtered based on its key property.

# Returns
- `AbstractMultitrack`: New multitrack instance with track pianorolls containing only diatonic pitches from the assigned key.
"""
function diatonic(multitrack::AbstractMultitrack)::AbstractMultitrack
    return diatonic!(deepcopy(multitrack))
end