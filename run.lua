utils = require "globals"
Window = require "app.window"


local Subclass = class {
  __base = Window,
}

Subclass(800, 600)
