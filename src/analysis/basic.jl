"""
	tracks_name(multitracks::AbstractVector{<:AbstractMultitrack};
	            plot::Bool = true,
	            top_n::Union{Nothing, Int} = nothing
    )

Analyzes track name frequency across multiple multitrack objects and returns sorted results
by descending count. Optionally generates a bar chart visualization of track name
distribution and limits results to the top-n most frequent tracks when specified.

# Arguments
- `multitracks::AbstractVector{<:AbstractMultitrack}`: Vector of multitrack objects to analyze for track names.
- `plot::Bool`: Whether to display bar chart visualization of the track name distribution.
- `top_n::Union{Nothing, Int}`: Maximum number of most frequent tracks to return; unlimited if nothing.

# Returns
- `Tuple{Vector, Vector{Int}}`: Tuple containing track names and their occurrence counts, sorted by descending frequency.
"""
function tracks_name(multitracks::AbstractVector{<:AbstractMultitrack};
        plot::Bool = true,
        top_n::Union{Nothing, Int} = nothing
    )
    tracks_name = []

    for multitrack in multitracks
        append!(tracks_name, map(t -> t.name, multitrack.tracks))
    end

    vals = unique(tracks_name)
    counts = [countmap(tracks_name)[v] for v in vals]

    # Sort by counts in descending order
    sorted_indices = sortperm(counts, rev=true)
    vals = vals[sorted_indices]
    counts = counts[sorted_indices]

    # Apply top_n filter if specified
    if !isnothing(top_n)
        n = min(top_n, length(vals))
        vals = vals[1:n]
        counts = counts[1:n]
    end

    if plot
        fig = Figure()
        ax = Axis(fig[1, 1],
            title = "Most common tracks in the dataset",
            xlabel = "Track name",
            ylabel = "Count",
            xticklabelrotation = π/2
        )
        barplot!(ax, 1:length(vals), counts)
        ax.xticks = (1:length(vals), vals)
        display(fig)
    end

    return (vals, counts)
end

"""
	n_tracks(multitracks::AbstractVector{<:AbstractMultitrack})::AbstractVector{<:Integer}

Extracts all distinct track count values observed across a collection of multitrack objects and returns them as unique integers. The function counts tracks in each multitrack object and removes duplicate values from the result.

# Arguments
- `multitracks::AbstractVector{<:AbstractMultitrack}`: Vector of multitrack objects to extract track counts from.

# Returns
- `AbstractVector{<:Integer}`: Unique track count values found across all multitrack objects.
"""
function n_tracks(multitracks::AbstractVector{<:AbstractMultitrack})::AbstractVector{<:Integer}
    unique([length(mt.tracks) for mt in multitracks])
end