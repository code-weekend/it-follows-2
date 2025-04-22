local M = {}

local function title_decorator(str, opts)
  opts = opts or {}

  local size = opts.size or 24
  local reminder = math.max(size - #str, 0)

  return string.format("-- %s %s", str, string.rep("-", reminder))
end

function M.instructions(opts)
  opts = opts or {}

  local start_line = opts.start or 20
  local line_size = opts.line_size or 20

  -- add the instructions to the player
  love.graphics.setColor(1, 1, 1, 0.5) -- Set color to white
  love.graphics.setFont(love.graphics.newFont(12))
  love.graphics.print(title_decorator("Keybindings"), 10, start_line)
  love.graphics.print("Press 'Enter' to quit", 10, start_line + line_size * 1)
  love.graphics.print("Press 'Esc' to quit", 10, start_line + line_size * 2)
  love.graphics.print("Use arrow keys or Vim keys to move", 10, start_line + line_size * 3)

  -- Separator
  love.graphics.print(title_decorator("Gestures"), 10, start_line + line_size * 5)
  love.graphics.print("Touch and drag to move", 10, start_line + line_size * 6)
  love.graphics.print("Tap to start", 10, start_line + line_size * 7)
  love.graphics.print("'Back' to quit", 10, start_line + line_size * 8)
end

---Calculate the horizontal center position for a given text
---@param text string - The text to be centered
---@return number - The x-coordinate to start drawing the text so that it is centered
function M.center(text)
  local width = love.graphics.getFont():getWidth(text)
  return love.graphics.getWidth() / 2 - width / 2
end

local start_str = "(Tap, click or hit enter to %s)"

---Render GameOver screen
---@param game_over GameOverInfo - The game over state
function M.game_over(game_over)
  love.graphics.setColor(1, 0, 0) -- Set color to red
  love.graphics.setFont(love.graphics.newFont(24)) -- Set font size to 24
  love.graphics.print("Game Over", M.center("Game Over"), love.graphics.getHeight() / 2 - 20)

  love.graphics.setColor(1, 1, 1) -- Set color to white
  love.graphics.setFont(love.graphics.newFont(18))
  love.graphics.print(game_over.time, M.center(game_over.time), love.graphics.getHeight() / 2 + 20)
  love.graphics.print(game_over.enemies, M.center(game_over.enemies), love.graphics.getHeight() / 2 + 40)

  local restart = string.format(start_str, "restart")
  love.graphics.setFont(love.graphics.newFont(24))
  love.graphics.print(restart, M.center(restart), love.graphics.getHeight() / 2 + 80)
end

function M.start_screen()
  love.graphics.setColor(1, 1, 1) -- Set color to white

  local start = string.format(start_str, "start")
  love.graphics.print(start, M.center(start), love.graphics.getHeight() / 2)
end

return M
