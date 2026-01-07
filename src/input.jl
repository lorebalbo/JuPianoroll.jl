"""
    _search_tempo(midi::MIDIFile)::Integer

Search for tempo events in the MIDI file and return the tempo in microseconds per quarter note.
If multiple tempo events are found with different tempos, an error is logged.
"""
function _search_tempo(midi::MIDIFile)::Integer
    # Search in each track for SetTempoEvent
    tempo_events = filter(!isempty, map(track -> getindex(track.events, findall(event -> event isa MIDI.SetTempoEvent, track.events)), midi.tracks))

    if !isempty(tempo_events)
        t = vcat(tempo_events...)

        if length(t) == 1 || all(tt -> tt.tempo == t[1].tempo, t)
            # Only one tempo events or all tempo events have the same tempo
            return t[1].tempo
        else
            @error "Multiple different tempo events found in MIDI file."
        end
    end
end

"""
    _set_tempo(midi::MIDIFile, us_per_quarter::Integer)::MIDIFile

Set the tempo of the MIDI file to the specified microseconds per quarter note.
This function removes any existing SetTempoEvent and inserts a new one at the beginning of each track.
"""
function _set_tempo(midi::MIDIFile, us_per_quarter::Integer)::MIDIFile
    for track_id in 1:length(midi.tracks)
        # Remove existing SetTempoEvent
        deleteat!(
            midi.tracks[track_id].events,
            findall(event -> event isa MIDI.SetTempoEvent, midi.tracks[track_id].events)
        )

        # Insert new SetTempoEvent at the beginning
        pushfirst!(midi.tracks[track_id].events, MIDI.SetTempoEvent(0, 0x51, us_per_quarter))
    end

    return midi
end

"""
    extract_note(track::MIDI.MIDITrack)::AbstractVector{<:AbstractNote}

Extract NoteOn and NoteOff events from a MIDI track and return a vector of Note objects.
"""
function _extract_note(track::MIDI.MIDITrack)::AbstractVector{<:AbstractNote}
    notes = Note[]

    absolute_tick = 0

    for event in track.events
        absolute_tick += event.dT

        if event isa MIDI.NoteOnEvent && event.velocity > 0
            # Note On event
            note = Note(event.note, event.velocity, absolute_tick, -1)
            push!(notes, note)
        elseif (event isa MIDI.NoteOffEvent) || (event isa MIDI.NoteOnEvent && event.velocity == 0)
            # Note Off event
            for note in reverse(notes)
                if note.pitch == event.note && note.stop_tick == -1
                    note.stop_tick = absolute_tick
                    break
                end
            end
        end
    end

    return notes
end

"""
    _extract_pianoroll(
        notes::AbstractVector{<:AbstractNote};
        resolution::Integer = 96,
        original_resolution::Integer = 96
    )::AbstractMatrix{<:Integer}

Convert a vector of Note objects into a piano roll matrix.

# Arguments
- `notes::AbstractVector{<:AbstractNote}`: Vector of Note objects.
- `resolution::Integer`: Desired time resolution (ticks (timesteps) per quarter note) for the piano roll.
- `original_resolution::Integer`: Original time resolution of the MIDI file.

# Returns
- `AbstractMatrix{<:Integer}`: Piano roll matrix with shape (time_steps, 128).
"""
function _extract_pianoroll(
        notes::AbstractVector{<:AbstractNote};
        resolution::Integer = 96,
        original_resolution::Integer = 96
    )::AbstractMatrix{<:Integer}
    max_tick = maximum(map(n -> n.stop_tick, notes))

    n_beats = ceil(Int, max_tick / original_resolution)

    max_tick_new = n_beats * resolution

    roll = zeros(Int, max_tick_new, 128)

    scale_factor = resolution / original_resolution

    # Find notes that need to be shortened, since they are immediately followed by another
    # note of the same pitch
    edit = Note[]
    pitches = unique(map(n -> n.pitch, notes))
    for pitch in pitches
        pitch_notes = filter(n -> n.pitch == pitch, notes)

        if length(pitch_notes) > 1
            for (note_a, note_b) in zip(pitch_notes[1:end-1], pitch_notes[2:end])
                if note_a.stop_tick == note_b.start_tick
                    push!(edit, note_a)
                end
            end
        end
    end

    for n in notes
        t_start = round(Int, n.start_tick * scale_factor) + 1
        t_stop  = round(Int, n.stop_tick * scale_factor) - (n in edit)

        # Clamp to max_tick_new
        t_stop = min(t_stop, max_tick_new)

        for t in t_start:t_stop
            roll[t, n.pitch + 1] = n.velocity
        end
    end

    return roll
