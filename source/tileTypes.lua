local tileTypes = {}

--- Copies attributes and returns them so another type may override and inherit them.
-- @param tileTypeName (string) The name of the tile type to inherit from
local function inherit (tileTypeName)

end

tileTypes.default = {}

tileTypes.deco = inherit ("default")



return tileTypes