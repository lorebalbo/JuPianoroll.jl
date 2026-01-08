"""
	binarize!(multitrack::AbstractMultitrack)::AbstractMultitrack

Converts all pianoroll values in each track to binary format in-place by setting values
greater than zero to one and all others to zero. The function modifies the input multitrack
directly and returns it after transformation.

# Arguments
- `multitrack::AbstractMultitrack`: Multitrack object containing tracks with pianorolls to binarize.

# Returns
- `AbstractMultitrack`: Modified multitrack object with binarized pianorolls in all tracks.
"""
function binarize!(multitrack::AbstractMultitrack)::AbstractMultitrack
    for track in multitrack.tracks
        _binarize!(track)
    end
    return multitrack
end

"""
	_binarize!(track::AbstractTrack)::AbstractTrack

Converts pianoroll values in a single track to binary format in-place by setting positive
values to one and all others to zero. The function modifies the track's pianoroll array
directly and returns the modified track.

# Arguments
- `track::AbstractTrack`: Track object containing a pianoroll array to binarize.

# Returns
- `AbstractTrack`: Modified track object with binarized pianoroll values.
"""
function _binarize!(track::AbstractTrack)::AbstractTrack
    track.pianoroll = Int.(track.pianoroll .> 0)
    return track
end

"""
	binarize(multitrack::AbstractMultitrack)::AbstractMultitrack

Creates a deep copy of the multitrack and converts all pianoroll values to binary format by
setting positive values to one and others to zero. The function preserves the original
multitrack while returning a new binarized version.

# Arguments
- `multitrack::AbstractMultitrack`: Multitrack object containing tracks with pianorolls to binarize.

# Returns
- `AbstractMultitrack`: New multitrack object with binarized pianorolls, leaving original unchanged.
"""
function binarize(multitrack::AbstractMultitrack)::AbstractMultitrack
    return binarize!(deepcopy(multitrack))
end

"""
	_binarize(track::AbstractTrack)::AbstractTrack

Creates a deep copy of the track and converts its pianoroll values to binary format by
setting positive values to one and others to zero.
The function preserves the original track while returning a new binarized version.

# Arguments
- `track::AbstractTrack`: Track object containing a pianoroll array to binarize.

# Returns
- `AbstractTrack`: New track object with binarized pianoroll, leaving original unchanged.
"""
function _binarize(track::AbstractTrack)::AbstractTrack
    return _binarize!(deepcopy(track))
end
