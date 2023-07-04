local filepath, map = ...
map.act = {}


function map.act.raise (mapX, mapY, amount)
    if (mapX >= 1 and mapX <= map.data._props.width) and ((mapY >= 1 and mapY <= map.data._props.length)) then
        local mapPart = map.data._grid[mapX][mapY]
        
        if (mapPart.z + amount) >= map.data._props.minHeight and (mapPart.z + amount) <= map.data._props.maxHeight then
            mapPart.z = mapPart.z + amount
        end
    end
end