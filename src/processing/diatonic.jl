"""
    diatonic!(multitrack::AbstractMultitrack, key::AbstractKey)::AbstractMultitrack

Filter in-place all the pianoroll matrices of each track in a multitrack to keep only the pitches
that belong to the specified key/scale.

This function modifies each track's pianoroll by setting to zero all columns (pitches) that are not
in the specified key. The pitches to keep are determined by the diatonic scale of the given key.

# Arguments
- `multitrack::AbstractMultitrack`: The multitrack object containing tracks with pianorolls to be filtered (modified in-place).
- `key::AbstractKey`: The musical key (tonic and mode) defining which pitches to keep.

# Returns
- `AbstractMultitrack`: The modified multitrack object with filtered pianorolls (same as input).
"""
function diatonic!(multitrack::AbstractMultitrack, key::AbstractKey)::AbstractMultitrack
    pitches_to_keep = get_pitches_in_scale(key)

    for track in multitrack.tracks
        track.pianoroll = track.pianoroll[:, pitches_to_keep]
    end

    return multitrack
end

function diatonic!(multitrack::AbstractMultitrack, key::AbstractString)::AbstractMultitrack
    return diatonic!(multitrack, parsekey(key))
end

"""
    diatonic(multitrack::AbstractMultitrack, key::AbstractKey)::AbstractMultitrack

Creates a copy of the multitrack and filters all the pianoroll matrices of each track to keep only
the pitches that belong to the specified key/scale.

This function returns a new multitrack where each track's pianoroll has been modified by setting to
zero all columns (pitches) that are not in the specified key. The original multitrack is not modified.

# Arguments
- `multitrack::AbstractMultitrack`: The multitrack object containing tracks with pianorolls to be filtered.
- `key::AbstractKey`: The musical key (tonic and mode) defining which pitches to keep.

# Returns
- `AbstractMultitrack`: A new multitrack object with filtered pianorolls (the original is not modified).
"""
function diatonic(multitrack::AbstractMultitrack, key::AbstractKey)::AbstractMultitrack
    return diatonic!(deepcopy(multitrack), key)
end

function diatonic(multitrack::AbstractMultitrack, key::AbstractString)::AbstractMultitrack
    return diatonic!(deepcopy(multitrack), parsekey(key))
end