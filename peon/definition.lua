require "globals"

return {
  Peon = class {
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
  },

  Context = class {
    __init = function(self, timestamp)
      self.timestamp = timestamp

      self.cache = {}
      self.queue = {}
    end,

    diff = function(self, peon)
      if self.cache[peon] == nil then
        self.cache[peon] = peon:sync(self)
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
}