end

"""
    _parsekey(key::Union{<:AbstractString, <:Nothing})::Union{AbstractKey, Nothing}

Parse a key string (e.g., "Cmaj", "A#min") into a Key object.
If the input is `nothing`, returns `nothing`.
"""
function parsekey(key::Union{<:AbstractString, <:Nothing})::Union{AbstractKey, Nothing}
    if isnothing(key)
        return nothing
    else
        key_clean = lowercase(strip(key))

        if length(key_clean) > 5 || length(key_clean) < 4
            @error "Key '$key' is not valid. Valid formats are e.g., 'Cmaj' and 'A#min'."
        end

        # Extract mode and tonic
        mode  = key_clean[end-2:end]
        tonic = replace(key_clean, mode => "")

        # Map to symbols
        mode  = mode_map[mode]
        tonic = note_map[tonic]

        # Get enum values
        mode  = getfield(JuPianoroll, Symbol(mode))
        tonic = getfield(JuPianoroll, Symbol(tonic))

        return Key(tonic, mode)
    end
end

"""
    read_midi(
        path::AbstractString;
        resolution::Union{<:Integer, <:Nothing} = nothing,
        key::Union{<:AbstractKey, <:AbstractString, <:Nothing} = nothing
    )::AbstractMultitrack

Read a MIDI file from the specified path and convert it into a MultiTrack object.

# Arguments
- `path::AbstractString`: Path to the MIDI file.
- `resolution::Union{<:Integer, <:Nothing}`: Desired time resolution (ticks (timesteps) per quarter note) for the piano roll. If `nothing`, uses the MIDI file's ticks per quarter note.
- `key::Union{<:AbstractKey, <:AbstractString, <:Nothing}`: Key information.

# Returns
- `AbstractMultitrack`: MultiTrack object representing the MIDI file.
"""
function read_midi(
        path::AbstractString;
        resolution::Union{<:Integer, <:Nothing} = nothing,
        key::Union{<:AbstractKey, <:AbstractString, <:Nothing} = nothing,
        bpm::Union{<:Integer, <:Nothing} = nothing
    )::AbstractMultitrack
    if key isa AbstractKey
        key_parsed = key
    else
        key_parsed = _parsekey(key)
    end

    midi = MIDI.load(path)

    if isnothing(resolution)
        @warn "Using MIDI file's ticks per quarter note ($(midi.tpq)) as resolution"
        resolution = midi.tpq
    end

    if !isnothing(bpm)
        us_per_quarter = round(Int, 60_000_000 / bpm)
        midi = _set_tempo(midi, us_per_quarter)
    else
        midi = _set_tempo(midi, _search_tempo(midi))
    end

    tracks = Track[]

    for (i, track) in enumerate(midi.tracks)
        id = findfirst(event -> event isa MIDI.TrackNameEvent, track.events)

        track_name = nothing

        if !isnothing(id)
            track_name = track.events[id].text
        else
            @warn "In MIDI file $(basename(path)) the track $i has no name."
        end

        notes = _extract_note(track)

        if !isempty(notes)
            push!(tracks, Track(track_name, _extract_pianoroll(notes; resolution=resolution, original_resolution=midi.tpq)))
        end
    end

    mt_name, _ = splitext(path)

    MultiTrack(
        mt_name,
        round(Int, 60_000_000 / _search_tempo(midi)),
        tracks,
        key_parsed
    )
end
