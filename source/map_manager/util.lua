local filepath, map = ...
map.util = {}


--- Translates mouse coordinates into map coordinates.
-- @param mouseX (number) The x position of the mouse
-- @param mouseY (number) The y position of the mouse
-- @return A pair of map coordinates or -1, -1 if the mouse if outside the map
function map.util.toMapCoords (mouseX, mouseY)
    -- @todo Needs to check the farthest tile *on-screen* if we want to support infinite depth
    -- @todo Check if the original coords are below the map and skip the calculations if true
    
    local belowOffset = math.ceil (map.data.props.maxHeight / 2) -- math.ceil (maxHeight / (tileH / heightMult))
    local aboveOffset = math.floor (map.data.props.minHeight / 2) -- math.floor (minHeight / (tileH / heightMult))
    -- Original flat map coords
    local origX, origY = map.util.toFlatCoords (mouseX, mouseY)
    -- Coords of the farthest possible tile using the maximum tile height
    local nextX, nextY = origX + belowOffset, origY + belowOffset
    -- The last possible tile the algorithm should check
    local targetX, targetY = origX + aboveOffset, origY + aboveOffset
    -- Used in the algorithm to determine the next values of nextX and nextY
    -- ((mouseX % tileW) > (tileW / 2)) ~= (nextX % 2 == 1) ~= (nextY % 2 == 1)
    local moveEast = ((mouseX % 32) > 16) ~= (nextX % 2 == 1) ~= (nextY % 2 == 1)

    -- Loops until the correct tile is "hit" or until it surpasses the target tile
    while nextX >= targetX and nextY >= targetY do
        -- Used to offset mouseY so we can calculate the predicted position
        local tempY = 0
        
        -- Ensures that we don't reference the map table when the current position is out of bounds
        if (nextX >= 1 and nextX <= map.data.props.width) and (nextY >= 1 and nextY <= map.data.props.length) then
            tempY = mouseY + map.data.grid[nextX][nextY].z * 8
        end

        -- Translates the mouse position (with the offset mouseY value) into a 2D map position
        local predX, predY = map.util.toFlatCoords (mouseX, tempY)

        -- Checks if the correct tile was hit
        if predX == nextX and predY == nextY then
            return predX, predY

        else
            -- Finds the next tile's coordinates
            if moveEast == false then
                nextX = nextX - 1 -- Choose north (right) tile
                moveEast = not moveEast
            else
                nextY = nextY - 1 -- Choose west (left) tile
                moveEast = not moveEast
            end
        end
    end

    -- If a tile was never found, we can assume the mouse was out of bounds and set a default value
    return -1, -1
end


--- Translates mouse coordinates into map coordinates without considing the z-level of each tile.
-- @param mouseX (number) The x position of the mouse
-- @param mouseY (number) The y position of the mouse
-- @return A pair of map coordinates, even if they're invalid
function map.util.toFlatCoords (mouseX, mouseY)    
    local mapX = math.floor (mouseY / 16 + (mouseX - 16) / 32) -- math.floor (mouseY / tileH + (mouseX - tileH) / tileW)
	local mapY = math.floor (mouseY / 16 - (mouseX - 16) / 32) -- math.floor (mouseY / tileH - (mouseX - tileH) / tileW)

    return mapX, mapY
end