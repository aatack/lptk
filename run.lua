utils = require "globals"
-- require "app.camera"
require "app.window"
require "app.entity"


-- class { __base = Window } (800, 600)


local window = Window(800, 600)
window:run(Entity())
-- Window.run(window, Entity())
