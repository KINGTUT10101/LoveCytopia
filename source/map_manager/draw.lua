local filepath, map = ...
local camera = require ("source.camera")
map.draw = {
    TILE_W = 32, -- Pixel width of a 1x1 tile
    TILE_H = 16, -- Pixel height of a 1x1 tile
    TILE_F = 8, -- Height factor, aka the height of a tile raised by one level
}

local TILE_W, TILE_H, TILE_F = map.draw.TILE_W, map.draw.TILE_H, map.draw.TILE_F

-- TEMP
love.graphics.setDefaultFilter ("nearest", "nearest")
love.graphics.setLineStyle ("smooth")
local imageData = love.image.newImageData ("tileImage.png")
local image = love.graphics.newImage (imageData)


--- Renders the map to the screen.
function map.draw.render ()
    local grid = map.data.grid
    
    love.graphics.push ()
        love.graphics.translate (camera.x, camera.y)
        love.graphics.scale (camera.zoom, camera.zoom)
        for i = 1, map.data.props.width do
            local firstPart = grid[i]

            for j = 1, map.data.props.length do
                local secondPart = firstPart[j]

                -- Calculates the screen position of the tile
                local screenX = (i - j) * (TILE_W / 2)
                local screenY = (i + j) * (TILE_H / 2) - secondPart.z * TILE_F

                love.graphics.draw (image, screenX, screenY)
            end
        end
    love.graphics.pop ()
end