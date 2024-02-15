--[[
    ====Map Manager====
    - Handles gameplay at the top-most level
    - Does not store any data besides a reference to the mapData object
    - Implements the low-level functions for rendering, coordinate translation, etc
]]
local mapManager = {
    data = nil, -- A reference to the mapData object
}

--- Updates the map and its tiles.
function mapManager:update (dt)

end

--- Renders the map to the screen.
function mapManager:draw ()

end