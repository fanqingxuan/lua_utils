-- Copyright (C) by fanqingxuan (Json)
-- https://github.com/fanqingxuan

local gsub = string.gsub
local sfind = string.find
local sreverse = string.reverse
local smatch = string.match
local table_insert = table.insert
local lower = string.lower
local upper = string.upper
local reverse = string.reverse
local sub = string.sub
local concat = table.concat

local _M = {
    _VERSION = '0.01'
}

-- Strip whitespace from the beginning and end of a string
function _M.trim(str, symbol)
    symbol = symbol or '%s' -- %s default match space \t \n etc..
    return (gsub(gsub(str, '^' .. symbol .. '*', ""), symbol .. '*$', ''))
end

-- Strip whitespace from the beginning of a string
function _M.ltrim(str, symbol)
    symbol = symbol or '%s' -- %s default match space \t \n etc..
    return gsub(str, '^' .. symbol .. '*', "")
end

-- Strip whitespace from the end of a string
function _M.rtrim(str, symbol)
    symbol = symbol or '%s' -- %s default match space \t \n etc..
    return gsub(str, symbol .. '*$', '')
end


-- check whether a string is start with some charactors
function _M.startswith(str, substr)
    if str == nil or substr == nil then
        return false
    end
    if sfind(str, substr) ~= 1 then
        return false
    else
        return true
    end
end

-- check whether a string is end with some charactors
function _M.endswith(str, substr)
    if str == nil or substr == nil then
        return false
    end
    local str_reverse = sreverse(str)
    local substr_reverse = sreverse(substr)
    if sfind(str_reverse, substr_reverse) ~= 1 then
        return false
    else
        return true
    end
end


-- split a string into table
function _M.split(str, delimiter)
    if not str or str == "" then return {} end
    if not delimiter or delimiter == "" then return { str } end

    local result = {}
    for match in (str .. delimiter):gmatch("(.-)" .. delimiter) do
        table_insert(result, match)
    end
    return result
end

_M.explode=_M.split

-- Checks if a value exists in a string
function _M.contains(uri, pattern)
    if not pattern then
        return false
    end

    local ok = smatch(uri, pattern)
    if ok then return true else return false end
end

-- Replace all occurrences of the search string with the replacement string
function _M.replace(str,findString,replaceString)
    return (gsub(str,findString,replaceString))
end

-- get string length
function _M.len(str)
    str = str or ''
    return #str
end

-- Make a string lowercase
function _M.lower(str)
    return lower(str)
end

-- Make a string uppercase
function _M.upper(str)
    return upper(str)
end

-- Make a string uppercase
function _M.upper(str)
    return upper(str)
end

-- Uppercase the first character of each word in a string
function _M.ucwords(str, sep)
    str = str or ''
    sep = sep or ' '
    local tab = _M.split(str,sep) 
    local result_tab = {}
    for _,val in ipairs(tab) do 
        table_insert(result_tab,_M.upper(_M.substr(val,1,1)).._M.substr(val,2))
    end

    return concat(result_tab,sep)
end

-- Make a string's first character uppercase
function _M.ucfirst(str)
    str = str or ''
    return _M.upper(_M.substr(str,1,1)).._M.substr(str,2)
end
-- Reverse a string
function _M.reverse(str)
    return reverse(str)
end

-- Return part of a string
function _M.substr(str,start_index,end_index)
    return sub(str,start_index,end_index)
end

return _M