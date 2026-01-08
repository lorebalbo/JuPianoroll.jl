using Makie

struct SIATECResult
    pattern::Vector{Tuple{Int, Int}}
    translators::Vector{CartesianIndex{2}}
end

"""
	siatec(D::Vector{CartesianIndex{N}}) where N

Computes translational equivalence classes and maximal translatable patterns from a sorted
dataset of multidimensional points using the SIATEC algorithm.
The function identifies repeated structural patterns by analyzing vector differences,
returning discovered patterns with their translation vectors.

# Arguments
- `D::Vector{CartesianIndex{N}}`: Input dataset of N-dimensional Cartesian points to analyze for patterns.

# Returns
- `Tuple{Vector{SIATECResult}, Vector{Tuple{Int, Vector{Any}}}, Vector{Vector{Tuple{CartesianIndex, Int}}}}`: Tuple containing SIATEC results with patterns and translators, sorted pattern metadata, and vector table.
"""
function siatec(
        D::Vector{CartesianIndex{N}}
    ) where N
    # 1. Lexicographic sort
    sort!(D, by = Tuple)

    # 2. Compute the W matrix
    W = [[(D[j] - D[i], i) for j in eachindex(D)] for i in eachindex(D)]
    W = vcat(W...)

    # 3. Compute the vector table (step 2 of SIA) by filtering W
    n = length(D)
    V = [W[k] for k in eachindex(W) if let i = div(k-1, n) + 1, j = mod(k-1, n) + 1; j > i end]

    # 4. Sort the vector table (step 3 of SIA)
    #
    # Say that u and v are two vectors, while i and j are two integer.
    # We define that (u, i) is less than (v, j), denoted by (u, i) < (v, j),
    # if and only if u < v or u = v and i < j.
    sort!(V, by = x -> (Tuple(x[1]), x[2]))

    # 5. Compute the TECs
    m = length(V)
    i = 1

    X = Set()
    while i <= m
        Q = Set()

        j = i + 1

        while j <= m && V[j][1] == V[i][1]
            push!(Q, D[V[j][2]] - D[V[j - 1][2]])
            j += 1
        end

        push!(X, (i, Q))

        i = j
    end

    # sort!(MTPs, by = x -> length(x[2]), rev = true)
    x = [(first(el), collect(last(el))) for el in X]

    # STEP 6
    Y = sort(x, by = x -> (length(x[2]), [Tuple(idx) for idx in x[2]]))

    # in Y il primo valore mi indica l'indice della tabella V mentre il secondo valore mi
    # indica la forma del pattern MTP
    function _get_pattern(I)
        p = length(I)
        I_vec = collect(I)

        # Restituisce un vettore di tuple (x, y)
        return [Tuple(D[I_vec[k]]) for k in 1:p]
    end

    function _get_set_of_translators(I)
        p = length(I)          # [cite: 8]
        n = length(D)          # [cite: 10]
        translators = Vector{CartesianIndex}()
        I = collect(I)

        translators = intersect([ first.(filter(el -> el[2] == i, W)) for i in I ]...)
        filter!(t -> t != CartesianIndex(0, 0), translators)

        return translators
    end

    function _get_siatec_results(Y, V)
        r = length(Y)
        m = length(V)

        results = SIATECResult[]

        i = 1

        if r > 0
            while i <= r
                j = Y[i][1]
                I = Set()

                while j <= m && V[j][1] == V[Y[i][1]][1]
                    push!(I, V[j][2])
                    j += 1
                end

                pattern = _get_pattern(I)
                translators = _get_set_of_translators(I)

                i += 1

                if !isempty(Y[i-1][2])
                    while (i <= r && Y[i][2] == Y[i - 1][2])
                        i += 1
                    end
                end

                push!(results, SIATECResult(pattern, translators))
            end
        end

        return results
    end

    filter!(y -> !isempty(y[2]), Y)
    results = _get_siatec_results(Y, V)

    return results, Y, V
end

