"""
    key_distance(key1::Key, key2::Key)::Integer

Calculates the shortest distance in semitones between two keys.
Handles both major and minor modes using relative scale conversion.

# Arguments
- `key1::Key`: the first key
- `key2::Key`: the second key

# Returns
- The shortest distance in semitones between the two keys.
"""
function key_distance(key1::Key, key2::Key)::Integer
    # Convert tonics to integers (0-11)
    tonic1_val = Integer(key1.tonic)
    tonic2_val = Integer(key2.tonic)

    # Convert minor keys to their relative major
    # Minor relative major is +3 semitones
    if key1.mode == Minor
        tonic1_val = (tonic1_val + 3) % 12
    end
    if key2.mode == Minor
        tonic2_val = (tonic2_val + 3) % 12
    end

    # Calculate direct distance
    direct_distance = tonic2_val - tonic1_val

    # Find shortest path (considering circular nature)
    if direct_distance != 0
        if direct_distance < -6
            shortest_distance = direct_distance + 12
        elseif direct_distance > 6
            shortest_distance = direct_distance - 12
        else
            shortest_distance = direct_distance
        end
    else
        shortest_distance = 0
    end

    return shortest_distance
end
