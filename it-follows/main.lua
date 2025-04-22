local game = require("game")

-- Handle input for restarting the game
function love.mousepressed(x, y, button, istouch, presses)
  game.start()
end

function love.touchpressed(id, x, y)
  game.start()
end

function love.touchmoved(id, x, y, dx, dy)
  local p1 = game.player()
  p1:move_with_drag_delta(dx, dy)

  love.graphics.setColor(1, 1, 1)
  -- down a line from x,y  to dx, dy
  love.graphics.line(x, y, x + dx, y + dy)
  love.graphics.circle("fill", x + dx, y + dy, 10)
  love.graphics.setColor(1, 0, 0)
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
