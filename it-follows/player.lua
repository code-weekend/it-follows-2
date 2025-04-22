--- Player Closs
--- This is a class that represents the player in the game.
---
---@class Player
---@field pos Position - The position of the player.
---@field color Color - The color of the player in RGB.
---@field radius number - The radius of the player.
---@field speed number - The radius of the player.
---@field drag_position Position|nil - The direction of the player.
---@field pressed_position Position|nil - The direction of the player.
---
---@class Position
---@field x number - The x coordinate of the position.
---@field y number - The y coordinate of the position.
---
---@class Color - The color of the player in RGB

local Player = {}
Player.__index = Player

local keys = require("helpers.keys")

function Player:new()
  ---@type Player
  local instance = setmetatable({}, Player)

  instance.pos = {
    x = love.graphics.getWidth() / 2,
    y = love.graphics.getHeight() / 2,
  }
  instance.radius = 20
  instance.speed = 1000
  instance.pressed_position = { x = 0, y = 0 }
  instance.color = { 0.96, 0.87, 0.70 }

  return instance
end

---Set Desktop Movements
---@param p Player - The player instance
---@param dt number - The delta time
local function keybindings(p, dt)
  if keys.is_any_down({ "right", "l" }) then
    p.pos.x = p.pos.x + p.speed * dt
  elseif keys.is_any_down({ "left", "h" }) then
    p.pos.x = p.pos.x - p.speed * dt
  end

  if keys.is_any_down({ "down", "j" }) then
    p.pos.y = p.pos.y + p.speed * dt
  elseif keys.is_any_down({ "up", "k" }) then
    p.pos.y = p.pos.y - p.speed * dt
  end

  -- limit moving player to the screen
  if p.pos.x < p.radius then
    p.pos.x = p.radius
  elseif p.pos.x > love.graphics.getWidth() - p.radius then
    p.pos.x = love.graphics.getWidth() - p.radius
  end

  if p.pos.y < p.radius then
    p.pos.y = p.radius
  elseif p.pos.y > love.graphics.getHeight() - p.radius then
    p.pos.y = love.graphics.getHeight() - p.radius
  end
end

local MAX_MAGNITUDE = 100

---Set Mobile Movements
---@param p Player - The player instance
---@param dt number - The delta time
local function gestures(p, dt)
  local drag_position = p.drag_position
  if not drag_position then
    return -- skip not moving
  end

  local start_x = drag_position.x
  local start_y = drag_position.y

  local dir = p.pressed_position
  if not dir then
    return -- skip not moving
  end

  local end_x = dir.x
  local end_y = dir.y

  local dx = end_x - start_x
  local dy = end_y - start_y

  -- use distance to calculate the movement vector magnitude

  if dx ~= 0 or dy ~= 0 then
    local magnitude = math.sqrt(dx * dx + dy * dy)
    local sin_theta = dy / magnitude
    local cos_theta = dx / magnitude

    local modified_speed = p.speed * (math.min(magnitude, MAX_MAGNITUDE) / MAX_MAGNITUDE) -- Adjust speed based on distance

    p.pos.x = p.pos.x + cos_theta * modified_speed * dt
    p.pos.y = p.pos.y + sin_theta * modified_speed * dt
  end

  -- limit moving player to the screen
  if p.pos.x < p.radius then
    p.pos.x = p.radius
  elseif p.pos.x > love.graphics.getWidth() - p.radius then
    p.pos.x = love.graphics.getWidth() - p.radius
  end

  if p.pos.y < p.radius then
    p.pos.y = p.radius
  elseif p.pos.y > love.graphics.getHeight() - p.radius then
    p.pos.y = love.graphics.getHeight() - p.radius
  end
end

function Player:update(dt)
  -- if desktop, use arrow keys and vim keybindings
  gestures(self, dt)
  keybindings(self, dt)
end

function Player:draw()
  love.graphics.setColor(self.color)
  love.graphics.circle("fill", self.pos.x, self.pos.y, self.radius)

  -- Draw the movement vector line
  if self.pressed_position and self.drag_position then
    -- Draw the outer circle at the drag position
    love.graphics.setColor(0.83, 0.69, 0.22, 0.8) -- Set color to gold white for the outer circle
    love.graphics.circle("line", self.drag_position.x, self.drag_position.y, 40)

    -- Draw the inner circle at the end position
    love.graphics.setColor(0.96, 0.87, 0.70, 0.5) -- Set color to transparent yellow like beige for the inner circle
    love.graphics.circle("fill", self.pressed_position.x, self.pressed_position.y, 10)
  end
end

return Player
