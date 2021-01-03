-- Copyright (C) by fanqingxuan (Json)
-- https://github.com/fanqingxuan

local format = string.format
local print = print

local _M = {
    _VERSION = '0.01'
}


local function isWindows()
    return type(package) == 'table' and type(package.config) == 'string' and package.config:sub(1,1) == '\\'
end

local modes = {
    { name = "log",   color = "white",  font=37 },
    { name = "error", color = "red",    font=31 },
    { name = "debug", color = "cyan",   font=36 },
    { name = "info",  color = "green",  font=32 },
    { name = "warn",  color = "yellow", font=33 },
    { name = "trace", color = "blue",   font=34 },
    { name = "fatal", color = "magenta",font=35 }
}

local supported = not isWindows()

if isWindows() then supported = os.getenv("ANSICON") end

for _,val in ipairs(modes) do
    _M[val.name] = function(str)
        str = tostring(str)
        print(
            format("%s%s%s",
            supported and '\27['..val.font..'m' or '',
            str,
            supported and '\27[0m' or ''
        ))
    end
    _M[val.color] = _M[val.name]
end

_M["success"] = _M["green"]
_M["fail"] = _M["red"]

return _M
