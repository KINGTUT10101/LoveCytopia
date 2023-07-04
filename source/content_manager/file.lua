local filepath, content = ...
local json = require ("source.libraries.json.json")
require ("source.libraries.json.jsonc")
content.file = {}


--- Loads a JSON file from disk and stores its data into a table.
-- @param filename (string) The name of the JSON file to load
-- @return A table containing the data from the JSON file or nil if it failed
function content.file.loadJSON (filename)
    local result = nil
    local jsonStr = love.filesystem.read (filename)

    if filename ~= nil then
        result = json.decode_jsonc (jsonStr)
    end

    return result
end


--- Finds all the JSON files in a directory, translates them  calls the appropriate content loaders.
-- Files and folders starting with an underscore will be skipped
-- @param dir (string) A file directory, aka a path to a folder.
function content.file.loadContent (dir)
    local files =  love.filesystem.getDirectoryItems (dir)
    table.sort (files) -- Sorts the files in alphabetical order

    -- Iterates over all the files in the current folder
    for _, v in ipairs (files) do
        if v:sub (1, 1) ~= "_" then
            local filename = dir .. "/" .. v
            local fileType = love.filesystem.getInfo (filename).type -- Gets the file type

            -- Recursively call the function if its a folder
            if fileType == "directory" then
                content.file.loadContent (filename)

            -- Loads the JSON file if its a JSON file
            elseif fileType == "file" and v:sub (-5, #v):upper () == ".JSON" then
                local jsonTbl = content.file.loadJSON (filename)

                if jsonTbl ~= nil then
                    content.file.callLoaders (jsonTbl)
                else
                    error ("Error: Invalid JSON file in " .. v)
                end
            end
        end
    end
end


--- Calls the correct content loaders for a series of JSON objects in a JSON table array.
-- @param jsonTbl (table) An array of JSON objects
function content.file.callLoaders (jsonTbl)
    -- Iterates over the objects JSON array
    for _, v in ipairs (jsonTbl) do
        -- This is where the content loaders take over the loading process
        content[v.contentType].load (v)
    end
end