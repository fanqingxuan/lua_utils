-- Copyright (C) by fanqingxuan (Json)
-- https://github.com/fanqingxuan

local pairs = pairs
local type = type
local tostring = tostring
local remove = table.remove
local setmetatable = setmetatable
local insert = table.insert
local sort = table.sort

local _M = {
    _VERSION = '0.12'
}

-- Determine whether a variable is empty
function _M.is_empty(t)
    if t == nil or _G.next(t) == nil then
        return true
    else
        return false
    end
end

--  Return an array with elements in reverse order
function _M.reverse(orig)
    local ret = {}
    for i=1, #orig do
        ret[i] = orig[#orig - i + 1]
    end
    return ret
end

-- Removes duplicate values from an array
function _M.unique(arr)
    local hash = {}
    local res = {}
    for _,v in ipairs(arr) do
        if not hash[v] then
            hash[v] = true
            insert(res, v)
        end
    end
    return res
end

--  Join array elements with a string
function _M.implode(arr, symbol)
    local implode_str = ''
    symbol = symbol or ','
    for _, value in pairs(arr) do
        implode_str = implode_str .. value .. symbol
    end
    return string.sub(implode_str, 1, #implode_str - 1)
end

--- Deep copies a table into a new table.
function _M.copy(orig)
    local copy_table
    if type(orig) == "table" then
        copy_table = {}
        for orig_key, orig_value in next, orig, nil do
            copy_table[_M.copy(orig_key)] = _M.copy(orig_value)
        end
        setmetatable(copy_table, _M.copy(getmetatable(orig)))
    else
        copy_table = orig
    end
    return copy_table
end

-- Finds whether a variable is an array
function _M.is_array(t)
    if type(t) ~= "table" then return false end
    local i = 0
    for _ in pairs(t) do
        i = i + 1
        if t[i] == nil and t[tostring(i)] == nil then return false end
    end
    return true
end

--- Merge arrays into a new array
function _M.merge(t1, t2)
    if not t1 then
      t1 = {}
    end
    if not t2 then
      t2 = {}
    end

    local res = {}
    for k,v in pairs(t1) do res[k] = v end
    for k,v in pairs(t2) do res[k] = v end
    return res
  end

-- Checks if a value exists in a table
function _M.contains(arr, val)
    if arr then
        for _, v in pairs(arr) do
            if v == val then
                return true
            end
        end
    end
    return false
end

-- return a table containing the keys of the provided table
function _M.keys(table)
    local t = {}
	if type(table) ~= "table" then
		return t
	end

	local n = 0

	for key, _ in pairs(table) do
		n = n + 1
		t[n] = tostring(key)
	end

	return t
end

-- return a table containing the values of the provided table
function _M.values(table)
    local t = {}
	if type(table) ~= "table" then
		return t
	end

	local n = 0

	for _, value in pairs(table) do
			n = n + 1
			t[n] = value
	end

	return t
end

-- append the contents of (array-like) table b into table a
function _M.append(a, b)
	-- handle some ugliness
	local c = type(b) == 'table' and b or { b }

	local a_count = #a

	for i = 1, #c do
		a_count = a_count + 1
		a[a_count] = c[i]
	end
end

-- Push one or more elements onto the end of table
function _M.push(tab, ...)
    local idx = #tab
    local info = {...}
    for i = 1, #info do
        idx = idx + 1
        tab[idx] = info[i]
    end
end

-- Pop the element off the end of table
function _M.pop(tab)
    local idx = #tab
    remove(tab,idx)
end

-- Prepend one or more elements to the beginning of an table
function _M.unshift(tab, ...)
    local info = {...}
    for i = 1, #info do
        insert(tab,1,info[i])
    end
end

-- Shift an element off the beginning of table
function _M.shift(tab)
    remove(tab,1)
end

-- Checks if the given key or index exists in the table
function _M.key_exists(key, tab)
    if type(tab) ~= "table" then
        return false
	end

	return tab[key] ~= nil
end

-- Searches the table for a given value and returns the first corresponding key if successful
function _M.search(val,array)
    for i, v in pairs(array) do
        if v == val then
            return i
        end
    end

    return nil
end

-- Extract a slice of the table
function _M.slice(array,start_index, length)
    local sliced_array = {}
    start_index = start_index or 1
    length = length or #array
    if start_index <1 and start_index>=0 then 
        start_index = 1
    elseif start_index<0 then
        start_index = start_index + #array + 1
    end
    local end_index = math.min(start_index+length-1, #array)
    for i=start_index, end_index do
		sliced_array[#sliced_array+1] = array[i]
	end
	return sliced_array
end

-- convert array to list
function _M.to_array(tab)

    local array = {}
    if type(tab) ~= 'table' then
        return {tab}
    end
    local idx = 1
    for _,v in pairs(tab) do
        array[idx] = v
        idx = idx+1
    end

	return array
end

-- Sort an table
function _M.sort(tab,func)
    sort(tab,func)
end

-- Filters elements of an array using a callback function
function _M.filter(tab,func)

    local array = {}
    func = func or (function(i) return i end)

    for key,v in pairs(tab) do
        local ret = func(v)
        if ret then
            array[key] = v
        end
    end

    return array
end

-- Return the values from a single column in the input array
function _M.pluck(tab,column_key,index_key)

    if type(tab) ~= 'table' or (type(tab) == 'table' and (not column_key) and (not index_key)) then 
        return nil
    end

    local array = {}
    local idx = 1
    
    for key,val in pairs(tab) do
        if type(val) == 'table' then
            if index_key then
                local exists = false
                if column_key then
                    if _M.key_exists(column_key,val) then 
                        _val = val[column_key]
                        exists = true
                    end
                else 
                    exists = true
                    _val = val
                end
                if exists then
                    if _M.key_exists(index_key,val) then
                        array[val[index_key]] = _val
                    else
                        array[idx] = _val
                        idx = idx + 1
                    end 
                end
            else
                if _M.key_exists(column_key,val) then
                    array[idx] = val[column_key]
                    idx = idx + 1
                end
                
            end 
        end
    end
    
    return array
end

return _M