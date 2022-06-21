local Entity = require "app.entity"

return class {
  BASESPEED = 400.0,
  BOOSTSPEED = 600.0,
  BOOSTSLOW = 2500.0,

  __base = Entity,

  __init = function(self)
    self.__base.__init(self)

    self.position = { x = 0.0, y = 0.0 }
    self.size = 10
    self.speed = self.BASESPEED

    self.joystick = love.joystick.getJoysticks()[1]

    self.resetvibrations = 0.0
  end,

  onstep = function(self, step)
    if self.speed > self.BASESPEED then
      self.speed = self.speed - self.BOOSTSLOW * step
    end
    if self.speed < self.BASESPEED then
      self.speed = self.BASESPEED
    end

    local inputs = { self.joystick:getAxes() }

    if inputs[6] > 0 then -- Right trigger
      self:onkey("space", true)
    end

    local movement = { x = inputs[1], y = inputs[2] }
    -- TODO: calculate the direction first
    if self.window.heldkeys["w"] then
      movement.y = movement.y - 1
    end
    if self.window.heldkeys["a"] then
      movement.x = movement.x - 1
    end
    if self.window.heldkeys["s"] then
      movement.y = movement.y + 1
    end
    if self.window.heldkeys["d"] then
      movement.x = movement.x + 1
    end

    if movement.x ~= 0 and movement.y ~= 0 then
      local factor = math.sqrt(2)
      movement.x = movement.x / factor
      movement.y = movement.y / factor
    end

    local change = self.speed * step
    if math.abs(movement.x) > 0.3 then
      self.position.x = self.position.x + (movement.x * change)
    end
    if math.abs(movement.y) > 0.3 then
      self.position.y = self.position.y + (movement.y * change)
    end

    if self.resetvibrations > 0.0 then
      self.resetvibrations = self.resetvibrations - step
      if self.resetvibrations <= 0.0 then
        self.joystick:setVibration(0.0, 0.0)
      end
    end
  end,

  onkey = function(self, key, down)
    if down and key == "space" and self.speed <= self.BASESPEED then
      self.joystick:setVibration(0.4, 0.4)
      self.resetvibrations = 0.3
      self.speed = self.speed + self.BOOSTSPEED
    end
  end,

  ondraw = function(self)
    love.graphics.circle("fill", self.position.x, self.position.y, self.size, self.size * 2)
  end,
}
