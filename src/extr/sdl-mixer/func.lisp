(in-package :sdl3-mixer)

(cffi:defcfun ("Mix_Version" version) :int)

(cffi:defcfun ("Mix_Init" init) init-flags
  (flags init-flags))

(cffi:defcfun ("Mix_Quit" quit) :void)

(cffi:defcfun ("Mix_OpenAudio" open-audio) :bool 
  (devid sdl3::audio-device-id)
  (spec (:pointer (:struct sdl3::audio-spec))))

(cffi:defcfun ("Mix_PauseAudio" pause-audio) :void 
  (pause_on :int))

(cffi:defcfun ("Mix_QuerySpec" query-spec) :bool 
  (frequency (:pointer :int))
  (format (:pointer sdl3::audio-format))
  (channels (:pointer :int)))

(cffi:defcfun ("Mix_AllocateChannels" allocate-channels) :int 
  (numchans :int))

(cffi:defcfun ("Mix_LoadWAV_IO" load-wav-io) (:pointer (:struct chunk)) 
  (src :pointer)
  (closeio :bool))

(cffi:defcfun ("Mix_LoadWAV" load-wav) (:pointer (:struct chunk)) 
  (file :string))

(cffi:defcfun ("Mix_LoadMUS" load-mus) :pointer
  (file :string))

(cffi:defcfun ("Mix_LoadMUS_IO" load-mus-io) :pointer
  (src :pointer)
  (closeio :bool))

(cffi:defcfun ("Mix_LoadMUSType_IO" load-mus-type-io) :pointer
  (src :pointer)
  (type music-type)
  (closeio :bool))

(cffi:defcfun ("Mix_QuickLoad_WAV" quick-load-wav) (:pointer (:struct chunk)) 
  (mem (:pointer :uint8)))

(cffi:defcfun ("Mix_QuickLoad_RAW" quick-load-raw) (:pointer (:struct chunk)) 
  (mem (:pointer :uint8))
  (len :uint32))

(cffi:defcfun ("Mix_FreeChunk" free-chunk) :void 
  (chunk (:pointer (:struct chunk))))

(cffi:defcfun ("Mix_FreeMusic" free-music) :void 
  (music :pointer))

(cffi:defcfun ("Mix_GetNumChunkDecoders" get-num-chunk-decoders) :int)

(cffi:defcfun ("Mix_GetChunkDecoder" get-chunk-decoder) :string 
  (index :int))

(cffi:defcfun ("Mix_HasChunkDecoder" has-chunk-decoder) :bool 
  (name :string))

(cffi:defcfun ("Mix_GetNumMusicDecoders" get-num-music-decoders) :int)

(cffi:defcfun ("Mix_GetMusicDecoder" get-music-decoder) :string 
  (index :int))

(cffi:defcfun ("Mix_HasMusicDecoder" has-music-decoder) :bool 
  (name :string))

(cffi:defcfun ("Mix_GetMusicType" get-music-type) music-type 
  (music :pointer))

(cffi:defcfun ("Mix_GetMusicTitle" get-music-title) :string 
  (music :pointer))

(cffi:defcfun ("Mix_GetMusicTitleTag" get-music-title-tag) :string 
  (music :pointer))

(cffi:defcfun ("Mix_GetMusicArtistTag" get-music-artist-tag) :string 
  (music :pointer))

(cffi:defcfun ("Mix_GetMusicAlbumTag" get-music-album-tag) :string 
  (music :pointer))

(cffi:defcfun ("Mix_GetMusicCopyrightTag" get-music-copyright-tag) :string 
  (music :pointer))

(cffi:defcfun ("Mix_SetPostMix" set-post-mix) :void 
  (mix_func :pointer)
  (arg (:pointer :pointer)))

(cffi:defcfun ("Mix_HookMusic" hook-music) :void 
  (mix_func :pointer)
  (arg (:pointer :pointer)))

(cffi:defcfun ("Mix_HookMusicFinished" hook-music-finished) :void 
  (music_finished :pointer))

(cffi:defcfun ("Mix_GetMusicHookData" get-music-hook-data) (:pointer :void))

(cffi:defcfun ("Mix_ChannelFinished" channel-finished) :void 
  (channel_finished :pointer))

(cffi:defcfun ("Mix_RegisterEffect" register-effect) :bool 
  (chan :int)
  (f :pointer)
  (d :pointer)
  (arg (:pointer :pointer)))

(cffi:defcfun ("Mix_UnregisterEffect" unregister-effect) :bool 
  (channel :int)
  (f :pointer))

(cffi:defcfun ("Mix_UnregisterAllEffects" unregister-all-effects) :bool 
  (channel :int))

(cffi:defcfun ("Mix_SetPanning" set-panning) :bool 
  (channel :int)
  (left :uint8)
  (right :uint8))

(cffi:defcfun ("Mix_SetPosition" set-position) :bool 
  (channel :int)
  (angle :int16)
  (distance :uint8))

(cffi:defcfun ("Mix_SetDistance" set-distance) :bool 
  (channel :int)
  (distance :uint8))

(cffi:defcfun ("Mix_SetReverseStereo" set-reverse-stereo) :bool 
  (channel :int)
  (flip :int))

(cffi:defcfun ("Mix_ReserveChannels" reserve-channels) :int 
  (num :int))

(cffi:defcfun ("Mix_GroupChannel" group-channel) :bool 
  (which :int)
  (tag :int))

(cffi:defcfun ("Mix_GroupChannels" group-channels) :bool 
  (from :int)
  (to :int)
  (tag :int))

(cffi:defcfun ("Mix_GroupAvailable" group-available) :int 
  (tag :int))

(cffi:defcfun ("Mix_GroupCount" group-count) :int 
  (tag :int))

