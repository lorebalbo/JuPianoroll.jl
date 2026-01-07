"""
    attack_only(pianoroll::AbstractMatrix)::AbstractMatrix

Keep only the attack phase of each note in the pianoroll.

# Arguments
- `pianoroll::AbstractMatrix`: The pianoroll matrix to process.

# Returns
- `AbstractMatrix`: The processed pianoroll matrix with only the attack phases preserved.
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

Keep only the attack phase of each note in the pianoroll of each track of a Multitrack object.

See `attack_only(pianoroll::AbstractMatrix)` for more details.

# Arguments
- `multitrack::AbstractMultitrack`: The multitrack object to process.

# Returns
- `AbstractMultitrack`: The processed multitrack object with only the attack phases preserved.
"""
function attack_only(multitrack::AbstractMultitrack)::AbstractMultitrack
    for track in multitrack.tracks
        track.pianoroll = attack_only(track.pianoroll)
    end

    return multitrack
end