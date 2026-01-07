"""
    key_distance(key1::Key, key2::Key)::Integer

Calculates the shortest distance in semitones between two keys.
Handles both major and minor modes using relative scale conversion.

# Arguments
- `key1::Key`: the first key
- `key2::Key`: the second key

# Returns
- The shortest distance in semitones between the two keys.
"""
function key_distance(key1::Key, key2::Key)::Integer
    # Convert tonics to integers (0-11)
    tonic1_val = Integer(key1.tonic)
    tonic2_val = Integer(key2.tonic)

    # Convert minor keys to their relative major
    # Minor relative major is +3 semitones
    if key1.mode == Minor
        tonic1_val = (tonic1_val + 3) % 12
    end
    if key2.mode == Minor
        tonic2_val = (tonic2_val + 3) % 12
    end

    # Calculate direct distance
    direct_distance = tonic2_val - tonic1_val

    # Find shortest path (considering circular nature)
    if direct_distance != 0
        if direct_distance < -6
            shortest_distance = direct_distance + 12
        elseif direct_distance > 6
            shortest_distance = direct_distance - 12
        else
            shortest_distance = direct_distance
        end
    else
        shortest_distance = 0
    end

    return shortest_distance
end

"""
    _notes_in_scale(Key::AbstractKey)::AbstractVector{<:Integer}

Given a musical key, returns the notes in that scale as a vector of integers (MIDI numbers).

# Arguments
- `Key::AbstractKey`: the musical key (tonic and mode).

# Returns
- `AbstractVector{<:Integer}`: a vector of integers (MIDI numbers)
"""
function _notes_in_scale(Key::AbstractKey)::AbstractVector{<:Integer}
    tonic = Int(Key.tonic)

    intervals = Key.mode == JuPianoroll.Major ? [0, 2, 4, 5, 7, 9, 11] : [0, 2, 3, 5, 7, 8, 10]

    notes = Set{Int}()

    for interval in intervals
        push!(notes, mod(tonic + interval, 12))
    end

    return sort(collect(notes))
end

"""
    get_pitches_in_scale(
        scale::AbstractString
    )::AbstractVector{<:Integer}

Given a scale in the format "Cmaj" or "Dmin", returns the pitches in that scale as a vector of integers.

# Arguments
- `scale::AbstractString`: the name of the scale (e.g., "Cmaj", "Dmin").

# Returns
- `AbstractVector{<:Integer}`: a vector of integers (MIDI numbers) representing the pitches in the scale.
"""
function get_pitches_in_scale(scale::AbstractString)::AbstractVector{<:Integer}
    parsekey(scale) |> get_pitches_in_scale
end

function get_pitches_in_scale(
        scale::AbstractKey
    )::AbstractVector{<:Integer}
    notes = _notes_in_scale(scale)
    matrix = [i + (j-1)*11 for i in 1:11, j in 1:12]

    filter(x -> x < 128, matrix[:, notes .+ 1])
end

"""
    get_pitches_range(
        multitrack::AbstractMultitrack;
        force_to_octave::Bool = false
    )::Tuple{<:Integer, <:Integer}

Get the upper bound and lower bound pitches used in a multitrack's pianorolls.

# Arguments
- `multitrack::AbstractMultitrack`: The multitrack containing tracks with pianorolls.
- `force_to_octave::Bool`: If true, forces the range to align with the tonic's octave.

# Returns
- `Tuple{<:Integer, <:Integer}`: A tuple containing the lower and upper bound pitches.
"""
function get_pitches_range(
        multitrack::AbstractMultitrack;
        force_to_octave::Bool = false
    )::Tuple{<:Integer, <:Integer}
    lower_bounds = Int[]
    upper_bounds = Int[]

    for track in multitrack.tracks
        lower_bound, upper_bound = get_pitches_range(track; key=multitrack.key, force_to_octave=force_to_octave)
        push!(lower_bounds, lower_bound)
        push!(upper_bounds, upper_bound)
    end

    return (minimum(lower_bounds), maximum(upper_bounds))
end

"""
    get_pitches_range(
        track::AbstractTrack;
        force_to_octave::Bool = false
    )::Tuple{<:Integer, <:Integer}

Get the upper bound and lower bound pitches used in a track's pianoroll.

# Arguments
- `track::AbstractTrack`: The track containing the pianoroll.
- `force_to_octave::Bool`: If true, forces the range to align with the tonic's octave.

# Returns
- `Tuple{<:Integer, <:Integer}`: A tuple containing the lower and upper bound pitches.
"""
function get_pitches_range(
        track::AbstractTrack;
        key::Union{<:AbstractKey, <:AbstractString, <:Nothing} = nothing,
        force_to_octave::Bool = false
    )::Tuple{<:Integer, <:Integer}
    @assert !(force_to_octave && isnothing(key)), "If force_to_octave is true, a key must be provided."

    if isa(key, AbstractString)
        key = parsekey(key)
    end

    cols = eachcol(track.pianoroll)

    lower_bound = findall(!iszero, cols)
    upper_bound = findall(!iszero, reverse(cols))

    if force_to_octave
        tonic  = Int(key) + 1
        tonics = [tonic + 12 * i for i in 0:11]
        filter!(x -> 1 <= x <= 128, tonics)

        upper_bound = findfirst(x -> x >= upper_bound, tonics)
        lower_bound = findlast(x -> x <= lower_bound, tonics)
    end

    return lower_bound, upper_bound
end