"""
	plot_siatec_result(D::Vector{CartesianIndex{2}},
	                   result::SIATECResult;
	                   filename::Union{String, Nothing} = nothing)

Generates visualization plots for a SIATEC pattern discovery result, displaying the dataset with highlighted patterns and their translations. Creates multiple scatter plots showing the original dataset, identified pattern, and up to four translated pattern instances with optional file export.

# Arguments
- `D::Vector{CartesianIndex{2}}`: Original two-dimensional dataset of Cartesian points to visualize.
- `result::SIATECResult`: SIATEC result containing the discovered pattern and translator vectors.
- `filename::Union{String, Nothing}`: Optional output filename for saving the generated figure and individual plots.

# Returns
- `Figure`: Makie figure object containing all generated visualization plots arranged vertically.
"""
function plot_siatec_result(D::Vector{CartesianIndex{2}}, result::SIATECResult; filename::Union{String, Nothing} = nothing)
    # Converti il pattern da Vector{Tuple{Int, Int}} a Vector{CartesianIndex{2}}
    pattern_cart = map(CartesianIndex, result.pattern)

    # Calculate axis limits based on D
    x_min = minimum(p[1] for p in D)
    x_max = maximum(p[1] for p in D)
    y_min = minimum(p[2] for p in D)
    y_max = maximum(p[2] for p in D)

    # Add some padding (5% on each side)
    x_padding = (x_max - x_min) * 0.05
    y_padding = (y_max - y_min) * 0.05

    x_lim = (x_min - x_padding, x_max + x_padding)
    y_lim = (y_min - y_padding, y_max + y_padding)

    # Prepare data for all plots
    xs_all = [p[1] for p in D]
    ys_all = [p[2] for p in D]

    # Calculate number of plots
    max_translators = min(4, length(result.translators))
    n_plots = 2 + max_translators

    # Create figure with multiple axes
    fig = Figure(size = (2400, 250 * n_plots))

    # Plot 1: Tutti i punti del dataset in blu
    ax1 = Axis(fig[1, 1], xlabel = "Time", ylabel = "Pitch")
    colors_all = fill(:blue, length(D))
    scatter!(ax1, xs_all, ys_all, color = colors_all, markersize = 5)
    xlims!(ax1, x_lim)
    ylims!(ax1, y_lim)

    # Plot 2: Tutti i punti in blu tranne il pattern in rosso
    ax2 = Axis(fig[2, 1], xlabel = "Time", ylabel = "Pitch")
    colors_pattern = [p in pattern_cart ? :red : :blue for p in D]
    scatter!(ax2, xs_all, ys_all, color = colors_pattern, markersize = 5)
    xlims!(ax2, x_lim)
    ylims!(ax2, y_lim)

    # Plot 3+: Un grafico per ogni translator (massimo 4)
    for idx in 1:max_translators
        translator = result.translators[idx]
        # Trasla il pattern moltiplicandolo per il translator
        translated_pattern = pattern_cart .+ translator

        # Colora i punti: rosso se appartengono al pattern traslato, blu altrimenti
        colors_translated = [p in translated_pattern ? :red : :blue for p in D]

        ax = Axis(fig[2 + idx, 1], xlabel = "Time", ylabel = "Pitch",
                  title = "Translator $(Tuple(translator))")
        scatter!(ax, xs_all, ys_all, color = colors_translated, markersize = 5)
        xlims!(ax, x_lim)
        ylims!(ax, y_lim)
    end

    # Salva la figura se è stato specificato un filename
    if !isnothing(filename)
        save(filename, fig)
        println("Figure saved to: $filename")

        # Salva anche ogni plot individualmente
        base_name = splitext(filename)[1]
        ext = splitext(filename)[2]
        if isempty(ext)
            ext = ".png"
        end

        # Save individual plots
        for plot_idx in 1:n_plots
            individual_fig = Figure(size = (2400, 250))

            if plot_idx == 1
                ax = Axis(individual_fig[1, 1], xlabel = "Time", ylabel = "Pitch")
                scatter!(ax, xs_all, ys_all, color = fill(:blue, length(D)), markersize = 5)
            elseif plot_idx == 2
                ax = Axis(individual_fig[1, 1], xlabel = "Time", ylabel = "Pitch")
                scatter!(ax, xs_all, ys_all, color = colors_pattern, markersize = 5)
            else
                translator_idx = plot_idx - 2
                translator = result.translators[translator_idx]
                translated_pattern = pattern_cart .+ translator
                colors_translated = [p in translated_pattern ? :red : :blue for p in D]
                ax = Axis(individual_fig[1, 1], xlabel = "Time", ylabel = "Pitch",
                         title = "Translator $(Tuple(translator))")
                scatter!(ax, xs_all, ys_all, color = colors_translated, markersize = 5)
            end

            xlims!(ax, x_lim)
            ylims!(ax, y_lim)

            individual_filename = "$(base_name)_plot_$(plot_idx)$(ext)"
            save(individual_filename, individual_fig)
            println("Plot $plot_idx saved to: $individual_filename")
        end
    end

    return fig
end
