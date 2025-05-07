local player = require("player")
local enemies = require("enemies")
local score = require("score")
local powerups = require("powerups")
local keys = require("helpers.keys")
local r = require("helpers.render")
local world = require("helpers.world")

local M = {}

local s
local p1
local enemies_manager
local powerups_manager

---@alias GameStatus
---| 'idle'
---| 'started'
---| 'game_over'
---
---@class GameOverInfo
---@field enemies string - Score of enemies killed
---@field time string    - Score of time survived
---
---@class GameState
---@field game_over GameOverInfo|nil - The game over state, containing time and enemies
---@field status GameStatus - The current status of the game

---@type GameState
local state = {
  game_over = nil,
  status = "idle",
}

-- Restart the game
function M.start()
  if state.status == "started" then
    return -- Prevent starting a new game if one is already in progress
  end

  state.status = "started"
  state.game_over = nil

  s = score:new()
  p1 = player:new()
  enemies_manager = enemies.EnemiesManager:new()
  powerups_manager = powerups.PowerUpsManager:new()
end

-- Start the game on mouse press or touch
local function game_over()
  if state.status == "game_over" then
    return -- Prevent starting a new game if one is already over
  end

  local t, e = s:lines()
  state.game_over = { time = t, enemies = e }
  state.status = "game_over"
end

-- Game keybindings
local function keybindings()
  -- start when hit Enter
  if keys.is_any_down({ "return", "space" }) then
    return M.start()
  end

  -- quit with esc
  if keys.is_any_down({ "escape", "q" }) then
    return love.event.quit()
  end
end

-- Update game state
function M.update(dt)
  keybindings() -- add game keybindings

  if state.status ~= "started" then
    love.mouse.setVisible(true) -- Hide mouse cursor
    return -- Skip updates if game is over
  end

  love.mouse.setVisible(false) -- Hide mouse cursor

  p1:update(dt)
  enemies_manager:update(dt) -- Update enemies with the player's position

  s:update(enemies_manager)
  powerups_manager:update(dt, p1, enemies_manager)

  if enemies_manager:check_collision(p1) then
    game_over()
  end
end

-- Draw game
local render_strategies = {
  idle = function()
    r.start_screen()
  end,
  game_over = function()
    r.game_over(state.game_over)
  end,
  started = function()
    -- Draw the grid background first for visual reference of movement
    world.draw_grid()

    love.graphics.setFont(love.graphics.newFont(18))
    enemies_manager:draw()
    powerups_manager:draw()
    p1:draw()
    s:draw()
  end,
}

function M.draw()
  r.instructions()

  love.graphics.setFont(love.graphics.newFont(24)) -- Set font size to 24

  local render = render_strategies[state.status]
  if not render then
    print("Invalid game status", state.status)
    return
  end

  -- render strategy
  render()
end

---Run a givn callback if the game is running
---@param cb function - The callback to run
function M.on_running(cb)
  if state.status == "started" then
    cb()
  end
end

function M.player()
  return p1
end

return M
