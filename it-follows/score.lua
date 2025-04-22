--- Score Module
--- Handles the display of the game score.
local r = require("helpers.render")

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
  self.enemyCount = enemyManager.spawnCounter
end

function Score:draw()
  -- Calculate time elapsed
  -- Display score information
  love.graphics.setColor(1, 1, 1)

  local time, enemies = self:lines()

  love.graphics.setColor(1, 1, 1, 0.7) -- Set color to white
  love.graphics.setFont(love.graphics.newFont(18))
  love.graphics.print(time, r.center(time), love.graphics.getHeight() / 2 + 20)
  love.graphics.print(enemies, r.center(enemies), love.graphics.getHeight() / 2 + 40)
end

function Score:lines()
  local currentTime = love.timer.getTime()
  local time_elapsed = math.floor(currentTime - self.startTime)

  -- Return the number of lines to be displayed
  return "Time Elapsed: " .. time_elapsed .. " seconds", "Enemies Count: " .. self.enemyCount
end

function Score:reset()
  -- Reset the score
  self.startTime = love.timer.getTime()
  self.enemyCount = 0
end

return Score
