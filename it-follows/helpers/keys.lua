local M = {}

---Check if there is any key down
---@param keys table<string> - A table of keys to check
---@return boolean
function M.is_any_down(keys)
  for _, k in ipairs(keys) do
    if love.keyboard.isDown(k) then
      return true
    end
  end
  return false
end

return M
