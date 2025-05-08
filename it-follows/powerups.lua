local world = require("helpers.world")

---@alias PowerUpKind
---| 'killall'

---@class PowerUp
---@field pos Position
---@field radius number
---@field kind PowerUpKind
---@field color table

local PowerUp = {}
PowerUp.__index = PowerUp

---@param x number
---@param y number
---@param kind PowerUpKind
---@return PowerUp
function PowerUp:new(x, y, kind)
  ---@type PowerUp
  local instance = setmetatable({}, PowerUp)

  instance.pos = { x = x, y = y }
  instance.kind = kind
  instance.radius = 10

  if kind == "killall" then
    instance.color = { 0, 0.8, 1 }
  end

  return instance
end

function PowerUp:draw()
  local screen_x, screen_y = world.to_screen(self.pos.x, self.pos.y)
  love.graphics.setColor(self.color)
  love.graphics.circle("fill", screen_x, screen_y, self.radius)
  love.graphics.setColor(1, 1, 1, 0.8)

  if self.kind == "killall" then
    love.graphics.line(
      screen_x - self.radius * 0.6,
      screen_y - self.radius * 0.6,
      screen_x + self.radius * 0.6,
      screen_y + self.radius * 0.6
    )
    love.graphics.line(
      screen_x - self.radius * 0.6,
      screen_y + self.radius * 0.6,
      screen_x + self.radius * 0.6,
      screen_y - self.radius * 0.6
    )
  end
  love.graphics.setColor(self.color[1], self.color[2], self.color[3], 0.3)
  love.graphics.circle("fill", screen_x, screen_y, self.radius * 1.3)
end

---@class SpawnTimer
---@field killall number

---@class PowerUpsManager
---@field powerups PowerUp[]
---@field spawn_timers SpawnTimer

local PowerUpsManager = {}
PowerUpsManager.__index = PowerUpsManager

---@return PowerUpsManager
function PowerUpsManager:new()
  ---@type PowerUpsManager
  local instance = setmetatable({}, PowerUpsManager)
  instance.powerups = {}
  instance.spawn_timers = {
    killall = 0,
  }
  return instance
end

---@param x number
---@param y number
---@param kind PowerUpKind
function PowerUpsManager:add_power_up(x, y, kind)
  table.insert(self.powerups, PowerUp:new(x, y, kind))
end

function PowerUpsManager:update(dt, player, enemies_manager)
  self.spawn_timers.killall = self.spawn_timers.killall + dt

  -- setup add a killall power on each 5s
  if self.spawn_timers.killall >= 5 then
    local x, y = world.random_edge_position()
    self:add_power_up(x, y, "killall")
    self.spawn_timers.killall = 0
  end

  for i = #self.powerups, 1, -1 do
    local powerup = self.powerups[i]

    local dx = world.player_pos.x - powerup.pos.x
    local dy = world.player_pos.y - powerup.pos.y
    local distance = math.sqrt(dx * dx + dy * dy)

    if distance < player.radius + powerup.radius then
      if powerup.kind == "killall" then
        -- Kill all enemies
        for i = #enemies_manager.enemies, 1, -1 do
          table.remove(enemies_manager.enemies, i)
        end
      end

      table.remove(self.powerups, i)
    end
  end
end

function PowerUpsManager:draw()
  for _, powerup in ipairs(self.powerups) do
    powerup:draw()
  end
end

return {
  PowerUp = PowerUp,
  PowerUpsManager = PowerUpsManager,
}
