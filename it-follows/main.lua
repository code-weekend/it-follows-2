local player = require("player")
local enemies = require("enemies")
local score = require("score")

local p1
local enemies_manager -- Declare the enemy manager
local s

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
  p1:update(dt)
  enemies_manager:update(p1.pos, dt) -- Update enemies with the player's position
  s:update(enemies_manager)
end

-- Draw game
function love.draw()
  p1:draw()
  enemies_manager:draw() -- Draw enemies
  s:draw()
end
