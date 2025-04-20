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

  instance.pos = { x = 0, y = 0 }
  instance.radius = 30
  instance.color = { 0.96, 0.87, 0.70 }
  return instance
end

function Player:init()
  self.pos.x = love.mouse.getX()
  self.pos.y = love.mouse.getY()
  self.radius = 30
  self.color = { math.random(), math.random(), math.random() }
end

function Player:update(dt)
  self.pos.x, self.pos.y = love.mouse.getPosition()
end

function Player:draw()
  love.graphics.setColor(self.color)
  love.graphics.circle("fill", self.pos.x, self.pos.y, self.radius)
end

return Player
