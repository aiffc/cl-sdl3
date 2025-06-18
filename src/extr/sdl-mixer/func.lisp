(in-package :sdl3-mixer)

(cffi:defcfun ("Mix_Version" version) :int)
(export 'version)

(cffi:defcfun ("Mix_Init" init) init-flags
  (flags init-flags))
(export 'init)

(cffi:defcfun ("Mix_Quit" quit) :void)
(export 'quit)

(sdl3::defwrap-fun ("Mix_OpenAudio" open-audio) :bool
    (t t)
  (devid sdl3::audio-device-id)
  (spec (:pointer (:struct sdl3::audio-spec)) :direction :input))

(cffi:defcfun ("Mix_PauseAudio" pause-audio) :void 
  (pause_on :int))
(export 'pause-audio)

(sdl3::defwrap-fun ("Mix_QuerySpec" query-spec) :bool
    (t t)
  (frequency (:pointer :int) :direction :output)
  (format (:pointer sdl3::audio-format) :direction :output)
  (channels (:pointer :int) :direction :output))

(cffi:defcfun ("Mix_AllocateChannels" allocate-channels) :int 
  (numchans :int))
(export 'allocate-channels)

(cffi:defcfun ("Mix_LoadWAV_IO" load-wav-io) (:pointer (:struct chunk)) 
  (src :pointer)
  (closeio :bool))
(export 'load-wav-io)

(cffi:defcfun ("Mix_LoadWAV" load-wav) (:pointer (:struct chunk)) 
  (file :string))
(export 'load-wav)

(cffi:defcfun ("Mix_LoadMUS" load-mus) :pointer
  (file :string))
(export 'load-mus)

(cffi:defcfun ("Mix_LoadMUS_IO" load-mus-io) :pointer
  (src :pointer)
  (closeio :bool))
(export 'load-mus-io)

(cffi:defcfun ("Mix_LoadMUSType_IO" load-mus-type-io) :pointer
  (src :pointer)
  (type music-type)
  (closeio :bool))
(export 'load-mus-type-io)

(cffi:defcfun ("Mix_QuickLoad_WAV" quick-load-wav) (:pointer (:struct chunk)) 
  (mem (:pointer :uint8)))
(export 'quick-load-wav)

(cffi:defcfun ("Mix_QuickLoad_RAW" quick-load-raw) (:pointer (:struct chunk)) 
  (mem (:pointer :uint8))
  (len :uint32))
(export 'quick-load-raw)

(cffi:defcfun ("Mix_FreeChunk" free-chunk) :void 
  (chunk (:pointer (:struct chunk))))
(export 'free-chunk)

(cffi:defcfun ("Mix_FreeMusic" free-music) :void 
  (music :pointer))
(export 'free-music)

(cffi:defcfun ("Mix_GetNumChunkDecoders" get-num-chunk-decoders) :int)
(export 'get-num-chunk-decoders)

(cffi:defcfun ("Mix_GetChunkDecoder" get-chunk-decoder) :string 
  (index :int))
(export 'get-chunk-decoder)

(cffi:defcfun ("Mix_HasChunkDecoder" has-chunk-decoder) :bool 
  (name :string))
(export 'has-chunk-decoder)

(cffi:defcfun ("Mix_GetNumMusicDecoders" get-num-music-decoders) :int)
(export 'get-num-music-decoders)

(cffi:defcfun ("Mix_GetMusicDecoder" get-music-decoder) :string 
  (index :int))
(export 'get-music-decoder)

(cffi:defcfun ("Mix_HasMusicDecoder" has-music-decoder) :bool 
  (name :string))
(export 'has-music-decoder)

(cffi:defcfun ("Mix_GetMusicType" get-music-type) music-type 
  (music :pointer))
(export 'get-music-type)

(cffi:defcfun ("Mix_GetMusicTitle" get-music-title) :string 
  (music :pointer))
(export 'get-music-title)

(cffi:defcfun ("Mix_GetMusicTitleTag" get-music-title-tag) :string 
  (music :pointer))
(export 'get-music-title-tag)

(cffi:defcfun ("Mix_GetMusicArtistTag" get-music-artist-tag) :string 
  (music :pointer))
(export 'get-music-artist-tag)

(cffi:defcfun ("Mix_GetMusicAlbumTag" get-music-album-tag) :string 
  (music :pointer))
(export 'get-music-album-tag)

(cffi:defcfun ("Mix_GetMusicCopyrightTag" get-music-copyright-tag) :string 
  (music :pointer))
(export 'get-music-copyright-tag)

(cffi:defcfun ("Mix_SetPostMix" set-post-mix) :void 
  (mix_func :pointer)
  (arg (:pointer :pointer)))
(export 'set-post-mix)

(cffi:defcfun ("Mix_HookMusic" hook-music) :void 
  (mix_func :pointer)
  (arg (:pointer :pointer)))
(export 'hook-music)

(cffi:defcfun ("Mix_HookMusicFinished" hook-music-finished) :void 
  (music_finished :pointer))
(export 'hook-music-finished)

(cffi:defcfun ("Mix_GetMusicHookData" get-music-hook-data) (:pointer :void))
(export 'get-music-hook-data)

(cffi:defcfun ("Mix_ChannelFinished" channel-finished) :void 
  (channel_finished :pointer))
(export 'channel-finished)

(cffi:defcfun ("Mix_RegisterEffect" register-effect) :bool 
  (chan :int)
  (f :pointer)
  (d :pointer)
  (arg (:pointer :pointer)))
(export 'register-effect)

(cffi:defcfun ("Mix_UnregisterEffect" unregister-effect) :bool 
  (channel :int)
  (f :pointer))
(export 'unregister-effect)

(cffi:defcfun ("Mix_UnregisterAllEffects" unregister-all-effects) :bool 
  (channel :int))
(export 'unregister-all-effects)

(cffi:defcfun ("Mix_SetPanning" set-panning) :bool 
  (channel :int)
  (left :uint8)
  (right :uint8))
(export 'set-panning)

(cffi:defcfun ("Mix_SetPosition" set-position) :bool 
  (channel :int)
  (angle :int16)
  (distance :uint8))
(export 'set-position)

(cffi:defcfun ("Mix_SetDistance" set-distance) :bool 
  (channel :int)
  (distance :uint8))
(export 'set-distance)

(cffi:defcfun ("Mix_SetReverseStereo" set-reverse-stereo) :bool 
  (channel :int)
  (flip :int))
(export 'set-reverse-stereo)

(cffi:defcfun ("Mix_ReserveChannels" reserve-channels) :int 
  (num :int))
(export 'reserve-channels)

(cffi:defcfun ("Mix_GroupChannel" group-channel) :bool 
  (which :int)
  (tag :int))
(export 'group-channel)

(cffi:defcfun ("Mix_GroupChannels" group-channels) :bool 
  (from :int)
  (to :int)
  (tag :int))
(export 'group-channels)

(cffi:defcfun ("Mix_GroupAvailable" group-available) :int 
  (tag :int))
(export 'group-available)

(cffi:defcfun ("Mix_GroupCount" group-count) :int 
  (tag :int))
(export 'group-count)

(cffi:defcfun ("Mix_GroupOldest" group-oldest) :int 
  (tag :int))
(export 'group-oldest)

(cffi:defcfun ("Mix_GroupNewer" group-newer) :int 
  (tag :int))
(export 'group-newer)

(cffi:defcfun ("Mix_PlayChannel" play-channel) :int 
  (channel :int)
  (chunk (:pointer (:struct chunk)))
  (loops :int))
(export 'play-channel)

(cffi:defcfun ("Mix_PlayChannelTimed" play-channel-timed) :int 
  (channel :int)
  (chunk (:pointer (:struct chunk)))
  (loops :int)
  (ticks :int))
(export 'play-channel-timed)

(cffi:defcfun ("Mix_PlayMusic" play-music) :bool 
  (music :pointer)
  (loops :int))
(export 'play-music)

(cffi:defcfun ("Mix_FadeInMusic" fade-in-music) :bool 
  (music :pointer)
  (loops :int)
  (ms :int))
(export 'fade-in-music)

(cffi:defcfun ("Mix_FadeInMusicPos" fade-in-music-pos) :bool 
  (music :pointer)
  (loops :int)
  (ms :int)
  (position :double))
(export 'fade-in-music-pos)

(cffi:defcfun ("Mix_FadeInChannel" fade-in-channel) :int 
  (channel :int)
  (chunk (:pointer (:struct chunk)))
  (loops :int)
  (ms :int))
(export 'fade-in-channel)

(cffi:defcfun ("Mix_FadeInChannelTimed" fade-in-channel-timed) :int 
  (channel :int)
  (chunk (:pointer (:struct chunk)))
  (loops :int)
  (ms :int)
  (ticks :int))
(export 'fade-in-channel-timed)

(cffi:defcfun ("Mix_Volume" volume) :int 
  (channel :int)
  (volume :int))
(export 'volume)

(cffi:defcfun ("Mix_VolumeChunk" volume-chunk) :int 
  (chunk (:pointer (:struct chunk)))
  (volume :int))
(export 'volume-chunk)

(cffi:defcfun ("Mix_VolumeMusic" volume-music) :int 
  (volume :int))
(export 'volume-music)

(cffi:defcfun ("Mix_GetMusicVolume" get-music-volume) :int 
  (music :pointer))
(export 'get-music-volume)

(cffi:defcfun ("Mix_MasterVolume" master-volume) :int 
  (volume :int))
(export 'master-volume)

(cffi:defcfun ("Mix_HaltChannel" halt-channel) :void 
  (channel :int))
(export 'halt-channel)

(cffi:defcfun ("Mix_HaltGroup" halt-group) :void 
  (tag :int))
(export 'halt-group)

(cffi:defcfun ("Mix_HaltMusic" halt-music) :void)
(export 'halt-music)

(cffi:defcfun ("Mix_ExpireChannel" expire-channel) :int 
  (channel :int)
  (ticks :int))
(export 'expire-channel)

(cffi:defcfun ("Mix_FadeOutChannel" fade-out-channel) :int 
  (which :int)
  (ms :int))
(export 'fade-out-channel)

(cffi:defcfun ("Mix_FadeOutGroup" fade-out-group) :int 
  (tag :int)
  (ms :int))
(export 'fade-out-group)

(cffi:defcfun ("Mix_FadeOutMusic" fade-out-music) :bool 
  (ms :int))
(export 'fade-out-music)

(cffi:defcfun ("Mix_FadingMusic" fading-music) fading)
(export 'fading-music)

(cffi:defcfun ("Mix_FadingChannel" fading-channel) fading
  (which :int))
(export 'fading-channel)

(cffi:defcfun ("Mix_Pause" pause) :void 
  (channel :int))
(export 'pause)

(cffi:defcfun ("Mix_PauseGroup" pause-group) :void 
  (tag :int))
(export 'pause-group)

(cffi:defcfun ("Mix_Resume" resume) :void 
  (channel :int))
(export 'resume)

(cffi:defcfun ("Mix_ResumeGroup" resume-group) :void 
  (tag :int))
(export 'resume-group)

(cffi:defcfun ("Mix_Paused" paused) :int 
  (channel :int))
(export 'paused)

(cffi:defcfun ("Mix_PauseMusic" pause-music) :void)
(export 'paused-music)

(cffi:defcfun ("Mix_ResumeMusic" resume-music) :void)
(export 'resume-music)

(cffi:defcfun ("Mix_RewindMusic" rewind-music) :void)
(export 'rewind-music)

(cffi:defcfun ("Mix_PausedMusic" paused-music) :bool)
(export 'paused-music)

(cffi:defcfun ("Mix_ModMusicJumpToOrder" mod-music-jump-to-order) :bool 
  (order :int))
(export 'mod-music-jump-to-order)

(cffi:defcfun ("Mix_StartTrack" start-track) :bool 
  (music :pointer)
  (track :int))
(export 'start-track)

(cffi:defcfun ("Mix_GetNumTracks" get-num-tracks) :int 
  (music :pointer))
(export 'get-num-tracks)

(cffi:defcfun ("Mix_SetMusicPosition" set-music-position) :bool 
  (position :double))
(export 'set-music-position)

(cffi:defcfun ("Mix_GetMusicPosition" get-music-position) :double 
  (music :pointer))
(export 'get-music-position)

(cffi:defcfun ("Mix_MusicDuration" music-duration) :double 
  (music :pointer))
(export 'music-duration)

(cffi:defcfun ("Mix_GetMusicLoopStartTime" get-music-loop-start-time) :double 
  (music :pointer))
(export 'get-music-loop-start-time)

(cffi:defcfun ("Mix_GetMusicLoopEndTime" get-music-loop-end-time) :double 
  (music :pointer))
(export 'get-music-loop-end-time)

(cffi:defcfun ("Mix_GetMusicLoopLengthTime" get-music-loop-length-time) :double 
  (music :pointer))
(export 'get-music-loop-length-time)

(cffi:defcfun ("Mix_Playing" playing) :int 
  (channel :int))
(export 'playing)

(cffi:defcfun ("Mix_PlayingMusic" playing-music) :bool)
(export 'playing-music)

(cffi:defcfun ("Mix_SetSoundFonts" set-sound-fonts) :bool 
  (paths :string))
(export 'set-sound-fonts)

(cffi:defcfun ("Mix_GetSoundFonts" get-sound-fonts) :string)
(export 'get-sound-fonts)

(cffi:defcfun ("Mix_EachSoundFont" each-sound-font) :bool 
  (function :pointer)
  (data :pointer))
(export 'each-sound-font)

(cffi:defcfun ("Mix_SetTimidityCfg" set-timidity-cfg) :bool 
  (path :string))
(export 'set-timidity-cfg)

(cffi:defcfun ("Mix_GetTimidityCfg" get-timidity-cfg) :string)
(export 'get-timidity-cfg)

(cffi:defcfun ("Mix_GetChunk" get-chunk) (:pointer (:struct chunk)) 
  (channel :int))
(export 'get-chunk)

(cffi:defcfun ("Mix_CloseAudio" close-audio) :void)
(export 'close-audio)


