"""
    get_files(path::AbstractString; recursive::Bool = false)

Return all MIDI files (`.mid`, `.midi`) in the given `path`.

If `path` is a directory, returns all MIDI files in that directory. If `recursive` is set to `true`, the directory is searched recursively.

If `path` is a file, checks whether the file exists and returns its path.

# Arguments
- `path::AbstractString`: Path to a file or directory.
- `recursive::Bool = false`: Whether to search subdirectories recursively (if `path` is a directory).

# Returns
- A vector of file paths matching MIDI file extensions (`.mid`, `.midi`).
"""
function get_files(
        path::AbstractString;
        recursive::Bool = false,
    )
    extensions = [".mid", ".midi"]

    @assert ispath(path) "Invalid path: $path does not exist."
    @assert !(isfile(path) && recursive) "`recursive` is set to true but the provided path is not a directory"

    if isdir(path)
        if recursive
            return [joinpath(root, file) for (root, dirs, files) in walkdir(path) for file in files if isnothing(extensions) || any(endswith.(file, extensions))]
        else
            return [joinpath(path, file) for file in filter(el -> isfile(joinpath(path, el)), readdir(path)) if isnothing(extensions) || any(endswith.(file, extensions))]
        end
    else
        return [path]
    end
end
