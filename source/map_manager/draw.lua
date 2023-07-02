local filepath, map = ...
map.draw = {}

-- TEMP
local imageData = love.image.newImageData ("assets/graphics/decoration/ground/GD_NA_sandstone_black.png")
local image = love.graphics.newImage (imageData)


--- Renders the map to the screen.
function map.draw.render ()
    local grid = map.data.grid
    
    for i = 1, map.data.props.width do
        local firstPart = grid[i]

        for j = 1, map.data.props.length do
            local secondPart = firstPart[j]

            local screenX = (i - j) * 16 -- (i + j) * (tileH / 2)
            local screenY = (i + j) * 8 - secondPart.z * 8 -- (i - j) * (tileW / 2)

            love.graphics.draw (image, screenX, screenY)
        end
    end
end