"""
    movingwindow(
        pianoroll::AbstractMatrix{Integer};
        resolution::Integer = 4,
        lookback_beats::Integer = 1,
        octaves_vision::Integer = 1,
        unsupervised::Bool = false,
        dead_silence::Bool = false,
        rhythm::Bool = false
    )

Perform a moving window on a pianoroll matrix where the columns are the pitches and rows are the timesteps.

# Arguments
- `pianoroll::AbstractMatrix{Integer}`: the pianoroll matrix.
- `resolution::Integer = 4`: the desired number of time steps in a beat (quarter note).
- `lookback_beats::Integer = 1`: the number of beats that compose an instance.
- `octaves_vision::Integer = 1`: The number of octaves that compose an instance.
- `unsupervised::Bool = false`: whether to return the instances without the labels or not.
- `dead_silence::Bool = false`: whether to add dead silence at the beginning of the pianoroll or not. If set to true, the pianoroll will be padded with fours at the beginning.
- `rhythm::Bool = false`: whether to include rhythm information in the instances or not.

# Returns
- `Vector{Vector{Vector{Int}}}`: A vector of instances where each instance is a vector of feature vectors.
"""
function movingwindow(
        pianoroll::AbstractMatrix{<:Integer};
        resolution::Integer = 4,
        lookback_beats::Integer = 1,
        octaves_vision::Integer = 1,
        unsupervised::Bool = false,
        dead_silence::Bool = false,
        rhythm::Bool = false
    )

    # Pre-compute constants
    octave_pad = octaves_vision * 12
    window_size = lookback_beats * resolution
    window_width = octave_pad * 2 + 1

    nrows, ncols = size(pianoroll)

    # Pad the pianoroll by adding columns filled with zeros to the left and right
    padded_pianoroll = hcat(
        zeros(Int, nrows, octave_pad),
        pianoroll,
        zeros(Int, nrows, octave_pad)
    )

    # Pad the pianoroll with beginning silence (a.k.a. dead silence)
    if dead_silence
        silence_pad = fill(4, window_size, size(padded_pianoroll, 2))
        padded_pianoroll = vcat(silence_pad, padded_pianoroll)
    end

    # Pre-compute loop bounds
    padded_nrows = size(padded_pianoroll, 1)
    row_range = padded_nrows - window_size + unsupervised

    # Pre-allocate result array
    num_instances = row_range * ncols
    instances = Vector{Vector{Vector{Int}}}(undef, num_instances)

    # Pre-compute number of features per instance
    num_features = window_width + (rhythm ? 3 : 0) + (unsupervised ? 0 : 1)

    idx = 1
    @inbounds for i in 1:row_range
        # Pre-compute rhythm values for this row (same for all columns)
        if rhythm
            row_offset = i - 1 + window_size
            label_beat = div(row_offset, resolution) + 1
            label_bar = div(row_offset, resolution * 4) + 1
            normalized = label_beat > 4 ? (label_beat % 4 == 0 ? 4 : label_beat % 4) : label_beat
        end

        @inbounds for j in 1:ncols
            # Create the flattened instance directly
            flattened_instance = Vector{Vector{Int}}(undef, num_features)

            # Extract columns as vectors using views to avoid copies
            col_end = j + window_width - 1
            @inbounds for k in 1:window_width
                flattened_instance[k] = Vector{Int}(@view padded_pianoroll[i:i + window_size - 1, j + k - 1])
            end

            feat_idx = window_width + 1

            if rhythm
                flattened_instance[feat_idx] = [label_beat]
                flattened_instance[feat_idx + 1] = [label_bar]
                flattened_instance[feat_idx + 2] = [normalized]
                feat_idx += 3
            end

            # Add the label as the last element
            if !unsupervised
                flattened_instance[feat_idx] = [padded_pianoroll[i + window_size, j + octave_pad]]
            end

            instances[idx] = flattened_instance
            idx += 1
        end
    end

    return instances
end
