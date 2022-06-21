require "globals"

return class {
  __init = function(self)
    self.users = {}
  end,

  use = function(self, peon, uses)
    if uses then
      if not peon.users[self] then
        peon.users[self] = 0
      end
      peon.users[self] = peon.users[self] + 1
    else
      peon.users[self] = peon.users[self] - 1
      if peon.users[self] <= 0 then
        peon.users[self] = 0
      end
    end
  end,

  sync = function(self, context)
    error "`sync` is not implemented"
  end,

  horizon = function(self, lazy)
    return nil
  end,

  state = function(self)
    return nil
  end
}
