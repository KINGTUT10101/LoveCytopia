-- Keyed arrays allow you to index items by their keys and positions in an array
-- The array starts at 1, just like normal Lua arrays
-- Keys are used to differentiate each item inside the keyed array
-- Possible key types are "array" and "table"
local KeyedArray = {}

--- Creates a new KeyedArray object.
-- @return (table) A KeyedArray object
function KeyedArray:new ()
    -- Create a table to store the array elements
    local obj = {
        array = {}, -- Holds values that are indexed by position
        table = {}, -- Holds values that are indexed with a key
    }
    
    -- Copies the method references into the object
    for k, v in pairs (self) do
        if type(v) == "function" and k ~= "new" then
            obj[k] = v
        end
    end
    
    return obj
end

--- Inserts a new item into the keyed array.
-- It will fail if an item already exists at the given key
-- @param key (table key) The key of the new item
-- @param value (any) The value of the new item
-- @param position (int) The position of the item in the array. Defaults to the current size of the array + 1 and will fix values outside the array bounds
-- @return (bool) True if the operation was successful, otherwise false
function KeyedArray:insert (key, value, position)
    position = position or #self.array + 1
    position = math.min (math.max (position, 1), #self.array + 1)
    
    if self.table[key] == nil then
        local container = {key = key, position = position, value = value} -- Values are placed in a container to avoid duplication
        
        self.table[key] = container
        table.insert (self.array, position, container)
        return true
    else
        return false
    end
end

--- Removes an item from the keyed array.
-- @param key (table key) The key of the item
-- @return (bool) True if the value was removed successfully, otherwise false
function KeyedArray:deleteByKey (key)
    if self.table[key] ~= nil then
        local container = self.table[key]
        table.remove (self.array, container.position)
        self.table[container.key] = nil
        return true
    end
    return false
end

--- Removes an item from the keyed array.
-- @param pos (table key) The position of the item
-- @return (bool) True if the value was removed successfully, otherwise false
function KeyedArray:deleteByPos (pos)
    if self.array[pos] ~= nil then
        local container = self.array[pos]
        table.remove (self.array, container.position)
        self.table[container.key] = nil
        return true
    end
    return false
end

--- Gets the value of an item from the keyed array.
-- @param key (table key) The key of the item
-- @return (any) The value of the item or nil if it doesn't exist
function KeyedArray:getByKey (key)
    if self.table[key] == nil then
        return nil
    else
        return self.table[key].value
    end
end

--- Gets the value of an item from the keyed array.
-- @param key (table key) The position of the item
-- @return (any) The value of the item or nil if it doesn't exist
function KeyedArray:getByPos (pos)
    if self.array[pos] == nil then
        return nil
    else
        return self.array[pos].value
    end
end

--- Sets the value of an item from the keyed array.
-- @param key (table key) The key of the item
-- @param value (any) The new value of the item
-- @return (bool) True if the value was set successfully, otherwise false
function KeyedArray:setByKey (key, value)
    if self.table[key] ~= nil then
        self.table[key].value = value
        return true
    end
    
end

--- Sets the value of an item from the keyed array.
-- @param key (table key) The position of the item
-- @param value (any) The new value of the item
-- @return (bool) True if the value was set successfully, otherwise false
function KeyedArray:setByPos (pos, value)
    if self.array[pos] ~= nil then
        self.array[pos].value = value
        return true
    end
    return false
end

--- Gets the current number of items inside the object.
-- @return (int) The number of items inside the object
function KeyedArray:size ()
    return #self.array
end

--- An iterator function for the keyed array object.
-- This will iterate over the items based on their order in the array
-- @usage for pos, key, value in KeyedArrayObj:pairs () do print (value) end
-- @return (function) An iterator function
function KeyedArray:pairs ()
   local index = 0
	
   return function ()
      index = index + 1
		
      if index <= #self.array then
         return self.array[index].position, self.array[index].key, self.array[index].value
      end
   end
end

return KeyedArray