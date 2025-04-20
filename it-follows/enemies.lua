-- enemy.lua

--- Enemy Class
--- Represents an enemy in the game.
---@class Enemy
---@field pos Position - The position of the enemy.
---@field radius number - The radius of the enemy.
---@field tail Position[] - The last three positions of the enemy.

local Enemy = {}
Enemy.__index = Enemy

function Enemy:new(x, y)
  local instance = setmetatable({}, Enemy)
  instance.pos = { x = x, y = y }
  instance.radius = math.random(3, 10)
  instance.tail = {}
  return instance
end

local TRAIL_SIZE = 4

function Enemy:update(playerPos)
  -- Calculate distance to player and move closer
  local dx = playerPos.x - self.pos.x
  local dy = playerPos.y - self.pos.y

  if dx ~= 0 then
    self.pos.x = self.pos.x + (dx > 0 and 1 or -1) * self.radius / 2
  end
  if dy ~= 0 then
    self.pos.y = self.pos.y + (dy > 0 and 1 or -1) * self.radius / 2
  end

  -- Update tail
  table.insert(self.tail, 1, { x = self.pos.x, y = self.pos.y })
  if #self.tail > self.radius * TRAIL_SIZE then
    table.remove(self.tail)
  end
end

function Enemy:draw()
  -- Draw the tail
  love.graphics.setColor(1, 1, 1, 0.5)
  for idx, pos in ipairs(self.tail) do
    local radius = self.radius - 1 - (idx / TRAIL_SIZE)
    love.graphics.circle("fill", pos.x, pos.y, radius)
  end

  -- Draw the enemy
  love.graphics.setColor(1, 1, 1)
  love.graphics.circle("fill", self.pos.x, self.pos.y, self.radius)
end

--- EnemyManager Class
--- Manages all enemies in the game.
---@class EnemyManager
---@field enemies Enemy[] - List of enemies.

local EnemyManager = {}
EnemyManager.__index = EnemyManager

function EnemyManager:new()
  local instance = setmetatable({}, EnemyManager)
  instance.enemies = {}
  return instance
end

function EnemyManager:addEnemy(x, y)
  table.insert(self.enemies, Enemy:new(x, y))
end

function EnemyManager:update(playerPos)
  for _, enemy in ipairs(self.enemies) do
    enemy:update(playerPos)
  end
end

function EnemyManager:draw()
  for _, enemy in ipairs(self.enemies) do
    enemy:draw()
  end
end

return {
  Enemy = Enemy,
  EnemyManager = EnemyManager
}
