"""
	key_distance(key1::Key, key2::Key)::Integer

Calculates the shortest semitone distance between two keys on a chromatic circle by
converting minor keys to relative majors and computing the minimal directional distance.
Handles circular wrapping to ensure distance values range from negative six to positive
six semitones.

# Arguments
- `key1::Key`: First musical key with tonic and mode.
- `key2::Key`: Second musical key with tonic and mode.

# Returns
- `Integer`: Shortest semitone distance from key1 to key2.
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
	_notes_in_scale(key::AbstractKey)::AbstractVector{<:Integer}

Extracts the pitch classes belonging to a musical key by computing scale
intervals from the tonic, using major or minor mode patterns, returning a
sorted vector of integers representing chromatic scale positions modulo twelve.

# Arguments
- `key::AbstractKey`: Musical key containing tonic and mode information.

# Returns
- `AbstractVector{<:Integer}`: Sorted pitch class integers from zero to eleven.
"""
function _notes_in_scale(key::AbstractKey)::AbstractVector{<:Integer}
    tonic = Int(key.tonic)

    intervals = key.mode == JuPianoroll.Major ? [0, 2, 4, 5, 7, 9, 11] : [0, 2, 3, 5, 7, 8, 10]

    notes = Set{Int}()

    for interval in intervals
        push!(notes, mod(tonic + interval, 12))
    end

    return sort(collect(notes))
end

"""
	get_pitches_in_scale(scale::AbstractString)::AbstractVector{<:Integer}

Parses a scale name string into a key structure and delegates to the key-based method to
retrieve all MIDI pitches belonging to that scale across the full MIDI range.
Serves as a convenience wrapper for string inputs.

# Arguments
- `scale::AbstractString`: Scale name in standard notation like "Cmaj" or "Dmin".

# Returns
- `AbstractVector{<:Integer}`: MIDI pitch numbers belonging to the specified scale.
"""
function get_pitches_in_scale(scale::AbstractString)::AbstractVector{<:Integer}
    parsekey(scale) |> get_pitches_in_scale
end

"""
	get_pitches_in_scale(scale::AbstractKey)::AbstractVector{<:Integer}

Generates all MIDI pitch numbers belonging to a musical key by expanding pitch classes
across eleven octaves and filtering values below the MIDI maximum. Constructs a matrix
mapping octaves to pitch classes and extracts relevant columns.

# Arguments
- `scale::AbstractKey`: Musical key defining tonic and mode.

# Returns
- `AbstractVector{<:Integer}`: MIDI pitch numbers in the scale under 128.
"""
function get_pitches_in_scale(
        scale::AbstractKey
    )::AbstractVector{<:Integer}
    notes = _notes_in_scale(scale)
    matrix = [j + (i-1)*12 for i in 1:11, j in 1:12]

    filter(x -> x < 128, matrix[:, notes .+ 1])
end

"""
	get_pitches_range(multitrack::AbstractMultitrack;
	                  force_to_octave::Bool = false)::Tuple{<:Integer, <:Integer}

Computes the overall pitch range across all tracks in a multitrack by aggregating individual
track ranges and returning the minimum lower bound and maximum upper bound.
Returns nothing values if no pitches are present in any track.

# Arguments
- `multitrack::AbstractMultitrack`: Multitrack containing multiple tracks with pianoroll data.
- `force_to_octave::Bool`: Whether to snap range boundaries to tonic octaves.

# Returns
- `Tuple{<:Integer, <:Integer}`: Lower and upper pitch bounds across all tracks.
"""
function get_pitches_range(
        multitrack::AbstractMultitrack;
        force_to_octave::Bool = false
    )::Tuple{<:Integer, <:Integer}
    lower_bounds = Int[]
    upper_bounds = Int[]

    for track in multitrack.tracks
        lower_bound, upper_bound = get_pitches_range(track; key=multitrack.key, force_to_octave=force_to_octave)

        if !isnothing(lower_bound) && !isnothing(upper_bound)
            push!(lower_bounds, lower_bound)
            push!(upper_bounds, upper_bound)
        end
    end

    if isempty(lower_bounds) || isempty(upper_bounds)
        return (nothing, nothing)
    end

    return (minimum(lower_bounds), maximum(upper_bounds))
end

"""
	get_pitches_range(track::AbstractTrack;
	                  key::Union{<:AbstractKey, <:AbstractString, <:Nothing} = nothing,
	                  force_to_octave::Bool = false)::Tuple{Union{<:Integer, Nothing}, Union{<:Integer, Nothing}}

Determines the lowest and highest active pitches in a track's pianoroll by scanning column
indices for nonzero values. Optionally snaps boundaries to tonic octave positions when
force_to_octave is enabled, requiring a valid key parameter.

# Arguments
- `track::AbstractTrack`: Track containing pianoroll matrix data.
- `key::Union{<:AbstractKey, <:AbstractString, <:Nothing}`: Optional key for octave alignment.
- `force_to_octave::Bool`: Whether to snap boundaries to tonic octaves.

# Returns
- `Tuple{Union{<:Integer, Nothing}, Union{<:Integer, Nothing}}`: Lower and upper pitch bounds or nothing values.
"""
function get_pitches_range(
        track::AbstractTrack;
        key::Union{<:AbstractKey, <:AbstractString, <:Nothing} = nothing,
        force_to_octave::Bool = false
    )::Tuple{Union{<:Integer, Nothing}, Union{<:Integer, Nothing}}
    @assert !(force_to_octave && isnothing(key)) "If force_to_octave is true, a key must be provided."

    if isa(key, AbstractString)
        key = parsekey(key)
    end

    cols = eachcol(track.pianoroll)

    if isempty(findall(!iszero, track.pianoroll))
        return nothing, nothing
    else
        lower_bound = findfirst(!iszero, cols)
        upper_bound = findlast(!iszero, cols)

        if force_to_octave
            tonic  = Int(key) + 1
            tonics = [tonic + 12 * i for i in 0:11]
            filter!(x -> 1 <= x <= 128, tonics)

            upper_bound = findfirst(x -> x >= upper_bound, tonics)
            lower_bound = findlast(x -> x <= lower_bound, tonics)
        end

        return lower_bound, upper_bound
    end
end
