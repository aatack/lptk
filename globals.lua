local basetostring = tostring

tostring = function(value, indent)

  local indent = indent or 0
  local space = string.rep(" ", indent * 2)

  if type(value) == "table" then
    local result = "{"
    local first = true

    for k, v in pairs(value) do
      if v ~= value then
        if not first then result = result .. "," end
        result = (
            result .. "\n  " .. space .. basetostring(k) ..
                " = " .. tostring(v, indent + 1)
            )
        first = false
      end
    end
    return result .. ",\n" .. space .. "}"
  else
    return basetostring(value)
  end
end

class = function(members)
  local __init = members.__init

  if not __init then
    -- TODO: reorder this function a bit to avoid the ugly nested
    --  if statements (caused by the superclass' constructor not
    --  yet being available when we check whether the new
    --  constructor is nil)
    if members.__base and members.__base.__init then
      __init = members.__base.__init
    else
      __init = function(self, instancemembers)
        for k, v in pairs(instancemembers) do
          self[k] = v
        end
      end
    end
  end

  members.__init = __init

  members.__index = members

  local metatable = {}

  if members.__base then
    metatable.__index = members.__base
  end

  function metatable.__call(self, ...)
    local arg = { ... }

    local instance = {}
    setmetatable(instance, members)
    __init(instance, unpack(arg))

    return instance
  end

  setmetatable(members, metatable)

  return members
end
