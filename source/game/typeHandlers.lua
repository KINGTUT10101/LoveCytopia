local filepath, mapMan = ...

local typeHandlers = {
    ["default"] = {

    },
    ["ground"] = {

    }
}

function typeHandlers.ground:validatePlacement (x, y, layer, attributesRef)
    -- Check if the layer is correct
    if layer == 1 then
        return true
    end
    return false
end

function typeHandlers.ground:place (x, y, layer, attributesRef)
    local tileData = mapMan:getTile (x, y)

    local newLayerData = mapMan:newLayerData (attributesRef.id, 1)

    -- Check if anything exists at the layer
    if tileData.layers:getByKey (layer) then
        tileData.layers:setByKey (layer, newLayerData, 1)
    else
        tileData.layers:insert (1, newLayerData, 1)
    end
end