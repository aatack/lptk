function love.load()
    
end

function love.draw()
    love.graphics.circle("fill", 300, 300, 50, 100)
end


function class(members)
    local constructor = members.constructor
    members.constructor = nil

    members.__index = members

    local metatable = {}
    function metatable.__call(self, ...)
        local arg = {...}

        instance = {}
        setmetatable(instance, members)
        constructor(instance, unpack(arg))
        
        return instance
    end
    setmetatable(members, metatable)

    return members
end


Colour = class {
    constructor = function(self, red, green, blue, alpha)
        self.red = red
        self.green = green
        self.blue = blue
        self.alpha = alpha
    end,
}


_basetostring = tostring

function _tostringoverride(value)
  if type(value) == "table" then
    local result = "{"
    local first = true

    for key, value in pairs(value) do
      if not first then result = result .. ", " end
      result = result .. _basetostring(key) .. " = " .. _tostringoverride(value)
      first = false
    end
    return result .. "}"
  else
    return _basetostring(value)
  end
end

tostring = _tostringoverride


c = Colour(0.2, 0.3, 0.4, 0.5)
print(c)


Number = {}
String = {}
Boolean = {}
Table = {}

function Struct(table)

end

Point = Struct {
    x = Number,
    y = Number,
}
