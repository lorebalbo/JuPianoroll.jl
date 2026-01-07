"""
    tracks_name(multitracks::AbstractVector{<:AbstractMultitrack};
        plot::Bool = true,
        top_n::Union{Nothing, Int} = nothing
    )

Analyze the most common tracks across all the multitracks and optionally plot them as a bar chart.

# Arguments
- `multitracks::AbstractVector{<:AbstractMultitrack}`: vector of multitrack objects to analyze.
- `plot::Bool = true`: whether to plot the results as a bar chart.
- `top_n::Union{Nothing, Int} = nothing`: if specified, only show/return the top n most common tracks.

# Returns
- `(vals, counts)`: a tuple containing the track names and their counts.
- If `plot=true`, also displays a Makie bar chart.
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

Get the unique number of tracks across a vector of multitrack objects.

# Arguments
- `multitracks::AbstractVector{<:AbstractMultitrack}`: vector of multitrack objects to analyze.

# Returns
- `AbstractVector{<:Integer}`: a vector containing the unique number of tracks.
"""
function n_tracks(multitracks::AbstractVector{<:AbstractMultitrack})::AbstractVector{<:Integer}
    unique([length(mt.tracks) for mt in multitracks])
end