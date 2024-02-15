local defaultTypeHandler = {
    id = "default",
    draw = function () end,
}

local groundTypeHandler = {
    id = "ground",
    inherits = "default",
    draw = function () end,
}

local typeHandlers = {
    ground = groundTypeHandler,
    default = defaultTypeHandler,
}

local frameData = {
    image = nil,
    count = 1,
    width = 32,
    height = 32,
    offsetX = 0,
    offsetY = 0,
    beginX = 0,
    beginY = 0,
}

local entityDef = {
    id = "grass_ground",
    type = "ground",
    frames = {
        frameData
    },
    hiddenFrames = {},
    name = "Grass Ground",
    desc = "The default ground you walk upon!",
    tags = {"ground", "grass"},
}

local entityData = {
    -- Custom data goes here
}

local layerData = {
    id = "grass_ground",
    frame = 1,
    frameRef = {},
    attributesRef = entityDef,
    typeHandlerRef = typeHandlers.ground,
    data = entityData,
}

local tileData = {
    depth = 1,
    effects = {},
    layers = {
        [1] = layerData,
    },
}

local gridData = {
    [1] = {
        [1] = tileData
    },
}

local mapData = {
    width = 32,
    height = 32,
    name = "Unnamed City",
    grid = gridData,
}

local mapManager = {
    data = mapData,
    update = function () end,
    draw = function () end,
}

-- Example API usage
interface:resetMap ()

interface:spawn (x, y, layer)

interface:swap (x1, y1, layer1, x2, y2, layer2)