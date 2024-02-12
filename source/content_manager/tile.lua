local filepath, content = ...
content.tile = {
    _data = {}, -- Contains the tiles' data
    _handlers = {}, -- Contains all the tile type handlers
}

require ("source.handlers.tile", content.tile._handlers)

-- A map containing all the required values in a tile JSON object
local requiredValues = {
    id = true,
    contentType = true,
    type = true,
    w = true,
    h = true,
}


--- Extracts data from a JSON table and loads it into the appropriate containers.
-- @param jsonObj (table) A table containing a JSON object
-- @param filename (string) The name of the file containing the JSON object
function content.tile.load (jsonObj, filename)
    filename = filename or ""
    
    -- Contains all the default values for a tile object
    local newObj = {
        name = filename,
        desc = filename,
        author = "Unknown",
        rotation = 0,
        cost = 0,
        frames = {},
        slopeFrames = {},
        foundation = true,
        validTerrain = {
            land = true,
        },
        tags = {},
        style = "all",
        density = 1,
        effects = {},
        roles = {},
        menu = {
            category = "cat_hidden",
            displayFrame = nil,
            position = math.huge,
        },
        load = true,
    }

    -- Overrides the default values
    for k, v in pairs (jsonObj) do
        newObj[k] = v
    end

    -- Checks if the tile object has all the required values
    for k, _ in pairs (requiredValues) do
        if newObj[k] == nil then
            error (filename .. " - Error: Missing required value: " .. k)
        end
    end

    -- Validates the tile object using its type handler
    if content.tile._handlers[newObj.type] == nil then
        error (filename .. " - Error: Invalid type: " .. newObj.type)
    elseif content.tile._handlers[newObj.type].init (newObj) == false then
        error (filename .. " - Error: Error with tile type")
    else
        content.tile._data[newObj.id] = newObj -- Adds the object to the data table
    end
end