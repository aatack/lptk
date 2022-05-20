local basetostring = tostring

tostring = function(value)
  if type(value) == "table" then
    local result = "{"
    local first = true

    for key, value in pairs(value) do
      if not first then result = result .. ", " end
      result = result .. basetostring(key) .. " = " .. tostring(value)
      first = false
    end
    return result .. "}"
  else
    return basetostring(value)
  end
end

class = function(members)
    local __init = members.__init
    members.__init = nil

    members.__index = members

    local metatable = {}
    function metatable.__call(self, ...)
        local arg = {...}

        instance = {}
        setmetatable(instance, members)
        __init(instance, unpack(arg))
        
        return instance
    end
    setmetatable(members, metatable)

    return members
end
