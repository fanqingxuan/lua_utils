--
-- classic
--
-- Copyright (c) 2014, rxi
--
-- This module is free software; you can redistribute it and/or modify it under
-- the terms of the MIT license. See LICENSE for details.
-- https://github.com/rxi/classic/blob/master/classic.lua

--[[
    # Classic

A tiny class module for Lua. Attempts to stay simple and provide decent
performance by avoiding unnecessary over-abstraction.


## Usage

The [module](classic.lua) should be dropped in to an existing project and
required by it:

```lua
Object = require "classic"
```

The module returns the object base class which can be extended to create any
additional classes.


### Creating a new class
```lua
Point = Object:extend()

function Point:new(x, y)
  self.x = x or 0
  self.y = y or 0
end
```

### Creating a new object
```lua
local p = Point(10, 20)
```

### Extending an existing class
```lua
Rect = Point:extend()

function Rect:new(x, y, width, height)
  Rect.super.new(self, x, y)
  self.width = width or 0
  self.height = height or 0
end
```

### Checking an object's type
```lua
local p = Point(10, 20)
print(p:is(Object)) -- true
print(p:is(Point)) -- true
print(p:is(Rect)) -- false 
```

### Using mixins
```lua
PairPrinter = Object:extend()

function PairPrinter:printPairs()
  for k, v in pairs(self) do
    print(k, v)
  end
end


Point = Object:extend()
Point:implement(PairPrinter)

function Point:new(x, y)
  self.x = x or 0
  self.y = y or 0
end


local p = Point()
p:printPairs()
```

### Using static variables
```lua
Point = Object:extend()
Point.scale = 2

function Point:new(x, y)
  self.x = x or 0
  self.y = y or 0
end

function Point:getScaled()
  return self.x * Point.scale, self.y * Point.scale
end
```

### Creating a metamethod
```lua
function Point:__tostring()
  return self.x .. ", " .. self.y
end
```


## License

This module is free software; you can redistribute it and/or modify it under
the terms of the MIT license. See [LICENSE](LICENSE) for details.

]]

local Object = {}
Object.__index = Object


function Object:new()
end


function Object:extend()
  local cls = {}
  for k, v in pairs(self) do
    if k:find("__") == 1 then
      cls[k] = v
    end
  end
  cls.__index = cls
  cls.super = self
  setmetatable(cls, self)
  return cls
end


function Object:implement(...)
  for _, cls in pairs({...}) do
    for k, v in pairs(cls) do
      if self[k] == nil and type(v) == "function" then
        self[k] = v
      end
    end
  end
end


function Object:is(T)
  local mt = getmetatable(self)
  while mt do
    if mt == T then
      return true
    end
    mt = getmetatable(mt)
  end
  return false
end


function Object:__tostring()
  return "Object"
end


function Object:__call(...)
  local obj = setmetatable({}, self)
  obj:new(...)
  return obj
end


return Object