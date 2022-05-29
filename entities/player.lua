local Entity = require "app.entity"

return class {
  __base = Entity,

  __init = function(self)
    self.__base.__init(self)

    self.position = { x = 0.0, y = 0.0 }
    self.size = 10
    self.speed = 100
  end,

  onstep = function(self, step)
    -- TODO: calculate the direction first
    if self.window.heldkeys["w"] then
      self.position.y = self.position.y - (self.speed * step)
    end
    if self.window.heldkeys["a"] then
      self.position.x = self.position.x - (self.speed * step)
    end
    if self.window.heldkeys["s"] then
      self.position.y = self.position.y + (self.speed * step)
    end
    if self.window.heldkeys["d"] then
      self.position.x = self.position.x + (self.speed * step)
    end
  end,

  ondraw = function(self)
    love.graphics.circle("fill", self.position.x, self.position.y, self.size, self.size * 2)
  end,
}
