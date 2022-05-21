require "globals"

return class {
  -- TODO: assert that only one window is ever created

  __init = function(self, width, height)
    self.width = width or 0
    self.height = height or 0

    self.time = 0.0

    self.heldkeys = {}
    self.heldbuttons = {}

    function love.load()
      love.window.setMode(self.width, self.height, {resizable = true})
    end
    
    function love.update(step)
      self:onstep(step)
    end
    
    function love.draw()
      self:ondraw()
    end

    function love.keypressed(key)
      self:onkey(key, true)
    end

    function love.keyreleased(key)
      self:onkey(key, false)
    end

    function love.mousepressed(x, y, button)
      self:onclick(x, y, button, true)
    end

    function love.mousereleased(x, y, button)
      self:onclick(x, y, button, false)
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

  onkey = function(self, key, down)
    self.heldkeys[key] = down or nil -- Unused keys are removed
  end,

  onclick = function(self, x, y, button, down)
    self.heldbuttons[button] = down or nil -- Unused buttons are removed
  end,

  ondrag = function(self, old, new, change)

  end,
}
