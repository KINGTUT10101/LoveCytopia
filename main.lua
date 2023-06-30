-- -- Loads the libraries


-- -- Declares / initializes the local variables
-- local Tiledefs = require ("source.classes.tiledefs")
-- local Map = require ("source.classes.map")

-- local test = require ("source.classes.tiles.filler")


-- -- Declares / initializes the global variables



-- -- Defines the functions



-- function love.load ()
    
    
--     Map.clear (32)
-- end


-- function love.update (dt)
    
-- end

-- -- TODO: TILE AT HIGHER ELEVATIONS SHOULD BE SLIGHTLY LIGHTER THAN TILES AT LOWER ELEVATIONS
-- function love.draw()
--     love.graphics.push ()
--         --love.graphics.scale (5, 5)
--         Map.draw ()
--     love.graphics.pop ()

--     local temp1, temp2 = Map.toMapCoords (love.mouse.getPosition ())
--     love.graphics.print ("Map: " .. temp1 .. ", " .. temp2, 500, 25)

--     temp1, temp2 = Map.toRealCoords (love.mouse.getPosition ())
--     love.graphics.print ("Flat: " .. math.floor (temp1) .. ", " .. math.floor (temp2), 500, 50)

--     temp1 = math.floor (temp1 * 10) / 10
--     temp2 = math.floor (temp2 * 10) / 10
--     love.graphics.print ("Real: " .. temp1 .. ", " .. temp2, 500, 75)

--     temp1, temp2 = love.mouse.getPosition ()
--     love.graphics.print ("Mouse: " .. temp1 .. ", " .. temp2, 500, 100)
-- end


-- function love.keypressed (key)
    
-- end


-- function love.mousepressed( x, y, button, istouch, presses )
--     local mapX, mapY = Map.toMapCoords (love.mouse.getPosition ())
    
--     if mapX >= 1 and mapY >= 1 then
--         -- Lower tile height when RMB is pressed
--         if button == 2 and Map.grid[mapX][mapY].z > 1 then
--             Map.grid[mapX][mapY].z = Map.grid[mapX][mapY].z - 1
--         end
        
--         -- Raises tile height when LMB is pressed
--         if button == 1 and Map.grid[mapX][mapY].z < Map.height then
--             Map.grid[mapX][mapY].z = Map.grid[mapX][mapY].z + 1
--         end
--     end
-- end