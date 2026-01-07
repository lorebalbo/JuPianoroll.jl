abstract type AbstractKey end

note_map = Dict(
    "c"  => :C,
    "c#" => :Cs,
    "d"  => :D,
    "d#" => :Ds,
    "e"  => :E,
    "f"  => :F,
    "f#" => :Fs,
    "g"  => :G,
    "g#" => :Gs,
    "a"  => :A,
    "a#" => :As,
    "b"  => :B
)

# NOTE: The tonic names use 's' to denote sharps (e.g., Cs = C#)
@enum Tonic begin
    C
    Cs
    D
    Ds
    E
    F
    Fs
    G
    Gs
    A
    As
    B
end

mode_map = Dict(
    "maj" => :Major,
    "min" => :Minor
)

@enum Mode begin
    Major
    Minor
end

mutable struct Key <: AbstractKey
    tonic::Tonic
    mode::Mode
end