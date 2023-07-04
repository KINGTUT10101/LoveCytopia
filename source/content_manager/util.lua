local filepath, content = ...
content.util = {}


--- Prints the contents of a table to the console.
-- The order in which elements are printed is not guaranteed
-- This is meant for debugging purposes
-- @param tbl (table) The table whose contents will be printed
-- @param indent (int) The number of indent spaces the elements will be printed at. Defaults to 0
function content.util.printTable (tbl, indent)
    indent = indent or 0
    local space = ""
    -- Generates the indent
    for i = 1, indent do
        space = space .. "    "
    end
    
    for k, v in pairs (tbl) do
        if type (v) == "table" then
            -- Recursively calls the function if the element is a table
            print (space .. "(" .. tostring (k) .. "):")
            content.util.printTable (v, indent + 1)
        else
            -- Prints the element
            print (space .. tostring (k) .. "    " .. tostring (v))
        end
    end
end