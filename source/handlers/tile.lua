local filepath, container = ...
container.tile = {}


--- Initializes a tile object.
-- Since tile is the default type, we don't need to perform additional initialization
-- @param tileObj (table) A tile object
-- @return True if the tile object is valid
function container.tile.init (tileObj)
    return true
end