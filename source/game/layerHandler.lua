--[[
    ====Layer Handler====
    - Creates layer objects
]]

local layerHandler = {}

--- Creates a new mapData object.
function layerHandler:new (id, frame)
    frame = frame or 1
    
    assert (type (id) == "string", "Layer ID must be a string")

    local newLayerObj = {
        id = id,
        frame = frame,
    }
    
    return newLayerObj
end