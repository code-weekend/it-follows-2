-- enemy.lua

--- Enemy Class
--- Represents an enemy in the game.
---@class Enemy
---@field pos Position - The position of the enemy.
---@field radius number - The radius of the enemy.
---@field tail Position[] - The last three positions of the enemy.

local Enemy = {}
Enemy.__index = Enemy

local MAX_SIZE = 10

function Enemy:new(x, y)
  local instance = setmetatable({}, Enemy)
  instance.pos = { x = x, y = y }
  instance.radius = math.random(3, MAX_SIZE)
  instance.tail = {}
  return instance
end

local TRAIL_SIZE = 4

function Enemy:update(playerPos)
  -- Calculate distance to player and move closer
  local dx = playerPos.x - self.pos.x
  local dy = playerPos.y - self.pos.y

  if dx ~= 0 then
    local errorX = math.random(-1, 1) -- Random error for x-axis
    self.pos.x = self.pos.x + (dx > 0 and 1 or -1) * (MAX_SIZE + 3 - self.radius) / 2 + errorX
  end
  if dy ~= 0 then
    local errorY = math.random(-1, 1) -- Random error for y-axis
    self.pos.y = self.pos.y + (dy > 0 and 1 or -1) * (MAX_SIZE + 3 - self.radius) / 2 + errorY
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
    if radius < 0 then
      radius = 0
    end

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
---@field spawnCounter number - Spawn counter for enemies.
---@field spawnTimer number - Timer to track enemy spawning.

local EnemiesManager = {}
EnemiesManager.__index = EnemiesManager

function EnemiesManager:new()
  local instance = setmetatable({}, EnemiesManager)
  instance.enemies = {}
  instance.spawnTimer = 0   -- Initialize the spawn timer
  instance.spawnCounter = 0 -- Initialize the spawn counter
  return instance
end

function EnemiesManager:addEnemy(x, y)
  table.insert(self.enemies, Enemy:new(x, y))
end

local SPAWN_TIMEOUT = 5 -- 1 each 10 second per minute

function EnemiesManager:update(playerPos, dt)
  -- Update the spawn timer
  self.spawnTimer = self.spawnTimer + dt

  local should_add_enemy =
      #self.enemies == 0 or self.spawnTimer >= SPAWN_TIMEOUT

  if should_add_enemy then
    -- Spawn a new enemy at a random position
    local x, y =
        math.random(0, love.graphics.getWidth()),
        math.random(0, love.graphics.getHeight())

    -- update the radius of all enemies
    for i = #self.enemies, 1, -1 do
      local enemy = self.enemies[i]
      enemy.radius = enemy.radius - 1

      -- Remove enemies that are too small
      if enemy.radius <= 0 then
        table.remove(self.enemies, i)
      end
    end

    self:addEnemy(x, y)
    self:addEnemy(x, love.graphics.getHeight() - y)
    self:addEnemy(love.graphics.getWidth() - x, y)
    self:addEnemy(love.graphics.getWidth() - x, love.graphics.getHeight() - y)

    self.spawnTimer = 0 -- Reset the spawn timer
    self.spawnCounter = self.spawnCounter + 4
  end

  for _, enemy in ipairs(self.enemies) do
    enemy:update(playerPos)
  end
end

---Check player collision with enemies
---@param player Player
---@return boolean
function EnemiesManager:check_collision(player)
  for _, enemy in ipairs(self.enemies) do
    local dx = player.pos.x - enemy.pos.x
    local dy = player.pos.y - enemy.pos.y
    local distance = math.sqrt(dx * dx + dy * dy)

    if distance < player.radius + enemy.radius then
      -- Collision detected
      return true
    end
  end

  return false
end

function EnemiesManager:draw()
  for _, enemy in ipairs(self.enemies) do
    enemy:draw()
  end
end

return {
  Enemy = Enemy,
  EnemiesManager = EnemiesManager
}
