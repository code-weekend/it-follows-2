local player = require("player")
local enemies = require("enemies")
local score = require("score")

local p1
local enemies_manager -- Declare the enemy manager
local s

local state = {
  game_over = false,
}

-- Initialize game
function love.load()
  love.mouse.setVisible(false) -- Disable mouse visibility
  love.window.setMode(0, 0, { resizable = true })

  -- scenario
  love.graphics.setBackgroundColor(1, 0.5, 0.5) -- Set background color to pink

  s = score:new()
  p1 = player:new()
  enemies_manager = enemies.EnemiesManager:new() -- Initialize the enemy manager
end

-- Update game state
function love.update(dt)
  if state.game_over then
    return -- Skip updates if game is over
  end

  p1:update(dt)
  enemies_manager:update(p1.pos, dt) -- Update enemies with the player's position
  s:update(enemies_manager)

  if enemies_manager:check_collision(p1) then
    -- Collision detected, handle game over or other logic
    state.game_over = true
    love.mouse.setVisible(true) -- Show mouse cursor on game over
  end
end

-- Draw game
function love.draw()
  if state.game_over then
    love.graphics.setColor(1, 0, 0) -- Set color to red for game over
    love.graphics.print("Game Over", love.graphics.getWidth() / 2 - 50, love.graphics.getHeight() / 2)
    return
  end

  p1:draw()
  enemies_manager:draw() -- Draw enemies
  s:draw()
end
