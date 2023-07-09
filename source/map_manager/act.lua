local filepath, map = ...
local tileData = require ("source.content_manager").tile._data
map.act = {}


function map.act.raise (mapX, mapY, amount)
    if (mapX >= 1 and mapX <= map.data._props.width) and ((mapY >= 1 and mapY <= map.data._props.length)) then
        local mapPart = map.data._grid[mapX][mapY]
        
        if (mapPart.z + amount) >= map.data._props.minHeight and (mapPart.z + amount) <= map.data._props.maxHeight then
            mapPart.z = mapPart.z + amount
        end
    end
end


--- Builds a tile onto the map.
-- This will fail if the space is already occupied or if the space is invalid for the given ID
-- @param mapX (int) The x position of the tile
-- @param mapY (int) The y position of the tile
-- @param id (string) The ID of the tile to build
-- @return True if the tile was built successfully
function map.act.build (mapX, mapY, id)
    if map.util.checkBounds (mapX, mapY) then
        map.data._grid[mapX][mapY][tileData[id].layer] = {
            id = id,
            images = tileData[id].images,
            frame = 1,
        }
    end
end