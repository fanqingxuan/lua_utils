-- Copyright (C) by fanqingxuan (Json)
-- https://github.com/fanqingxuan

local open = io.open
local popen = io.popen

local _M = {
    _VERSION = '0.11'
}

-- get contents from file
function _M.file_get_contents(path)
    local file, err = open(path, "rb")
    if file ~= nil then
        local content = file:read "*a"
        file:close()
        return content
    else
        return nil, err
    end
end

--- Write file contents.
-- @return `true` upon success, or `false` + error message on failure
function _M.file_put_contents(path, value ,mode)
    mode = mode or 'w'
    local file, err = io.open(path, mode)
    if err then
        return false, err
    end

    file:write(value)
    file:close()
    return true
end


-- Checks whether a file exists
function _M.file_exists(path)
    local f, err = open(path, "r")
    if f ~= nil then
        f:close()
        return true
    else
        return false, err
    end
end

-- Execute an external program
function _M.execute_cmd(cmd)
    local t, err = popen(cmd)
    if not t then
        return nil, "failed to execute command: "
                    .. cmd .. ", error info: " .. err
    end
    local data
    data, err = t:read("*all")
    t:close()

    if err ~= nil then
        return nil, "failed to read execution result of: "
                    .. cmd .. ", error info: " .. err
    end

    return data:gsub("^%s*(.-)%s*$", "%1")
end

return _M