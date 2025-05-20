--- Audio Module
--- Handles BGM, sound effects and volume parametes

Audio = {}
Audio.channel = {} -- Currently playing sounds. each channel hols one audio source.
Audio.volume_levels = {} -- Volume levels associated with tags where channel volumes will be multiplied for.

--- Play a sound.
-- @param sound Filepath for sound source (ex: assets/audio/bgm.ogg).
-- @param sourceType "stream" or "static"; stream for music and static for sfx.
-- @param tags One or more tagas that idendify a sound. (ex: 'sfx', {"sfx, "gun"})
-- @param volume A number from 0 to 1 specifying how loud it will be played.
-- @param Plays the source in loop.
function Audio.play(sound, sourceType, tags, volume, loop)
end

--- Pauses a channel or tag.
-- @param channel Determines which channel (number) or tag (string) will be affected;
function Audio.pause(channel)
end

--- Resumes a channel or tag from pause.
function Audio.resume(channel)
end

--- Stops a channel or tag immediatelyor after the clip conclusion.
-- @param finish If true, sounds will only stop after finishing.
function Audio.stop(channel, finish)
end


--- Sets volume for channel or tag.
function Audio.volume(channel, volume)
end

--- Returns current volume from channel or tag.
function Audio.get_volume(channel)
end

--- Purge memory from finished sounds.
function Audio.purge()
end
