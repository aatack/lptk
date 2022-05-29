return class {
  __init = function(self)
    self.window = nil
  end,

  ondraw = function(self)
    local x = self.window.time * 100

    while x > 300 do
      x = x - 100
    end

    self.window.camera:rectangle({x = x, y = 100}, {x = x + 200, y = 200})
  end,

  onstep = function(self, step)

  end,

  onkey = function(self, key, down)

  end,

  onclick = function(self, x, y, button, down)

  end,

  ondrag = function(self, old, new, change)

  end,

  onscroll = function(self, up)

  end,
}
