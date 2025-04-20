local player = require("player")
local enemies = require("enemies")
local score = require("score")

local M = {}

local s
local p1
local enemies_manager -- Declare the enemy manager

---@alias GameStatus
---| 'idle'
---| 'started'
---| 'game_over'

local state = {
  game_over = nil,
  ---@type GameStatus
  status = 'idle',
}

-- Restart the game
function M.start()
  if state.status == 'started' then
    print("Game already started")
    return -- Prevent starting a new game if one is already in progress
  end

  state.status = 'started'
  state.game_over = nil

  s = score:new()
  p1 = player:new()
  enemies_manager = enemies.EnemiesManager:new()

  love.mouse.setVisible(false)
end

-- Start the game on mouse press or touch
local function game_over()
  if state.status == 'game_over' then
    print("Game already over")
    return -- Prevent starting a new game if one is already over
  end

  local t, e = s:lines()
  state.game_over = { time = t, enemies = e }
  state.status = 'game_over'

  love.mouse.setVisible(true)
end

-- Update game state
function M.update(dt)
  if state.status ~= 'started' then
    return -- Skip updates if game is over
  end

  p1:update(dt)
  enemies_manager:update(p1.pos, dt) -- Update enemies with the player's position
  s:update(enemies_manager)

  if enemies_manager:check_collision(p1) then
    game_over()
  end
end

---Calculate the horizontal center position for a given text
---@param text string - The text to be centered
---@return number - The x-coordinate to start drawing the text so that it is centered
local function center(text)
  local width = love.graphics.getFont():getWidth(text)
  return love.graphics.getWidth() / 2 - width / 2
end

-- Draw game
local render_strategies = {
  idle = function()
    love.graphics.setColor(1, 1, 1) -- Set color to white

    local start = "(Tap or click to start)"
    love.graphics.print(start, center(start), love.graphics.getHeight() / 2)
  end,
  started = function()
    love.graphics.setFont(love.graphics.newFont(18))
    enemies_manager:draw()
    p1:draw()
    s:draw()
  end,
  game_over = function()
    love.graphics.setColor(1, 0, 0)                  -- Set color to red
    love.graphics.setFont(love.graphics.newFont(24)) -- Set font size to 24
    love.graphics.print("Game Over", center("Game Over"), love.graphics.getHeight() / 2 - 20)

    love.graphics.setColor(1, 1, 1) -- Set color to white
    love.graphics.setFont(love.graphics.newFont(18))
    love.graphics.print(state.game_over.time, center(state.game_over.time), love.graphics.getHeight() / 2 + 20)
    love.graphics.print(state.game_over.enemies, center(state.game_over.enemies), love.graphics.getHeight() / 2 + 40)

    love.graphics.setFont(love.graphics.newFont(24))
    local restart = "(Tap or click to restart)"
    love.graphics.print(restart, center(restart), love.graphics.getHeight() / 2 + 80)
  end,
}

function M.draw()
  love.graphics.setFont(love.graphics.newFont(24)) -- Set font size to 24

  local render = render_strategies[state.status]
  if not render then
    print("Invalid game status", state.status)
    return
  end

  -- render strategy
  render()
end

return M
