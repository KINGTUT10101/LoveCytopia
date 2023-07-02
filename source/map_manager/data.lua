local filepath, map = ...
map.data = {
    grid = {}, -- Holds the map tiles
    props = {}, -- Holds any map-specific properties
}


--- Resets the map and its properties.
-- @param props (table) A table of properties for the new map
function map.data.reset (props)
    props = props or {}
    
    -- Set default property values
    map.data.props = {
        maxHeight = 16,
        minHeight = 1,
        width = 32,
        length = 32,
    }
    
    -- Set new property values
    for k, v in pairs (props) do
        map.data.props[k] = v
    end

    -- Reset map tiles
    local grid = {}
    for i = 1, map.data.props.width do
        grid[i] = {}
        local firstpart = grid[i]

        for j = 1, map.data.props.length do
            firstpart[j] = {z = map.data.props.minHeight}
            local secondPart = firstpart[j]
        end
    end
    map.data.grid = grid
end