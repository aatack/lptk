require "globals"

return class {
  __init = function(self, width, height)
    self.width = width or 0
    self.height = height or 0

    self.time = 0.0

    function love.load()
      love.window.setMode(self.width, self.height, {resizable = true})
    end
    
    function love.update(step)
      self:onstep(step)
    end
    
    function love.draw()
      self:ondraw()
    end
  end,

  ondraw = function(self)
    local x = self.time * 100

    while x > 300 do
      x = x - 100
    end

    love.graphics.circle("fill", x, 300, 50, 100)
  end,

  onstep = function(self, step)
    self.time = self.time + step
  end,
}
