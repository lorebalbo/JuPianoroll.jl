"""
	get_files(path::AbstractString; recursive::Bool = false)

Retrieves all MIDI files with `.mid` or `.midi` extensions from a specified directory or
validates and returns a single file path. When applied to directories, supports optional
recursive traversal of subdirectories to collect matching files.

# Arguments
- `path::AbstractString`: File or directory path to search for MIDI files.
- `recursive::Bool`: Whether to search subdirectories recursively; applicable only to directories.

# Returns
- `Vector{String}`: Array of file paths matching MIDI file extensions.
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
