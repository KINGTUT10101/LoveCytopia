local KeyedArray = require ("source.libraries.keyedArray")

local minDepth, maxDepth = 1, 16
local minLayer, maxLayer = 1, 8
local TILE_W = 32 -- Pixel width of a 1x1 tile
local TILE_H = 16 -- Pixel height of a 1x1 tile
local TILE_F = 8 -- Height factor, aka the height of a tile raised by one level

-- TEMP
love.graphics.setDefaultFilter ("nearest", "nearest")
love.graphics.setLineStyle ("smooth")
local imageData = love.image.newImageData ("tileImage.png")
local image = love.graphics.newImage (imageData)

local mapMan = {
    data = nil, -- A reference to the map data table
}

local entityDefs = require ("source.game.entityDefs")
local typeHandlers = require ("source.game.typeHandlers", mapMan)

function mapMan:newLayerData (id, frame)
    local obj = {
        id = id,
        frame = frame,
        data = {},
    }

    return obj
end

function mapMan:newTileData (depth)
    local obj = {
        depth = depth,
        effects = {},
        layers = KeyedArray:new ()
    }

    obj.layers:insert (1, self:newLayerData ("grass_ground", 1), 1)

    return obj
end

function mapMan:newGridData (width, height, depth)
    local obj = {}

    for i = 1, width do
        obj[i] = {}
        for j = 1, height do
            obj[i][j] = self:newTileData (depth)
        end
    end

    return obj
end

function mapMan:newMapData ()
    local obj = {
        width = 32,
        height = 32,
        name = "Unnamed City",
    }

    obj.grid = self:newGridData (obj.width, obj.height, 1)

    return obj
end

function mapMan:getTile (x, y)
    return self.data.grid[x][y]
end

function mapMan:getLayer (x, y, layer)
    return self.data.grid[x][y].layers:getByPos (layer)
end

--- Generates a blank map, AKA a "default" map data object.
-- Only generates the map. It does not automatically set it as the current map
function mapMan:newMap ()
    return self:newMapData ()
end

--- Sets the current map data object.
function mapMan:setMap (mapData)
    self.data = mapData
end

--- Executes a handler function for a specific entity.
function mapMan:executeHandler (layerData, functionName, ...)
    return layerData.typeHandlerRef[functionName] (...)
end

function mapMan:update (dt)
    -- Update the map
end

function mapMan:draw ()
    for i = 1, self.data.width do
        for j = 1, self.data.height do
            local tileDataObj = self.data.grid[i][j]

            -- Should we just iterate over the full layer table or use a linked list?
            for pos, key, val in tileDataObj.layers:pairs () do
                -- Get ID, frame, and image data
                -- Then pass to type handler to render the image

                local screenX = (i - j) * (TILE_W / 2)
                local screenY = (i + j) * (TILE_H / 2) - tileDataObj.depth * TILE_F
    
                love.graphics.draw (image, screenX, screenY)
            end
        end
    end
end

--- Places an entity at a specified position.
-- This may fail depending on the tile's type and what already exists at the position
function mapMan:spawn (x, y, layer, id)
    local tile = self.getTile (x, y, layer)
    local layerData = tile.layers:getByPos (layer)

    if self.executeHandler (layerData, "validatePlacement", x, y, layer, layer.attributesRef) then
        self.executeHandler (layerData, "place", x, y, layer, layer.attributesRef)
    end
end

function mapMan:delete (x, y, layer)
    local tile = self.getTile (x, y, layer)

    tile.layers[layer] = nil
end

--- Swaps the positions of 2 entities.
-- This will fail if either of the entities are unmovable
function mapMan:swap (x1, y1, layer1, x2, y2, layer2)
    local tile1 = self.getTile (x1, y1, layer1)
    local tile2 = self.getTile (x2, y2, layer2)

    tile1.layers:setByPos (layer1, tile2.layers:getByPos (layer2))
    tile2.layers:setByPos (layer2, tile1.layers:getByPos (layer1))
end

return mapMan