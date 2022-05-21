require "globals"

return class {
  __init = function(self) end,

  circle = function(self, centre, radius, segments)
    segments = segments or 50
    love.graphics.circle("fill", centre.x, centre.y, radius, segments)
  end,
}
