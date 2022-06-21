require "globals"

local Context = class {
  __init = function(self, timestamp, queue)
    self.timestamp = timestamp
    self.queue = queue
    self.cache = {}
  end,

  diff = function(self, peon)
    if self.cache[peon] == nil then
      self.cache[peon] = peon:diff(self)
    end
    return self.cache[peon]
  end,

  force = function(self, peon)
    self.cache[peon] = true
    for user, count in pairs(peon.users) do
      if count and count > 0 then
        self.cache[user] = nil
        self.queue[user] = true
      end
    end
  end,
}

local Peon = class {
  __init = function(self)
    self.users = {}
  end,

  sync = function(self, timestamp)
    local context = Context(timestamp, { self = true })
  end,

  use = function(self, peon, uses)
    if uses == nil then
      uses = true
    end

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

  diff = function(self, context)
    error "`diff` is not implemented"
  end,

  horizon = function(self, lazy)
    return nil
  end,

  state = function(self)
    return nil
  end,
}

return { Peon = Peon, Context = Context }
