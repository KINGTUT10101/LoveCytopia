local filepath, map = ...
map.data = {
    _grid = {}, -- Holds the map tiles
    _props = {}, -- Holds any map-specific properties
}


--- Resets the map and its properties.
-- @param props (table) A table of properties for the new map
function map.data.reset (props)
    props = props or {}
    
    -- Set default property values
    map.data._props = {
        maxHeight = 16,
        minHeight = 1,
        width = 32,
        length = 32,
    }
    
    -- Set new property values
    for k, v in pairs (props) do
        map.data._props[k] = v
    end

    -- Reset map tiles
    local grid = {}
    for i = 1, map.data._props.width do
        grid[i] = {}
        local firstpart = grid[i]

        for j = 1, map.data._props.length do
            firstpart[j] = {z = map.data._props.minHeight}
            local secondPart = firstpart[j]
        end
    end
    map.data._grid = grid
end