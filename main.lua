-- -- Loads the libraries
require ("source.libraries.requireExt")
local map = require ("source.map_manager")

-- Declares / initializes the global variables



-- Declares / initializes the local variables
local gameInfo = {
    version = "0.1"
}


-- Defines the functions



function love.load ()
    print ("Love, Cytopia v" .. gameInfo.version)
    
    -- Sets the image filter and line style so the graphics aren't blurry
    love.graphics.setDefaultFilter ("nearest", "nearest")
    love.graphics.setLineStyle ("smooth")

    -- Initializes the map
    map.data.reset ()
    
    print ("Setup successful. Load time: " .. string.format ("%.2f", tostring (os.clock ())) .. " seconds")
    print ("Entering the game...")
end


function love.update (dt)
    
end


function love.draw()
    map.draw.render ()
end


function love.keypressed (key)
    
end


function love.mousepressed(x, y, button, istouch, presses)
    
end