require "globals"

return class {
  __init = function(self) end,

  circle = function(self, centre, radius, segments)
    segments = segments or 50
    love.graphics.circle("fill", centre.x, centre.y, radius, segments)
  end,

  rectangle = function(self, top_left, bottom_right)
    love.graphics.rectangle(
      "fill",
      top_left.x,
      top_left.y,
      bottom_right.x - top_left.x,
      bottom_right.y - top_left.y
    )
  end,
}
