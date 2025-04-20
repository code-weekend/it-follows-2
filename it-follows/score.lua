--- Score Module
--- Handles the display of the game score.

local Score = {}
Score.__index = Score

function Score:new()
  local instance = setmetatable({}, Score)
  instance.startTime = love.timer.getTime()
  instance.enemyCount = 0
  return instance
end

function Score:update(enemyManager)
  -- Update the enemy count from the enemy manager
  self.enemyCount = #enemyManager.enemies
end

function Score:draw()
  -- Calculate time elapsed
  local currentTime = love.timer.getTime()
  local timeElapsed = math.floor(currentTime - self.startTime)

  -- Display score information
  love.graphics.setColor(1, 1, 1)
  love.graphics.print("Time Elapsed: " .. timeElapsed .. " seconds", 10, 10)
  love.graphics.print("Enemies Count: " .. self.enemyCount, 10, 30)
end

return Score
