local filepath = ...

-- Contains all the modules related to the content manager
-- It is responsible for managing modded and vanilla game items, like buildings
local content = {}

-- Loads the other modules
require (filepath .. ".tile", content) -- Handles buildings, terrain, decos, etc
require (filepath .. ".script", content) -- Handles scripts
require (filepath .. ".tool", content) -- Handles tools
require (filepath .. ".cat", content) -- Handles spawn menu categories
require (filepath .. ".util", content) -- Provides various utility functions
require (filepath .. ".file", content) -- Handles content saving and loading. Should be loaded last

return content