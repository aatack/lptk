require "globals"

return class {
  __init = function(self)
    self.position = { x= 0.0, y = 0.0}
  end,

  onstep = function(self, window, step)
    if "d" in window.heldkeys then
      self.position.x = self.poxition.x + (100 * step)
    end
  end

  ondraw = function(self, window)
    love.graphics.circle("fill", self.position.x, self.position.y, 50, 50)
  end
}
