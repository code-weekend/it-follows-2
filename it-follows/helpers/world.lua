local M = {}

M.player_pos = { x = 0, y = 0 }
local movement = { x = 0, y = 0, magnitude = 0 }

function M.to_screen(x, y)
  local screen_center_x = love.graphics.getWidth() / 2
  local screen_center_y = love.graphics.getHeight() / 2
  local rel_x = x - M.player_pos.x
  local rel_y = y - M.player_pos.y
  return screen_center_x + rel_x, screen_center_y + rel_y
end

function M.to_world(screen_x, screen_y)
  local screen_center_x = love.graphics.getWidth() / 2
  local screen_center_y = love.graphics.getHeight() / 2
  local rel_x = screen_x - screen_center_x
  local rel_y = screen_y - screen_center_y
  return M.player_pos.x + rel_x, M.player_pos.y + rel_y
end

function M.move_player(dx, dy)
  M.player_pos.x = M.player_pos.x + dx
  M.player_pos.y = M.player_pos.y + dy
  movement.x = dx
  movement.y = dy
  movement.magnitude = math.sqrt(dx * dx + dy * dy)
end

function M.get_movement_direction()
  return movement
end

function M.random_edge_position()
  local width = love.graphics.getWidth()
  local height = love.graphics.getHeight()
  local edge = math.floor(math.random(0, 3))
  local screen_x, screen_y
  if edge == 0 then
    screen_x = math.random(0, width)
    screen_y = 0
  elseif edge == 1 then
    screen_x = width
    screen_y = math.random(0, height)
  elseif edge == 2 then
    screen_x = math.random(0, width)
    screen_y = height
  else
    screen_x = 0
    screen_y = math.random(0, height)
  end
  return M.to_world(screen_x, screen_y)
end

function M.draw_grid()
  local grid_size = 100
  local grid_count = 20
  love.graphics.setColor(0.2, 0.2, 0.2)
  local start_x = M.player_pos.x - (grid_count * grid_size / 2)
  local start_y = M.player_pos.y - (grid_count * grid_size / 2)
  start_x = math.floor(start_x / grid_size) * grid_size
  start_y = math.floor(start_y / grid_size) * grid_size
  for i = 0, grid_count do
    local x = start_x + (i * grid_size)
    local screen_x, _ = M.to_screen(x, 0)
    love.graphics.line(screen_x, 0, screen_x, love.graphics.getHeight())
  end
  for i = 0, grid_count do
    local y = start_y + (i * grid_size)
    local _, screen_y = M.to_screen(0, y)
    love.graphics.line(0, screen_y, love.graphics.getWidth(), screen_y)
  end
end

return M
