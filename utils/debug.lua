-- Copyright (C) by fanqingxuan (Json)
-- https://github.com/fanqingxuan

local type = type
local pairs = pairs
local print = print
local json = require("libs.dkjson")
local exit = os.exit
local stderr = io.stderr
local error = error
local unpack = unpack

local _M = {
    _VERSION = '0.01'
}

-- print a scalar value or table
function _M.print(...)

    local info = {...}

    if info and type(info[1]) == 'table' then
        print(json.encode(info,{ indent = true }))
    else
        print(unpack(info))
    end
end

-- Output a message and terminate the current script
function _M.die(value)
    if value then
        _M.print(value)
    end
   
    exit(1)
end

return _M