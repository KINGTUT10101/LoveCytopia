-- TODO: Create a metatable that contains the default values for a tiledef

-- Contains the defintions of every tile object in the game
local Tiledefs = {}

-- Sets the image filter and line style so the graphics aren't blurry
love.graphics.setDefaultFilter ("nearest", "nearest")
love.graphics.setLineStyle ("smooth")

-- TODO: Loads in the defs from data/resources/data/TileData.json

-- TEMP: Loads in some test defs for a few tile objects
local imageData = love.image.newImageData ("assets/graphics/decoration/ground/GD_NA_sandstone_black.png")
Tiledefs[1] = {
    width = 1,
    height = 1,
    layer = 3,
    id = 1,
    title = "Concrete",
    desc = "This is a test.",
    type = "Generic",
    texture = {
        image = love.graphics.newImage (imageData),
        data = imageData,
        w = imageData:getWidth (),
        h = imageData:getHeight (),
    },
}

return Tiledefs