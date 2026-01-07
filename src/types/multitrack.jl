abstract type AbstractTrack end

mutable struct Track <: AbstractTrack
    name::AbstractString
    pianoroll::AbstractMatrix{<:Integer}
end

abstract type AbstractMultitrack end

mutable struct MultiTrack <: AbstractMultitrack
    name::AbstractString
    bpm::Union{Integer, Nothing}
    tracks::AbstractVector{<:AbstractTrack}
    key::Union{AbstractKey, Nothing}
end