utils = require "globals"


function love.load()
    
end

function love.draw()
    love.graphics.circle("fill", 300, 300, 50, 100)
end


Colour = class {
  __init = function(self, red, green, blue, alpha)
    self.red = red
    self.green = green
    self.blue = blue
    self.alpha = alpha
  end,
}

c = Colour(0.2, 0.3, 0.4, 0.5)

print(c)
