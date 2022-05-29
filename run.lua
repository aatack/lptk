require "globals"

local Window = require "app.window"
local Player = require "entities.player"


Window(800, 600):run(Player())
