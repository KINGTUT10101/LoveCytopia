-- -- Loads the libraries
require ("source.libraries.requireExt")
local map = require ("source.map_manager")
local camera = require ("source.camera")

-- Declares / initializes the global variables



-- Declares / initializes the local variables
local gameInfo = {
    version = "0.1"
}

local mouseX, mouseY
local mouseXt, mouseYt


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
    mouseX, mouseY = love.mouse.getPosition ()
    
    mouseXt, mouseYt = camera.update (dt, mouseX, mouseY)
end


function love.draw()
    map.draw.render ()

    -- Renders backgrounds for GUI items
    love.graphics.setColor(0.25, 0.25, 0.25, 0.85)
    love.graphics.rectangle ("fill", 0, 0, 125, 125)
    love.graphics.rectangle ("fill", 690, 0, 125, 100)

    -- Shows the FPS
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.print ("FPS: " .. love.timer.getFPS(), 700, 20)

    -- Shows the tile coordinates
    local tileX, tileY = map.util.toMapCoords (mouseXt, mouseYt)
    love.graphics.print ("Map: " .. tileX .. ", " .. tileY, 700, 40)
    tileX, tileY = map.util.toFlatCoords (mouseXt, mouseYt)
    love.graphics.print ("Flat: " .. tileX .. ", " .. tileY, 700, 60)

    -- Shows the mouse info
    love.graphics.print ("Real: " .. mouseX .. ", " .. mouseY, 10, 20)
    love.graphics.print ("Transl: " .. math.floor (mouseXt) .. ", " .. math.floor (mouseYt), 10, 40)

    -- Shows the camera info
    love.graphics.print ("Cam: " .. camera.x .. ", " .. camera.y, 10, 60)
    love.graphics.print ("Zoom: " .. math.floor (camera.zoom * 100) / 100 .. "x", 10, 80)
end


function love.keypressed (key)
    if key == "r" then
        map.data.reset ()
    end
end


function love.mousepressed(x, y, button, istouch, presses)
    
end