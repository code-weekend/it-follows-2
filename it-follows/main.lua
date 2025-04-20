local player = require("player")

local p1

-- Initialize game
function love.load()
  love.mouse.setVisible(false) -- Disable mouse visibility
  love.window.setMode(0, 0, { resizable = true })

  p1 = player:new()
end

-- Update game state
function love.update(dt)
  p1:update(dt)
end

-- Draw game
function love.draw()
  p1:draw()
end
