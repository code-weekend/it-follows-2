--- Audio Module
--- Handles BGM, sound effects and volume parametes
local Audio = {}
Audio.__index = Audio

function Audio:new()
  local instance = setmetatable({}, Audio)
  local success, bgm = pcall(love.audio.newSource, 'assets/audio/BGM1.wav', 'stream')
    if not success then
        print("Erro ao carregar bgm: " .. tostring(bgm))
    end
        instance.bgm = bgm
  -- TODO: add sound effect sources
  bgm:play()
  return instance
end

function Audio:bgmUpdate(status)
  if status == "started" then
    self.bgm:play()
    return
  end
  self.bgm:stop()
  -- TODO: handle change bgm at certain score milestones
  -- TODO: compose original music =D
end

return Audio
