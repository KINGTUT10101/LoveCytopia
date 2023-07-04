local filepath, content = ...
content.tile = {
    _data = {}, -- Contains the tiles' data
    _handlers = {}, -- Contains all the tile type handlers
}
local data = content.tile._data
local handlers = content.tile._handlers

-- A map containing all the required values in a tile JSOn object
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
    local defaultTile = {
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

    -- Data validation
    
    -- Adds the object to the data table
    data[jsonObj.id] = jsonObj
end