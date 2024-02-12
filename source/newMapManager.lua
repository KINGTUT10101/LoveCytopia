local tiletypes = {}
local tileDefs = {}
local mapManager = {}

--- Sets the currently active map that will be modified by the map manager.
-- @param mapObj (table) A map object
function mapManager:setActiveMap (mapObj)
    self.activeMap = mapObj
end

--- Performs a game tick on the map.
-- @param dt (number) Delta time
function mapManager:update (dt)

end

--- Renders the map to the screen.
function mapManager:draw ()

end

--- Deletes all tiles on the map.
function mapManager:resetMap ()

end

--- Attempts to place a tile on the map.
-- @param mapX (number) The x-position
-- @param mapY (number) The y-position
-- @param tileID (string) Refers to an item in the tileDefs table
-- @return (bool) True if the area was clear and the conditions to place the tile were met, otherwise false
function mapManager:placeTile (mapX, mapY, tileID)

end

--- Calls a tile type handler for a map action.
-- @param tileID (string) Refers to an item in the tileDefs table
-- @param eventType (string) The name of the handler to call
-- @param ... (varargs) The arguments that will be passed to the handler
-- @return (?) The values returned by the handler
function mapManager:callTypeHandler (tileID, eventType, ...)
    return tiletypes[tileDefs[tileID]][eventType] (...)
end

return mapManager