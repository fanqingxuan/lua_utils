-- Copyright (C) by fanqingxuan (Json)
-- https://github.com/fanqingxuan

local type = type
local pairs = pairs
local print = print
local json = require("libs.dkjson")
local exit = os.exit
local stderr = io.stderr
local error = error

local _M = {
    _VERSION = '0.01'
}

-- print a scalar value or table
function _M.print(value)
    if value and type(value) == 'table' then
        print(json.encode(value,{ indent = true }))
    else
        print(value)
    end
end

-- Output a message and terminate the current script
function _M.die(value)
    if value then
        _M.print(value)
    end
   
    exit(1)
end

function _M.isWindows()
    return type(package) == 'table' and type(package.config) == 'string' and package.config:sub(1,1) == '\\'
end

return _M