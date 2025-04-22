--- Player Closs
--- This is a class that represents the player in the game.
---
---@class Player
---@field pos Position - The position of the player.
---@field color Color - The color of the player in RGB.
---@field radius number - The radius of the player.
---@field speed number - The radius of the player.
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
  instance.color = { 0.96, 0.87, 0.70 }

  return instance
end

---Set Desktop Movements
---@param p Player - The player instance
---@param dt number - The delta time
local function desktop_movements(p, dt)
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

local function is_mobile()
  local os = love.system.getOS()
  return os == "Android" or os == "iOS"
end

function Player:update(dt)
  -- if desktop, use arrow keys and vim keybindings
  if is_mobile() then
    mobile_movements(self, dt)
    return
  end

  desktop_movements(self, dt)
end

---Mobile Movements
---@param dx number - The delta x
---@param dy number - The delta y
function Player:move_with_drag_delta(dx, dy)
  self.pos.x = self.pos.x + dx
  self.pos.y = self.pos.y + dy

  -- limit moving player to the screen
  if self.pos.x < self.radius then
    self.pos.x = self.radius
  elseif self.pos.x > love.graphics.getWidth() - self.radius then
    self.pos.x = love.graphics.getWidth() - self.radius
  end

  if self.pos.y < self.radius then
    self.pos.y = self.radius
  elseif self.pos.y > love.graphics.getHeight() - self.radius then
    self.pos.y = love.graphics.getHeight() - self.radius
  end
end

function Player:draw()
  love.graphics.setColor(self.color)
  love.graphics.circle("fill", self.pos.x, self.pos.y, self.radius)

  if is_mobile() then
    love.graphics.setColor(1, 1, 1, 0.5) -- Set color to white
    love.graphics.setFont(love.graphics.newFont(12))
    love.graphics.print("Touch and drag to move", 10, 50)
    love.graphics.print("Tap to start", 10, 70)
    love.graphics.print("'Back' to quit", 10, 90)
    return
  end

  -- add the instructions to the player
  love.graphics.setColor(1, 1, 1, 0.5) -- Set color to white
  love.graphics.setFont(love.graphics.newFont(12))
  love.graphics.print("Press 'enter' to quit", 10, 50)
  love.graphics.print("Press 'esc' to quit", 10, 70)
  love.graphics.print("Use arrow keys or vim keys to move", 10, 90)
end

return Player
