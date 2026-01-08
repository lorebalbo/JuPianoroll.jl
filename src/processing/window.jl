"""
	movingwindow(pianoroll::AbstractMatrix{<:Integer};
	             resolution::Integer = 4,
	             lookback_beats::Integer = 1,
	             octaves_vision::Integer = 1,
	             unsupervised::Bool = false,
	             dead_silence::Bool = false,
	             rhythm::Bool = false)

Applies a sliding window transformation to a pianoroll matrix, extracting temporal-spatial
feature instances with configurable lookback beats, pitch range, and optional rhythm
metadata for machine learning tasks.

# Arguments
- `pianoroll::AbstractMatrix{<:Integer}`: Input pianoroll matrix with rows as timesteps and columns as pitches.
- `resolution::Integer`: Number of timesteps per beat (quarter note).
- `lookback_beats::Integer`: Number of beats included in each instance window.
- `octaves_vision::Integer`: Number of octaves visible on each side of target pitch.
- `unsupervised::Bool`: Whether to exclude labels from instances.
- `dead_silence::Bool`: Whether to prepend silence padding at the pianoroll start.
- `rhythm::Bool`: Whether to include beat, bar, and normalized beat position features.

# Returns
- `Vector{Vector{Vector{Int}}}`: Collection of instances, each containing feature vectors representing windowed pianoroll data.
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
