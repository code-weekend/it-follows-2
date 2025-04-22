local game = require("game")

-- Handle input for restarting the game
function love.mousepressed(x, y, button, istouch, presses)
  game.start()
end

function love.touchpressed(id, x, y)
  game.start()

  game.on_running(function()
    local p1 = game.player()
    p1.drag_position = { x = x, y = y }
  end)
end

function love.touchreleased(id, x, y)
  local p1 = game.player()
  p1.pressed_position = nil
end

function love.touchmoved(id, x, y, dx, dy)
  local p1 = game.player()
  p1.pressed_position = { x = x + dx, y = y + dy }
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
