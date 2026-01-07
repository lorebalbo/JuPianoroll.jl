"""
    binarize!(multitrack::AbstractMultitrack) -> AbstractMultitrack

Converts the pianoroll of each track in the given `AbstractMultitrack` object to a binary format in-place.
All values in the pianoroll greater than 0 are set to 1, and all others are set to 0.

# Arguments
- `multitrack::AbstractMultitrack`: The multitrack object containing tracks with pianorolls to be binarized.

# Returns
- `AbstractMultitrack`: The modified multitrack object with binarized pianorolls.
"""
function binarize!(multitrack::AbstractMultitrack)::AbstractMultitrack
    for track in multitrack.tracks
        _binarize!(track)
    end
    return multitrack
end

function _binarize!(track::AbstractTrack)::AbstractTrack
    track.pianoroll = Int.(track.pianoroll .> 0)
    return track
end

"""
    binarize(multitrack::AbstractMultitrack) -> AbstractMultitrack

Creates a copy of the multitrack and converts the pianoroll of each track to a binary format.
All values in the pianoroll greater than 0 are set to 1, and all others are set to 0.

# Arguments
- `multitrack::AbstractMultitrack`: The multitrack object containing tracks with pianorolls to be binarized.

# Returns
- `AbstractMultitrack`: A new multitrack object with binarized pianorolls (the original is not modified).
"""
function binarize(multitrack::AbstractMultitrack)::AbstractMultitrack
    return binarize!(deepcopy(multitrack))
end

function _binarize(track::AbstractTrack)::AbstractTrack
    return _binarize!(deepcopy(track))
end
