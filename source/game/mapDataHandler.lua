--[[
    ====Map Data Handler====
    - Objects contain data about the overall state of the map
    - Objects contain references to the grid data
    - Handles map saving and loading
]]

local Object = require ("source/libraries/classic")
local MapDataClass = Object:extend ()

--- Creates a new mapData object.
function MapDataClass:new ()
    self.width = 32
    self.height = 32
    self.name = "Unnamed City"
    self.grid = nil
end

--- Saves a mapData object to disk.
function MapDataClass:save (filepath)

end

--- Loads a mapData object from disk.
function MapDataClass:load (filepath)
    -- Return the mapData object here
end