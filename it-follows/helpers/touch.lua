local M = {
  touches = {},
}

function M.init(on_press)
  function love.touchpressed(id, x, y)
    M.touches[id] = { x, y }

    if on_press then
      on_press(id, x, y)
    end
  end

  function love.touchmoved(id, x, y)
    M.touches[id][1] = x
    M.touches[id][2] = y

    -- display touch coordinates
    print("Touch ID: " .. id .. " - X: " .. x .. " Y: " .. y)
  end

  function love.touchreleased(id, x, y)
    -- display touch coordinates
    print("Touch ID: " .. id .. " - X: " .. x .. " Y: " .. y)
    M.touches[id] = nil
  end
end

return M
