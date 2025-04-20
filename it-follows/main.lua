local player = require("player")
local enemies = require("enemies") -- Import the enemies module

local p1
local enemyManager -- Declare the enemy manager

-- Initialize game
function love.load()
  love.mouse.setVisible(false) -- Disable mouse visibility
  love.window.setMode(0, 0, { resizable = true })

  -- scenario
  love.graphics.setBackgroundColor(1, 0.5, 0.5) -- Set background color to pink

  p1 = player:new()
  enemyManager = enemies.EnemyManager:new() -- Initialize the enemy manager
end

-- Update game state
function love.update(dt)
  p1:update(dt)
  enemyManager:update(p1.pos, dt) -- Update enemies with the player's position
end

-- Draw game
function love.draw()
  p1:draw()
  enemyManager:draw() -- Draw enemies
end
