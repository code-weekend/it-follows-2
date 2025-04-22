--- Player Closs
--- This is a class that represents the player in the game.
---
---@class Player
---@field pos Position - The position of the player.
---@field color Color - The color of the player in RGB.
---@field radius number - The radius of the player.
---
---@class Position
---@field x number - The x coordinate of the position.
---@field y number - The y coordinate of the position.
---
---@class Color - The color of the player in RGB

local Player = {}
Player.__index = Player

function Player:new()
  ---@type Player
  local instance = setmetatable({}, Player)

  instance.pos = {
    x = love.graphics.getWidth() / 2,
    y = love.graphics.getHeight() / 2,
  }
  instance.radius = 20
  instance.color = { 0.96, 0.87, 0.70 }

  return instance
end

---Check if there is any key down
---@param keys string[]
---@return boolean
local function is_any_down(keys)
  for _, k in ipairs(keys) do
    if love.keyboard.isDown(k) then
      return true
    end
  end
  return false
end

function Player:update(dt)
  local speed = 1000 -- Speed of the player

  -- moving player with arrow keys and vim keybindings
  if is_any_down({ "right", "l" }) then
    self.pos.x = self.pos.x + speed * dt
  elseif is_any_down({ "left", "h" }) then
    self.pos.x = self.pos.x - speed * dt
  end

  if is_any_down({ "down", "j" }) then
    self.pos.y = self.pos.y + speed * dt
  elseif is_any_down({ "up", "k" }) then
    self.pos.y = self.pos.y - speed * dt
  end

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
end

return Player
