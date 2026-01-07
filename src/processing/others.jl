"""
    attack_only(pianoroll::Matrix)::Matrix

Keep only the attack phase of each note in the pianoroll.

# Arguments
- `pianoroll::Matrix`: The pianoroll matrix to process.

# Returns
- `Matrix`: The processed pianoroll matrix with only the attack phases preserved.
"""
function attack_only(pianoroll::Matrix)::Matrix
    for j in 1:size(pianoroll, 2)
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

Keep only the attack phase of each note in the pianoroll of each track of a Multitrack object.

See `attack_only(pianoroll::Matrix)` for more details.

# Arguments
- `multitrack::Multitrack`: The multitrack object to process.

# Returns
- `Multitrack`: The processed multitrack object with only the attack phases preserved.
"""
function attack_only(multitrack::Multitrack)::Multitrack
    for track in multitrack.tracks
        track.pianoroll = attack_only(track.pianoroll)
    end

    return multitrack
end

"""
    mark_on_going(pianoroll::Matrix{<:Integer})

Given a pianoroll binary matrix, differentiates the time steps where a note starts to play
from the time steps where a note is already playing.

# Arguments
- `pianoroll::Matrix{<:Integer}`: a binary matrix where the rows are the time steps and the columns are the pitches. The values can be either 0 (note not playing) or 1 (note playing)

# Returns
- `Matrix{<:Integer}`: a matrix where the values are 0 (note not playing), 1 (note playing) or 2 (note ongoing). A note is considered ongoing if it is playing at the current time step and at the previous time step.
"""
function mark_on_going(
        pianoroll::Matrix{<:Integer}
    )::Matrix{<:Integer}
    @assert all(x -> x == 0 || x == 1, pianoroll) "pianoroll must be a binary matrix with values 0 or 1."

    marked_pianoroll = copy(pianoroll)

    # Iterate over the pitches
    for j in 1:size(pianoroll, 2)
        # Iterate over the time steps
        for i in 2:size(pianoroll, 1)  # Start from 2 since we need to check the previous timestep
            # If at the current time step the note is playing as well at the previous time step then mark it as ongoing
            if pianoroll[i, j] == 1 && pianoroll[i-1, j] == 1
                marked_pianoroll[i, j] = 2
            end
        end
    end

    return marked_pianoroll
end

"""
    get_rhythm(pianoroll::Matrix)::Vector{Int}

Call `attack_only` on the pianoroll and transform each row into a scalar
(1 if there is at least one 1 in the row, 0 otherwise).

# Arguments
- `pianoroll::Matrix`: Input pianoroll.

# Returns
- `Vector{Int}`: Rhythm vector.
"""
function get_rhythm(pianoroll::Matrix)::Vector{Int}
    pr = copy(pianoroll)
    pr = attack_only(pr)

    return [any(row .== 1) ? 1 : 0 for row in eachrow(pr)]
end