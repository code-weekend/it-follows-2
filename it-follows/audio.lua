local Audio = {}
Audio.__index = Audio

function Audio:new()
  local instance = setmetatable({}, Audio)
  local success, bgm = pcall(love.audio.newSource, 'assets/audio/bgm.mp3', 'stream')
    if not success then
        print("Erro ao carregar bgm: " .. tostring(bgm))
        instance.bgm = nil
    else
        instance.bgm = bgm
    end
  -- TODO: add sound design sources
  bgm:play()
  return instance
end

function Audio:bgmUpdate(status)
  if status == "started" then
    self.bgm:play()
    return
  end
  self.bgm:stop()
  -- TODO: change bgm at certain score milestones
end

return Audio
