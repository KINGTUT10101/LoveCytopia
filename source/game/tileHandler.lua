--[[
    ====Tile Handler====
    - Creates tile objects
]]

local tileHandler = {}

--- Creates a new mapData object.
function tileHandler:new (depth)
    depth = depth or 1

    local newTileObj = {
        depth = depth, -- The z-level of this tile
        effects = {}, -- Influences on the tile, like education or pollution
        layers = {
            [1] = layerHandler:new ("grass_ground"),
        },
    }
    
    return newTileObj
end