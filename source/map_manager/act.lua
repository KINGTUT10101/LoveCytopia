local filepath, map = ...
map.act = {}


function map.act.raise (mapX, mapY, amount)
    if (mapX >= 1 and mapX <= map.data.props.width) and ((mapY >= 1 and mapY <= map.data.props.length)) then
        local mapPart = map.data.grid[mapX][mapY]
        
        if (mapPart.z + amount) >= map.data.props.minHeight and (mapPart.z + amount) <= map.data.props.maxHeight then
            mapPart.z = mapPart.z + amount
        end
    end
end