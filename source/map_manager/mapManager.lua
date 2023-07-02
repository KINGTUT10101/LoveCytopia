local mapManager = {
    grid = nil, -- A reference to a map
}


-- Wipes the map and replaces it with a new one of the specified size
function Map.clear (size)
    -- X axis
    for i = 1, size do
        grid[i] = {}
        local firstPart = grid[i]

        -- Y axis
        for j = 1, size do
            firstPart[j] = {z = 1}

            -- Layer
            grid[i][j][3] = {
                id = 1,
                frame = 1,
                frameRef = Tiledefs[1].texture,
            }

            if i == 16 and j == 10 then
                grid[i][j].z = 4
            end
        end
    end

    Map.size = size
end


-- Spawns a tile object in the map at the specified coordinates
function Map.spawn (x, y, id, frame)
    frame = frame or 1
    
    local result = false

    -- Checks if the action is within the map's bounds
    if x >= 1 and x <= Map.size and y >= 1 and y <= Map.size then
        -- TODO: Checks if the area is clear
        if true then
            grid[x][y][Tiledefs[id].layer] = classes[Tiledefs[id].type]
        end
    end

    return result
end


-- Renders the entire map
function Map.draw ()
    for i = 1, Map.size do
        local firstPart = grid[i]

        for j = 1, Map.size do
            local secondPart = firstPart[j]

            -- TEMP: Renders layer 2 only
            local layerPart = secondPart[3]

            -- TEMP: highlights tiles at higher heights
            if secondPart.z > 1 then
                love.graphics.setColor (1, 0, 0, 1)
            else
                love.graphics.setColor (1, 1, 1, 1)
            end
            
            local screen_x = (i - j) * 16 -- (i - j) * (tileW / 2)
            local screen_y = (i + j) * 8 - secondPart.z * 8 -- (i + j) * (tileH / 2) - map[i][j] * heightMult
            love.graphics.draw (layerPart.frameRef.image, screen_x, screen_y)
        end
    end
end


-- Translates mouse coordinates into map coordinates while considering the tile's z-level
-- Returns -1, -1 if the mouse is outside the map
function Map.toMapCoords(mouseX, mouseY)
    local belowOffset = math.ceil (Map.height / (16 / 8))
    local aboveOffset = math.floor (minHeight / (tileH / heightMult))
    
    -- Original flat map coords
    local origX = math.floor (mouseY / 16 + (mouseX - 16) / 32) -- math.floor (mouseY / tileH + (mouseX - tileH) / tileW)
	local origY = math.floor (mouseY / 16 - (mouseX - 16) / 32) -- math.floor (mouseY / tileH - (mouseX - tileH) / tileW)

    -- TODO: check if original coords are below the map and skip the calculation if true

    -- Finds the coords of the farthest possible tile using the maximum tile height
    local nextX = origX + 7
    local nextY = origY + 7

    local hit = false
    local goEast = (mouseX % 32 > 16) ~=  (nextX % 2 == 1) ~= (nextY % 2 == 1)
    local contact = false

    -- Loops until a tile is hit or it surpasses the original tile
    while (hit == false and nextX >= origX and nextY >= origY) do
        -- Next position is within bounds
        if nextX >= 1 and nextX <= Map.size and nextY >= 1 and nextY <= Map.size then
            contact = true

            -- Checks if the mouse would hit the bounding box of the next tile
            -- It does this by adjusting the mouse's y-position as if it were in a flat map instead
            local tempHeight = mouseY + grid[nextX][nextY].z * 8
            local tempX = math.floor (((mouseX-16)/32)+(tempHeight/16)) -- math.floor (mouseY / tileH + (mouseX - tileH) / tileW)
            local tempY = math.floor ((-(mouseX-16)/32)+(tempHeight /16)) -- math.floor (mouseY / tileH - (mouseX - tileH) / tileW)

            if tempX == nextX and tempY == nextY then
                hit = true
            else
                -- Finds the next tile's coordinates
                if goEast == false then
                    nextX = nextX - 1 -- Choose north tile
                    goEast = not goEast
                else
                    nextY = nextY - 1 -- Choose west tile
                    goEast = not goEast
                end
            end

        -- Next position is out of bounds and the end of the map has been reached
        elseif contact == true then
            hit = true
            nextX = -1
            nextY = -1
        
        -- Next position is out of bounds, but the map still hasn't been reached
        else
            if goEast == false then
                nextX = nextX - 1 -- Choose north tile
                goEast = not goEast
            else
                nextY = nextY - 1 -- Choose west tile
                goEast = not goEast
            end
        end
    end

    -- The previous loop never encountered a tile within the map
    if contact == false then
        nextX = -1
        nextY = -1
    end

    return nextX, nextY
end


-- Translates mouse coordinates into map coordinates without considering the z-level of each tile
function Map.toRealCoords(mouseX, mouseY)
    local nearX = ((mouseX-16)/32)+(mouseY/16)
	local nearY = (-(mouseX-16)/32)+(mouseY/16)

    return nearX, nearY
end
  

return Map