local filepath = ...

local map = {} -- Contains all the modules related to the map manager

-- Loads the other modules
require (filepath .. ".data", map) -- Stores and manages raw map data and map settings
require (filepath .. ".file", map) -- Handles map saving and loading
require (filepath .. ".draw", map) -- Handles rendering logic
require (filepath .. ".update", map) -- Used to execute a game tick
require (filepath .. ".act", map) -- Handles asynchronous map interactions
require (filepath .. ".util", map) -- Provides various utility functions

return map