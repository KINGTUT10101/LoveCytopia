--[[
    ====Grid Data Handler====
    - Creates 2D arrays of tile objects
]]

local gridDataHandler = {}

--- Creates a new mapData object.
function gridDataHandler:new (width, height, depth)
    depth = depth or 1

    local newGridDataObj = {}

    for i = 1, width do
        newGridDataObj[i] = {}
        for j = 1, height do
            newGridDataObj[i][j] = tileHandler:new (depth)
        end
    end
    
    return newGridDataObj
end