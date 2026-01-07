abstract type AbstractNote end

mutable struct Note <: AbstractNote
    pitch::Integer
    velocity::Integer
    start_tick::Integer
    stop_tick::Integer
end