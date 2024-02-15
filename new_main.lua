local mapManager = require ("source/game/mapManager")

function love.load ()

end

function love.update (dt)
    mapManager:update (dt)
end

function love.draw ()
    mapManager:draw ()
end