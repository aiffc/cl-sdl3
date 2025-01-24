(in-package :sdl3)

(defexport-fun "SDL_GetNumAudioDrivers" :int)

(defexport-fun "SDL_GetAudioDriver" :string
  (index :int))

(defexport-fun "SDL_GetCurrentAudioDriver" :string)

(defexport-fun "SDL_GetAudioPlaybackDevices" (:pointer audio-device-id)
  (count (:pointer :int)))

(defexport-fun "SDL_GetAudioRecordingDevices" (:pointer audio-device-id)
  (count (:pointer :int)))

(defexport-fun "SDL_GetAudioDeviceName" :string
  (dvid audio-device-id))

(defexport-fun "SDL_GetAudioDeviceFormat" :bool
  (dvid audio-device-id)
  (spec (:pointer (:struct audio-spec)))
  (sample-frames (:pointer :int)))

(defexport-fun "SDL_GetAudioDeviceChannelMap" (:pointer :int)
  (dvid audio-device-id)
  (count (:pointer :int)))

(defexport-fun "SDL_OpenAudioDevice" audio-device-id
  (dvid audio-device-id)
  (spec (:pointer (:struct audio-spec))))

(defexport-fun "SDL_IsAudioDevicePhysical" :bool
  (dvid audio-device-id))

(defexport-fun "SDL_IsAudioDevicePlayback" :bool
  (dvid audio-device-id))

(defexport-fun "SDL_PauseAudioDevice" :bool
  (dvid audio-device-id))

(defexport-fun "SDL_ResumeAudioDevice" :bool
  (dvid audio-device-id))

(defexport-fun "SDL_AudioDevicePaused" :bool
  (dvid audio-device-id))

(defexport-fun "SDL_GetAudioDeviceGain" :float
  (dvid audio-device-id))

(defexport-fun "SDL_SetAudioDeviceGain" :bool
  (dvid audio-device-id)
  (gain :bool))

(defexport-fun "SDL_CloseAudioDevice" :void
  (dvid audio-device-id))

(defexport-fun "SDL_BindAudioStreams" :bool
  (dvid audio-device-id)
  (streams (:pointer :pointer))
  (num-streams :int))

(defexport-fun "SDL_BindAudioStream" :bool
  (dvid audio-device-id)
  (stream :pointer))

(defexport-fun "SDL_UnbindAudioStreams" :void
  (streams (:pointer :pointer))
  (num-streams :int))

(defexport-fun "SDL_UnbindAudioStream" :void
  (stream :pointer))

(defexport-fun "SDL_GetAudioStreamDevice" audio-device-id
  (stream :pointer))

(defexport-fun "SDL_CreateAudioStream" :pointer
  (src-spec (:pointer (:struct audio-spec)))
  (dsp-spec (:pointer (:struct audio-spec))))

(defexport-fun "SDL_GetAudioStreamProperties" properties-id
  (stream :pointer))

(defexport-fun "SDL_GetAudioStreamFormat" :bool
  (stream :pointer)
  (src-spec (:pointer (:struct audio-spec)))
  (dsp-spec (:pointer (:struct audio-spec))))

(defexport-fun "SDL_SetAudioStreamFormat" :bool
  (stream :pointer)
  (src-spec (:pointer (:struct audio-spec)))
  (dsp-spec (:pointer (:struct audio-spec))))

(defexport-fun "SDL_GetAudioStreamFrequencyRatio" :float
  (stream :pointer))

(defexport-fun "SDL_SetAudioStreamFrequencyRatio" :bool
  (stream :pointer)
  (ratio :float))

(defexport-fun "SDL_GetAudioStreamGain" :float
  (stream :pointer))

(defexport-fun "SDL_SetAudioStreamGain" :bool
  (stream :pointer)
  (gain :float))

(defexport-fun "SDL_GetAudioStreamInputChannelMap" (:pointer :int)
  (stream :pointer)
  (count (:pointer :int)))

(defexport-fun "SDL_GetAudioStreamOutputChannelMap" (:pointer :int)
  (stream :pointer)
  (count (:pointer :int)))

(defexport-fun "SDL_SetAudioStreamInputChannelMap" :bool
  (stream :pointer)
  (chmap (:pointer :int))
  (count :int))

(defexport-fun "SDL_SetAudioStreamOutputChannelMap" :bool
  (stream :pointer)
  (chmapcount (:pointer :int))
  (count :int))

(defexport-fun "SDL_PutAudioStreamData" :bool
  (stream :pointer)
  (buf :pointer)
  (len :int))

(defexport-fun "SDL_GetAudioStreamData" :int
  (stream :pointer)
  (buf :pointer)
  (len :int))

(defexport-fun "SDL_GetAudioStreamAvailable" :int
  (stream :pointer))

(defexport-fun "SDL_GetAudioStreamQueued" :int
  (stream :pointer))

(defexport-fun "SDL_FlushAudioStream" :bool
  (stream :pointer))

(defexport-fun "SDL_ClearAudioStream" :bool
  (stream :pointer))

(defexport-fun "SDL_PauseAudioStreamDevice" :bool
  (stream :pointer))

(defexport-fun "SDL_ResumeAudioStreamDevice" :bool
  (stream :pointer))

(defexport-fun "SDL_AudioStreamDevicePaused" :bool
  (stream :pointer))

(defexport-fun "SDL_LockAudioStream" :bool
  (stream :pointer))

(defexport-fun "SDL_UnlockAudioStream" :bool
  (stream :pointer))

(defexport-fun "SDL_SetAudioStreamGetCallback" :bool
  (stream :pointer)
  (callback :pointer)
  (userdata :pointer))

(defexport-fun "SDL_SetAudioStreamPutCallback" :bool
  (stream :pointer)
  (callback :pointer)
  (userdata :pointer))

(defexport-fun "SDL_DestroyAudioStream" :void
  (stream :pointer))

(defexport-fun "SDL_OpenAudioDeviceStream" :pointer
  (did (audio-device-id))
  (spec (:pointer (:struct audio-spec)))
  (callback :pointer)
  (userdata :pointer))

(defexport-fun "SDL_SetAudioPostmixCallback" :bool
  (did (audio-device-id))
  (callback :pointer)
  (userdata :pointer))

(defexport-fun ("SDL_LoadWAV_IO" load-wav-io) :bool
  (src :pointer)
  (close-io :bool)
  (spec (:pointer (:struct audio-spec)))
  (buf (:pointer (:pointer :uint8)))
  (len (:pointer :uint32)))

(defexport-fun ("SDL_LoadWAV" load-wav) :bool
  (path :string)
  (spec (:pointer (:struct audio-spec)))
  (buf (:pointer (:pointer :uint8)))
  (len (:pointer :uint32)))

(defexport-fun "SDL_MixAudio" :bool
  (dst (:pointer :uint8))
  (src (:pointer :uint8))
  (fmt audio-format)
  (len :uint32)
  (volume :float))

(defexport-fun "SDL_ConvertAudioSamples" :bool
  (src-spec (:pointer (:struct audio-spec)))
  (src-data (:pointer :uint8))
  (src-len :uint32)
  (dst-spec (:pointer (:struct audio-spec)))
  (dst-data (:pointer (:pointer :uint8)))
  (dst-len :uint32))

(defexport-fun "SDL_GetAudioFormatName" :string
  (fmt audio-format))

(defexport-fun "SDL_GetSilenceValueForFormat" :int
  (fmt audio-format))
