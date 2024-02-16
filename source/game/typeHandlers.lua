local filepath, mapMan = ...

local typeHandlers = {
    ["default"] = {

    },
    ["ground"] = {

    }
}

function typeHandlers.default:place (x, y, layer, newLayerData)
    -- Check if the layer is correct
    if layer == 1 then
        local tileData = mapMan:getTile (x, y)

        -- Check if anything exists at the layer
        if tileData.layers:getByKey (layer) then
            tileData.layers:setByKey (layer, newLayerData, 1)
        else
            tileData.layers:insert (1, newLayerData, 1)
        end

        return true
    end
    
    return false
end

function typeHandlers.default:delete (x, y, layer, tileData)
    
    local result = tileData.layers:deleteByKey (layer)

    return result
end

return typeHandlers