--- Audio Module
--- Handles background music, sound effects and volume. Each channel holds a sound source.
Audio = {}
Audio.__index = Audio

function Audio:new()
  local o ={channel = {}, volume_levels = {}}
  setmetatable(o, self)
  return o
end

--- Play a sound.
--- @param sound string                 - Filepath for sound source (ex: assets/audio/bgm.ogg).
--- @param sourceType 'stream'|'static' - Stream for music and static for sfx.
--- @param tags table<string>           - Group channels with tags (ex: {bgm, sfx}).
--- @param volume number                - A number from 0 to 1 specifying how loud it will be played.
--- @param loop boolean                 - If true, plays the source in loop.
function Audio:play(sound, sourceType, tags, volume, loop)
end

--- Pauses a channel or tag.
--- @param channel string|number - Determines which channel (number) or tag (string) will be affected;
function Audio:pause(channel)
end

--- Resumes a channel or tag from pause.
--- @param channel string|number
function Audio:resume(channel)
end

--- Stops a channel or tag immediately or after the clip conclusion.
--- @param channel string|number
--- @param finish boolean - If true, sounds will only stop after finishing.
function Audio:stop(channel, finish)
end

--- Sets volume for channel or tag.
--- @param channel string|number
--- @param volume number 
function Audio:volume(channel, volume)
end

--- Returns current volume from channel or tag.
--- @param channel string|number 
function Audio:get_volume(channel)
end

--- Purge memory from finished sounds.
function Audio:purge()
end

return Audio
