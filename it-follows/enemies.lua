-- enemy.lua
local world = require("helpers.world")

--- Enemy Class
--- Represents an enemy in the game.
---@class Enemy
---@field pos Position - The position of the enemy.
---@field radius number - The radius of the enemy.
---@field velocity number - The normalizer for the enemy's velocity.
---@field tail Position[] - The last three positions of the enemy.

local Enemy = {}
Enemy.__index = Enemy

local MIN_VEL = 1
local MIN_SIZE = 5
local MAX_SIZE = 10

function Enemy:new(x, y)
  local instance = setmetatable({}, Enemy)

  instance.pos = { x = x, y = y }
  instance.radius = math.random(MIN_SIZE, MAX_SIZE)
  instance.velocity = 0.5
  instance.tail = {}

  return instance
end

local TRAIL_SIZE = 4

function Enemy:update(playerPos)
  -- Calculate distance to player and move closer
  local dx = playerPos.x - self.pos.x
  local dy = playerPos.y - self.pos.y

  local distance = math.sqrt(dx * dx + dy * dy)
  local sin = dy / distance
  local cos = dx / distance

  local movement_mod = MAX_SIZE - self.radius + MIN_VEL

  if dx ~= 0 then
    local moduleX = movement_mod * cos
    local error = math.random(-1, 1) * moduleX / 2
    moduleX = moduleX - error
    self.pos.x = self.pos.x + moduleX * self.velocity
  end

  if dy ~= 0 then
    local moduleY = movement_mod * sin
    local error = math.random(-1, 1) * moduleY / 2
    moduleY = moduleY - error
    self.pos.y = self.pos.y + moduleY * self.velocity
  end

  -- Update tail
  table.insert(self.tail, 1, { x = self.pos.x, y = self.pos.y })
  if #self.tail > self.radius * TRAIL_SIZE then
    table.remove(self.tail)
  end
end

function Enemy:draw()
  -- Convert world coordinates to screen coordinates for drawing
  local screen_x, screen_y = world.to_screen(self.pos.x, self.pos.y)

  -- Draw the tail
  love.graphics.setColor(1, 1, 1, 0.5)
  for idx, pos in ipairs(self.tail) do
    local tail_x, tail_y = world.to_screen(pos.x, pos.y)
    local radius = self.radius - 1 - (idx / TRAIL_SIZE)
    if radius < 0 then
      radius = 0
    end

    love.graphics.circle("fill", tail_x, tail_y, radius)
  end

  -- Draw the enemy
  love.graphics.setColor(1, 1, 1)
  love.graphics.circle("fill", screen_x, screen_y, self.radius)
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

local SPAWN_TIMEOUT = 1 -- 1 each 10 second per minute

function EnemiesManager:update(playerPos, dt)
  -- Update the spawn timer
  self.spawnTimer = self.spawnTimer + dt

  local should_add_enemy = #self.enemies == 0 or self.spawnTimer >= SPAWN_TIMEOUT

  if should_add_enemy then
    -- update the radius of all enemies
    for i = #self.enemies, 1, -1 do
      -- reverse loop to avoid index issues
      local enemy = self.enemies[i]

      enemy.radius = math.max(enemy.radius - 1, MIN_SIZE)
      enemy.velocity = enemy.velocity + 0.01 -- accelerate enemies
    end

    -- add new enemies
    local enemies_to_add = math.random(3, 5)
    for i = 1, enemies_to_add do
      -- Spawn enemies at the border of the visible screen
      local x, y = world.random_edge_position()
      self:addEnemy(x, y)
    end

    self.spawnTimer = 0 -- Reset the spawn timer
    self.spawnCounter = self.spawnCounter + enemies_to_add
  end

  for _, enemy in ipairs(self.enemies) do
    enemy:update(world.player_pos)
  end
end

---Check player collision with enemies
---@param player Player
---@return boolean
function EnemiesManager:check_collision(player)
  for _, enemy in ipairs(self.enemies) do
    local dx = world.player_pos.x - enemy.pos.x
    local dy = world.player_pos.y - enemy.pos.y
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
  EnemiesManager = EnemiesManager,
}
