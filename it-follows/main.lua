local game = require("game")

-- Handle input for restarting the game
function love.mousepressed(x, y, button, istouch, presses)
  game.start()
end

function love.touchpressed(id, x, y, dx, dy, pressure)
  game.start()
end

-- Initialize game
function love.load()
  love.window.setMode(0, 0, { resizable = true, fullscreen = true })

  -- scenario
  love.graphics.setBackgroundColor(1, 0.5, 0.5) -- Set background color to pink
end

-- Update game state
function love.update(dt)
  game.update(dt)
end

-- Draw game
function love.draw()
  game:draw()
end
