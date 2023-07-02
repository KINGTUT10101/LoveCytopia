local filepath, map = ...
local camera = require ("source.camera")
map.draw = {}

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

                local screenX = (i - j) * 16 -- (i + j) * (tileH / 2)
                local screenY = (i + j) * 8 - secondPart.z * 8 -- (i - j) * (tileW / 2)

                love.graphics.draw (image, screenX, screenY)
            end
        end
    love.graphics.pop ()
end