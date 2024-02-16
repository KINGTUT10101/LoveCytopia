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

function mapMan:newLayerData (id, frame, entityDefRef, typeHandlerRef)
    local obj = {
        id = id,
        frame = frame,
        entityDefRef = entityDefRef,
        typeHandlerRef = typeHandlerRef,
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

function mapMan:getLayerFromTile (tileData, layer)
    return tileData.layers:getByPos (layer)
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

function mapMan:resetMap ()
    local width, height = self.data.width, self.data.height

    for i = 1, width do
        for j = 1, height do
            self:spawn (i, j, 1, "grass_ground")
        end
    end
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

                if self:getLayer (i, j, pos).id == "default_ground" then
                    love.graphics.rectangle ("fill", screenX + 11, screenY, 10, 10)
                end
            end
        end
    end
end

--- Places an entity at a specified position.
-- This may fail depending on the tile's type and what already exists at the position
function mapMan:spawn (x, y, layer, id)
    local handler = typeHandlers[entityDefs[id].type]
    local newLayerData = self:newLayerData (id, 1, entityDefs[id], handler)

    return handler:place (x, y, layer, newLayerData)
end

function mapMan:delete (x, y, layer)
    local tileData = self:getTile (x, y)
    local layerData = self:getLayerFromTile (tileData, layer)
    local handler = typeHandlers[entityDefs[layerData.id].type]
    
    return handler:delete (x, y, layer, tileData)
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