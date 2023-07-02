local camera = {
    x = 375,
    y = 75,
    zoom = 1,
    panStep = 800,
    zoomStep = 2,
}


--- Updates the camera manager and detects player inputs.
-- @param dt (float) Delta time from love.update ()
-- @param mouseX (number) The x position of the mouse
-- @param mouseY (number) The y position of the mouse
-- @return A pair of new mouse coordinates that reflect the camera's position and zoom
function camera.update (dt, mouseX, mouseY)
    if love.keyboard.isDown("up") then
        camera.y = camera.y + camera.panStep * dt
    elseif love.keyboard.isDown("down") then
        camera.y = camera.y - camera.panStep * dt
    end
        
    if love.keyboard.isDown("left") then
        camera.x = camera.x + camera.panStep * dt
    elseif love.keyboard.isDown("right") then
        camera.x = camera.x - camera.panStep * dt
    end

    if love.keyboard.isDown("-") then
        camera.zoom = math.max (camera.zoom - camera.zoomStep * dt, 0.5)
    elseif love.keyboard.isDown("=") then
        camera.zoom = camera.zoom + camera.zoomStep * dt
    end
    
    return camera.translate (mouseX, mouseY)
end


--- Gets the current position of the camera.
-- @return The camera's x and y position and its zoom level
function camera.getPosition ()
    return camera.x, camera.y, camera.zoom
end


--- Translates mouse coordinates according to the current camera position.
-- @param mouseX (number) The x position of the mouse
-- @param mouseY (number) The y position of the mouse
-- @return A pair of new mouse coordinates that reflect the camera's position and zoom
function camera.translate (mouseX, mouseY)
    local mouseXt = (mouseX - camera.x) / camera.zoom
    local mouseYt = (mouseY - camera.y) / camera.zoom

    return mouseXt, mouseYt
end

return camera