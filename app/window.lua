local Camera = require "app.camera"

return class {
  -- TODO: assert that only one window is ever created

  __init = function(self, width, height)
    self.width = width or 800
    self.height = height or 600

    self.time = 0.0

    self.heldkeys = {}
    self.heldbuttons = {}

    self.camera = Camera()
    
    function love.load()
      if self.width ~= 800 or self.height ~= 600 then
        love.window.setMode(self.width, self.height, {resizable = true})
      end
    end
  end,

  run = function(self, entity)
    entity.window = self

    function love.update(step)
      self.time = self.time + step
      entity:onstep(step)
    end
    
    function love.draw()
      entity:ondraw()
    end

    function love.keypressed(key)
      self.heldkeys[key] = true
      entity:onkey(key, true)
    end

    function love.keyreleased(key)
      self.heldkeys[key] = nil
      entity:onkey(key, false)
    end

    function love.mousepressed(x, y, button)
      self.heldbuttons[button] = true
      entity:onclick(x, y, button, true)
    end

    function love.mousereleased(x, y, button)
      self.heldbuttons[button] = nil
      entity:onclick(x, y, button, false)
    end

    function love.mousemoved(x, y, dx, dy)
      entity:ondrag({x = x - dx, y = y - dy}, {x = x, y = y}, {x = dx, y = dy})
    end

    function love.wheelmoved(x, y)
      entity:onscroll(y > 0)
    end
  end,
}
