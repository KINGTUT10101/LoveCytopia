--[[local defaultScene = {name = "default"}

function defaultScene:load () end

function defaultScene:delete () end

function defaultScene:update () test () end

function defaultScene:draw () end

function defaultScene:keypressed () end]]--

local sceneMan = {
    stackSize = 0,
    scenes = {}, -- All created scenes will be stored here.
    stack = {}, -- Scenes that are pushed will be stored here.
    shared = {},
}

--[[setmetatable (sceneMan.stack, {
    __index = function ()
        return defaultScene
    end
})]]--

-- Adds a new scene to the scenes table and initializes it via its load method.
function sceneMan:newScene (name, scene, ...)
    self.scenes[name] = scene
    self.scenes[name].name = name
    self.scenes[name]:load (self, ...)
end

-- Removes a scene from the scenes table and calls its delete method.
function sceneMan:deleteScene (name, ...)
    if self.scenes[name] ~= nil then
        self.scenes[name]:delete (...)
        self.scenes[name] = nil
    end
end

-- Returns the current size of the stack. Value may range from 0 to infinity.
function sceneMan:getStackSize ()
    return self.stackSize
end

-- Returns the name of the current scene. It will return nil is there are no scenes on the stack.
function sceneMan:getCurrentScene ()
    return self.stackSize > 0 and self.stack[self.stackSize].name or nil
end

-- Adds a scene from the scenes table onto the stack. Scenes at the top of the stack will have their functions called last.
function sceneMan:push (name)
    if self.scenes[name] == nil then
        error ('Attempt to enter undefined scene "' .. name .. '"')
    end
    
    self.stackSize = self.stackSize + 1
    self.stack[self.stackSize] = self.scenes[name]
end

-- Pops a scene off the stack.
function sceneMan:pop ()
    if self.stackSize > 0 then
        self.stack[self.stackSize] = nil
        self.stackSize = self.stackSize - 1
    end
end

function sceneMan:clearStack ()
    self.stack = {}
    self.stackSize = 0
end

-- Adds a scene to the stack at a certain index.
function sceneMan:insert (name, index)
    if self.scenes[name] == nil then
        error ('Attempt to enter undefined scene "' .. name .. '"')
    end
    
    if index > 0 and index <= self.stackSize then
        self.stackSize = self.stackSize + 1
        table.insert (self.stack, index, name)
    end
end

-- Removes a scene to the stack at a certain index.
function sceneMan:remove (index)
    if index > 0 and index <= self.stackSize then
        self.stack[index] = nil
        self.stackSize = self.stackSize - 1
    end
end

--[[-- Swaps the positions of two scenes in the stack. It will fail if you use an invalid index.
function sceneMan:swap (index1, index2)
    if (index1 > 0 and index1 <= self.stackSize) and (index2 > 0 and index2 <= self.stackSize) then
        self.stack[index1], self.stack[index2] = self.stack[index2], self.stack[index1]
    end
end]]--

-- Iterates through every scene in the stack and calls each of their update methods.
function sceneMan:update (dt)
    for i = 1, self.stackSize do
        self.stack[i]:update (dt)
        if i >= self.stackSize then
            break
        end
    end
end

-- Iterates through every scene in the stack and calls each of their draw methods.
function sceneMan:draw ()
    for i = 1, self.stackSize do
        self.stack[i]:draw (dt)
        if i >= self.stackSize then
            break
        end
    end
end

-- Iterates through every scene in the stack and calls each of their keypressed methods.
function sceneMan:keypressed (key)
    for i = 1, self.stackSize do
        self.stack[i]:keypressed (key)
        if i >= self.stackSize then
            break
        end
    end
end

return sceneMan