(cffi:defcfun ("Mix_GroupOldest" group-oldest) :int 
  (tag :int))

(cffi:defcfun ("Mix_GroupNewer" group-newer) :int 
  (tag :int))

(cffi:defcfun ("Mix_PlayChannel" play-channel) :int 
  (channel :int)
  (chunk (:pointer (:struct chunk)))
  (loops :int))

(cffi:defcfun ("Mix_PlayChannelTimed" play-channel-timed) :int 
  (channel :int)
  (chunk (:pointer (:struct chunk)))
  (loops :int)
  (ticks :int))

(cffi:defcfun ("Mix_PlayMusic" play-music) :bool 
  (music :pointer)
  (loops :int))

(cffi:defcfun ("Mix_FadeInMusic" fade-in-music) :bool 
  (music :pointer)
  (loops :int)
  (ms :int))

(cffi:defcfun ("Mix_FadeInMusicPos" fade-in-music-pos) :bool 
  (music :pointer)
  (loops :int)
  (ms :int)
  (position :double))

(cffi:defcfun ("Mix_FadeInChannel" fade-in-channel) :int 
  (channel :int)
  (chunk (:pointer (:struct chunk)))
  (loops :int)
  (ms :int))

(cffi:defcfun ("Mix_FadeInChannelTimed" fade-in-channel-timed) :int 
  (channel :int)
  (chunk (:pointer (:struct chunk)))
  (loops :int)
  (ms :int)
  (ticks :int))

(cffi:defcfun ("Mix_Volume" volume) :int 
  (channel :int)
  (volume :int))

(cffi:defcfun ("Mix_VolumeChunk" volume-chunk) :int 
  (chunk (:pointer (:struct chunk)))
  (volume :int))

(cffi:defcfun ("Mix_VolumeMusic" volume-music) :int 
  (volume :int))

(cffi:defcfun ("Mix_GetMusicVolume" get-music-volume) :int 
  (music :pointer))

(cffi:defcfun ("Mix_MasterVolume" master-volume) :int 
  (volume :int))

(cffi:defcfun ("Mix_HaltChannel" halt-channel) :void 
  (channel :int))

(cffi:defcfun ("Mix_HaltGroup" halt-group) :void 
  (tag :int))

(cffi:defcfun ("Mix_HaltMusic" halt-music) :void)

(cffi:defcfun ("Mix_ExpireChannel" expire-channel) :int 
  (channel :int)
  (ticks :int))

(cffi:defcfun ("Mix_FadeOutChannel" fade-out-channel) :int 
  (which :int)
  (ms :int))

(cffi:defcfun ("Mix_FadeOutGroup" fade-out-group) :int 
  (tag :int)
  (ms :int))

(cffi:defcfun ("Mix_FadeOutMusic" fade-out-music) :bool 
  (ms :int))

(cffi:defcfun ("Mix_FadingMusic" fading-music) fading)

(cffi:defcfun ("Mix_FadingChannel" fading-channel) fading
  (which :int))

(cffi:defcfun ("Mix_Pause" pause) :void 
  (channel :int))

(cffi:defcfun ("Mix_PauseGroup" pause-group) :void 
  (tag :int))

(cffi:defcfun ("Mix_Resume" resume) :void 
  (channel :int))

(cffi:defcfun ("Mix_ResumeGroup" resume-group) :void 
  (tag :int))

(cffi:defcfun ("Mix_Paused" paused) :int 
  (channel :int))

(cffi:defcfun ("Mix_PauseMusic" pause-music) :void)

(cffi:defcfun ("Mix_ResumeMusic" resume-music) :void)

(cffi:defcfun ("Mix_RewindMusic" rewind-music) :void)

(cffi:defcfun ("Mix_PausedMusic" paused-music) :bool)

(cffi:defcfun ("Mix_ModMusicJumpToOrder" mod-music-jump-to-order) :bool 
  (order :int))

(cffi:defcfun ("Mix_StartTrack" start-track) :bool 
  (music :pointer)
  (track :int))

(cffi:defcfun ("Mix_GetNumTracks" get-num-tracks) :int 
  (music :pointer))

(cffi:defcfun ("Mix_SetMusicPosition" set-music-position) :bool 
  (position :double))

(cffi:defcfun ("Mix_GetMusicPosition" get-music-position) :double 
  (music :pointer))

(cffi:defcfun ("Mix_MusicDuration" music-duration) :double 
  (music :pointer))

(cffi:defcfun ("Mix_GetMusicLoopStartTime" get-music-loop-start-time) :double 
  (music :pointer))

(cffi:defcfun ("Mix_GetMusicLoopEndTime" get-music-loop-end-time) :double 
  (music :pointer))

(cffi:defcfun ("Mix_GetMusicLoopLengthTime" get-music-loop-length-time) :double 
  (music :pointer))

(cffi:defcfun ("Mix_Playing" playing) :int 
  (channel :int))

(cffi:defcfun ("Mix_PlayingMusic" playing-music) :bool)

(cffi:defcfun ("Mix_SetSoundFonts" set-sound-fonts) :bool 
  (paths :string))

(cffi:defcfun ("Mix_GetSoundFonts" get-sound-fonts) :string)

(cffi:defcfun ("Mix_EachSoundFont" each-sound-font) :bool 
  (function :pointer)
  (data :pointer))

(cffi:defcfun ("Mix_SetTimidityCfg" set-timidity-cfg) :bool 
  (path :string))

(cffi:defcfun ("Mix_GetTimidityCfg" get-timidity-cfg) :string)

(cffi:defcfun ("Mix_GetChunk" get-chunk) (:pointer (:struct chunk)) 
  (channel :int))

(cffi:defcfun ("Mix_CloseAudio" close-audio) :void)


