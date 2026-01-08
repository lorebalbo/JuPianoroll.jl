"""
	attack_only(pianoroll::Matrix)::Matrix

Extracts attack phases from each note by identifying onset positions where note transitions
from inactive to active state. Modifies the input matrix in-place by setting non-attack
frames to zero while preserving only the initial activation timesteps.

# Arguments
- `pianoroll::Matrix`: Input pianoroll matrix where columns represent time and rows represent pitches, modified in-place.

# Returns
- `Matrix`: Modified pianoroll matrix containing only note attack phases with onset positions marked as active.
"""
function attack_only(pianoroll::Matrix)::Matrix
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
	attack_only(multitrack::Multitrack)::Multitrack

Applies attack phase extraction to pianoroll matrices of all tracks within a multitrack
object by iterating through each track and processing its pianoroll.
Modifies track pianorolls in-place to retain only note onset positions.

# Arguments
- `multitrack::Multitrack`: Multitrack object containing multiple tracks, each with a pianoroll matrix to be processed.

# Returns
- `Multitrack`: Modified multitrack object where all track pianorolls contain only attack phases of notes.
"""
function attack_only(multitrack::Multitrack)::Multitrack
    for track in multitrack.tracks
        track.pianoroll = attack_only(track.pianoroll)
    end

    return multitrack
end

"""
	mark_on_going(pianoroll::AbstractMatrix{<:Integer})::AbstractMatrix{<:Integer}

Differentiates note onsets from sustained notes by marking continuation frames with a
distinct value. Creates a deep copy where frames matching the previous frame are marked as
ongoing, enabling distinction between attack and sustain phases.

# Arguments
- `pianoroll::AbstractMatrix{<:Integer}`: Binary matrix with rows as time steps and columns as pitches, containing only zeros or ones.

# Returns
- `AbstractMatrix{<:Integer}`: Matrix with values zero for inactive, one for onset, and two for ongoing sustained notes.
"""
function mark_on_going(
        pianoroll::AbstractMatrix{<:Integer}
    )::AbstractMatrix{<:Integer}
    @assert all(x -> x == 0 || x == 1, pianoroll) "pianoroll must be a binary matrix with values 0 or 1."

    marked_pianoroll = deepcopy(pianoroll)

    # Iterate over the pitches
    for j in axes(pianoroll, 2)
        # Iterate over the time steps
        # Start from the second time step since we need to check always the previous one
        for i in axes(pianoroll, 1)[2:end]
            # If at the current time step the note is playing as well at the previous one
            # then mark it as ongoing (mark it with the number 2)
            if pianoroll[i, j] == 1 && pianoroll[i-1, j] == 1
                marked_pianoroll[i, j] = 2
            end
        end
    end

    return marked_pianoroll
end

"""
	get_rhythm(pianoroll::Matrix)::Vector{Int}

Extracts rhythmic information by computing attack phases and collapsing each timestep into
a binary indicator of activity. Copies the input pianoroll, applies attack-only
transformation, then reduces each row to presence or absence of active notes.

# Arguments
- `pianoroll::Matrix`: Input pianoroll matrix containing note activation data across time and pitch dimensions.

# Returns
- `Vector{Int}`: Binary rhythm vector indicating presence of note onsets at each timestep.
"""
function get_rhythm(pianoroll::Matrix)::Vector{Int}
    pr = copy(pianoroll)
    pr = attack_only(pr)

    return [any(row .== 1) ? 1 : 0 for row in eachrow(pr)]
end