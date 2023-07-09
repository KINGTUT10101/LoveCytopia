local filepath, container = ...
container.tile = {}


--- Initializes a tile object.
-- @param tileObj (table) A tile object
-- @return True if the tile object is valid
function container.tile.init (tileObj)
    tileObj.layer = 4
    return true
end