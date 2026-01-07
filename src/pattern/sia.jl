using Makie

function sia(
        D::Vector{CartesianIndex{N}},
        min_pattern_size::Integer = 2
    )::Vector{Tuple{CartesianIndex{N}, Vector{CartesianIndex{N}}}} where N
    # 1. Lexicographic sort
    sort!(D, by = Tuple)

    # 2. Compute the vector table
    V = [(D[j] - D[i], i) for i in eachindex(D) for j in eachindex(D) if j > i]

    # 3. Sort the vector table
    #
    # Say that u and v are two vectors, while i and j are two integer.
    # We define that (u, i) is less than (v, j), denoted by (u, i) < (v, j),
    # if and only if u < v or u = v and i < j.
    sort!(V, by = x -> (Tuple(x[1]), x[2]))

    # 4. Compute the MTPs
    m = length(V)
    i = 1

    MTPs = []
    while i <= m
        v = V[i][1]

        patt = []
        push!(patt, D[V[i][2]])

        j = i + 1
        while j <= m && V[j][1] == V[i][1]
            push!(patt, D[V[j][2]])
            j += 1
        end

        push!(MTPs, (v, patt))

        i = j
    end

    # 5. Sort MTPs by size (not written in the paper)
    sort!(MTPs, by = x -> length(x[2]), rev = true)

    # 6. Filter one point MTPs
    filter!(x -> length(x[2]) >= min_pattern_size, MTPs)

    return MTPs
end

function plot_mtp(
        D::Vector{CartesianIndex{N}},
        mtp::Tuple{CartesianIndex{N}, Vector{CartesianIndex{N}}}
    ) where N
    # Check that N is at most 3
    N > 3 && throw(ArgumentError("plot_mtp supports only dimensions N ≤ 3, got N = $N"))

    traslator = first(mtp)
    pattern   = last(mtp)

    tralated_pattern = [point + traslator for point in pattern]

    if N == 1
        # 1D case: plot on a line
        xs_all = [point[1] for point in D]
        x_min = minimum(xs_all)
        x_max = maximum(xs_all)
        x_padding = (x_max - x_min) * 0.05
        x_lim = (x_min - x_padding, x_max + x_padding)

        fig = Figure(size=(1200, 600))

        # All points
        ax1 = Axis(fig[1, 1], title="All Points")
        scatter!(ax1, xs_all, zeros(length(xs_all)), markersize=10)
        limits!(ax1, x_lim..., -1, 1)

        # Pattern
        xs_red = [point[1] for point in pattern]
        ax2 = Axis(fig[2, 1], title="MTP")
        scatter!(ax2, xs_red, zeros(length(xs_red)), color=:red, markersize=10)
        limits!(ax2, x_lim..., -1, 1)

        # Translated pattern
        xs_green = [point[1] for point in tralated_pattern]
        ax3 = Axis(fig[3, 1], title="Translated Pattern")
        scatter!(ax3, xs_green, zeros(length(xs_green)), color=:green, markersize=10)
        limits!(ax3, x_lim..., -1, 1)

        return fig

    elseif N == 2
        # 2D case
        x_min = minimum(point[1] for point in D)
        x_max = maximum(point[1] for point in D)
        y_min = minimum(point[2] for point in D)
        y_max = maximum(point[2] for point in D)

        x_padding = (x_max - x_min) * 0.05
        y_padding = (y_max - y_min) * 0.05

        x_lim = (x_min - x_padding, x_max + x_padding)
        y_lim = (y_min - y_padding, y_max + y_padding)

        fig = Figure(size=(1200, 600))

        # All points
        xs_all = [point[1] for point in D]
        ys_all = [point[2] for point in D]
        ax1 = Axis(fig[1, 1], title="All Points")
        scatter!(ax1, xs_all, ys_all, markersize=10)
        limits!(ax1, x_lim..., y_lim...)

        # Pattern
        xs_red = [point[1] for point in pattern]
        ys_red = [point[2] for point in pattern]
        ax2 = Axis(fig[2, 1], title="MTP")
        scatter!(ax2, xs_red, ys_red, color=:red, markersize=10)
        limits!(ax2, x_lim..., y_lim...)

        # Translated pattern
        xs_green = [point[1] for point in tralated_pattern]
        ys_green = [point[2] for point in tralated_pattern]
        ax3 = Axis(fig[3, 1], title="Translated Pattern")
        scatter!(ax3, xs_green, ys_green, color=:green, markersize=10)
        limits!(ax3, x_lim..., y_lim...)

        return fig

    else # N == 3
        # 3D case
        x_min = minimum(point[1] for point in D)
        x_max = maximum(point[1] for point in D)
        y_min = minimum(point[2] for point in D)
        y_max = maximum(point[2] for point in D)
        z_min = minimum(point[3] for point in D)
        z_max = maximum(point[3] for point in D)

        x_padding = (x_max - x_min) * 0.05
        y_padding = (y_max - y_min) * 0.05
        z_padding = (z_max - z_min) * 0.05

        x_lim = (x_min - x_padding, x_max + x_padding)
        y_lim = (y_min - y_padding, y_max + y_padding)
        z_lim = (z_min - z_padding, z_max + z_padding)

        fig = Figure(size=(1800, 600))

        # All points
        xs_all = [point[1] for point in D]
        ys_all = [point[2] for point in D]
        zs_all = [point[3] for point in D]
        ax1 = Axis3(fig[1, 1], title="All Points")
        scatter!(ax1, xs_all, zs_all, ys_all, markersize=10)
        limits!(ax1, x_lim..., z_lim..., y_lim...)

        # Pattern
        xs_red = [point[1] for point in pattern]
        ys_red = [point[2] for point in pattern]
        zs_red = [point[3] for point in pattern]
        ax2 = Axis3(fig[1, 2], title="MTP")
        scatter!(ax2, xs_red, zs_red, ys_red, color=:red, markersize=10)
        limits!(ax2, x_lim..., z_lim..., y_lim...)

        # Translated pattern
        xs_green = [point[1] for point in tralated_pattern]
        ys_green = [point[2] for point in tralated_pattern]
        zs_green = [point[3] for point in tralated_pattern]
        ax3 = Axis3(fig[1, 3], title="Translated Pattern")
        scatter!(ax3, xs_green, zs_green, ys_green, color=:green, markersize=10)
        limits!(ax3, x_lim..., z_lim..., y_lim...)
        return fig
    end
end
