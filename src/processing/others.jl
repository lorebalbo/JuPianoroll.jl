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