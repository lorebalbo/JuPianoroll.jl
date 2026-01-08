"""
	plot_pianoroll(multitrack::AbstractMultitrack)

Creates a figure with multiple scatter plots, one for each track in the multitrack.
Each scatter plot visualizes the pianoroll representation of the corresponding track,
identified by its name.

# Arguments
- `multitrack::AbstractMultitrack`: The multitrack object to visualize.

# Returns
- `Plot`: A Plots figure containing all scatter plots of the tracks.
"""
function plot_pianoroll(multitrack::AbstractMultitrack)
    n_tracks = length(multitrack.tracks)

    if n_tracks == 0
        error("La multitrack non contiene tracce da visualizzare")
    end

    # Calcola i limiti globali di pitch per tutte le tracce
    lower_bound, upper_bound = get_pitches_range(multitrack)
    y_min = isnothing(lower_bound) ? 0 : lower_bound - 1
    y_max = isnothing(upper_bound) ? 128 : upper_bound + 1

    # Titolo della figura
    title_str = isnothing(multitrack.name) ? "Pianoroll" : multitrack.name

    # Crea i subplot per ogni traccia
    plots_array = []

    for (idx, track) in enumerate(multitrack.tracks)
        # Estrai le coordinate dei punti attivi nella pianoroll
        pianoroll = track.pianoroll
        time_indices, pitch_indices = Int[], Int[]

        for row in axes(pianoroll, 1)  # tempo
            for col in axes(pianoroll, 2)  # pitch
                if pianoroll[row, col] > 0
                    push!(time_indices, row)
                    push!(pitch_indices, col)
                end
            end
        end

        # Crea lo scatter plot per questa traccia
        p = Plots.scatter(time_indices, pitch_indices,
                   markersize = 2,
                   markercolor = :black,
                   title = track.name,
                   xlabel = idx == n_tracks ? "Tempo" : "",
                   ylabel = "Pitch",
                   xlims = (-1, size(pianoroll, 1)),
                   ylims = (y_min, y_max),
                   legend = false,
                   framestyle = :box)

        push!(plots_array, p)
    end

    # Combina tutti i subplot in un layout verticale
    final_plot = Plots.plot(plots_array...,
                     layout = (n_tracks, 1),
                     size = (800, 300 * n_tracks),
                     plot_title = title_str)

    return final_plot
end
