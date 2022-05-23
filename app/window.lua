require "globals"

return class {
  -- TODO: assert that only one window is ever created

  __init = function(self, width, height)
    self.width = width or 0
    self.height = height or 0

    self.time = 0.0

    self.heldkeys = {}
    self.heldbuttons = {}

    self.camera = require "app.camera"()

    function love.load()
      if self.width ~= 800 or self.height ~= 600 then
        love.window.setMode(self.width, self.height, {resizable = true})
      end
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

    function love.mousemoved(x, y, dx, dy)
      self:ondrag({x = x - dx, y = y - dy}, {x = x, y = y}, {x = dx, y = dy})
    end

    function love.wheelmoved(x, y)
      self:onscroll(y > 0)
    end
  end,

  ondraw = function(self)
    local x = self.time * 100

    while x > 300 do
      x = x - 100
    end

    self.camera:rectangle({x = x, y = 100}, {x = x + 200, y = 200})
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

  onscroll = function(self, up)

  end
}
