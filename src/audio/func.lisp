(in-package :sdl3)

(defexport-fun "SDL_GetNumAudioDrivers" :int)

(defexport-fun "SDL_GetAudioDriver" :string
  (index :int))

(defexport-fun "SDL_GetCurrentAudioDriver" :string)

(defwrap-fun "SDL_GetAudioPlaybackDevices" (:pointer audio-device-id)
    (t t)
  (count (:pointer :int) :ret-count 'audio-device-id))

(defwrap-fun "SDL_GetAudioRecordingDevices" (:pointer audio-device-id)
    (t t)
  (count (:pointer :int) :ret-count 'audio-device-id))

(defexport-fun "SDL_GetAudioDeviceName" :string
  (dvid audio-device-id))

(defwrap-fun "SDL_GetAudioDeviceFormat" :bool
    (t t)
  (dvid audio-device-id)
  (spec (:pointer (:struct audio-spec)) :direction :output)
  (sample-frames (:pointer :int) :direction :input))

(defwrap-fun "SDL_GetAudioDeviceChannelMap" (:pointer :int)
    (t t)
  (dvid audio-device-id)
  (count (:pointer :int) :ret-count :int))

(defwrap-fun "SDL_OpenAudioDevice" audio-device-id
    (t t)
  (dvid audio-device-id)
  (spec (:pointer (:struct audio-spec)) :direction :input))

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

(defwrap-fun "SDL_CreateAudioStream" :pointer
    (t t)
  (src-spec (:pointer (:struct audio-spec)) :direction :input)
  (dsp-spec (:pointer (:struct audio-spec)) :direction :input))

(defexport-fun "SDL_GetAudioStreamProperties" properties-id
  (stream :pointer))

(defwrap-fun "SDL_GetAudioStreamFormat" :bool
    (t t)
  (stream :pointer)
  (src-spec (:pointer (:struct audio-spec)) :direction :input)
  (dsp-spec (:pointer (:struct audio-spec)) :direction :input))

(defwrap-fun "SDL_SetAudioStreamFormat" :bool
    (t t)
  (stream :pointer)
  (src-spec (:pointer (:struct audio-spec)) :direction :input)
  (dsp-spec (:pointer (:struct audio-spec)) :direction :input))

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

(defwrap-fun "SDL_GetAudioStreamInputChannelMap" (:pointer :int)
    (t t)
  (stream :pointer)
  (count (:pointer :int) :ret-count :int))

(defwrap-fun "SDL_GetAudioStreamOutputChannelMap" (:pointer :int)
    (t t)
  (stream :pointer)
  (count (:pointer :int) :ret-count :int))

(defwrap-fun "SDL_SetAudioStreamInputChannelMap" :bool
    (t t)
  (stream :pointer)
  (chmap (:pointer :int) :direction :input :bind-count count)
  (count :int :bind-val chmap))

(defwrap-fun "SDL_SetAudioStreamOutputChannelMap" :bool
    (t t)
  (stream :pointer)
  (chmap (:pointer :int) :direction :input :bind-count count)
  (count :int :bind-val chmap))

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

(defwrap-fun "SDL_OpenAudioDeviceStream" :pointer
    (t t)
  (did audio-device-id)
  (spec (:pointer (:struct audio-spec)) :direction :input)
  (callback :pointer)
  (userdata :pointer))

(defexport-fun "SDL_SetAudioPostmixCallback" :bool
  (did audio-device-id)
  (callback :pointer)
  (userdata :pointer))

(defwrap-fun ("SDL_LoadWAV_IO" load-wav-io) :bool
    (t t)
  (src :pointer)
  (close-io :bool)
  (spec (:pointer (:struct audio-spec)) :direction :intput)
  (buf (:pointer (:pointer :uint8)) :direction :intput :bind-count len)
  (len (:pointer :uint32) :bind-val buf))

(defwrap-fun ("SDL_LoadWAV" load-wav) :bool
    (t t)
  (path :string)
  (spec (:pointer (:struct audio-spec)) :direction :intput)
  (buf (:pointer (:pointer :uint8)) :direction :intput :bind-count len)
  (len (:pointer :uint32) :bind-val buf))

(defwrap-fun "SDL_MixAudio" :bool
    (t t)
  (dst (:pointer :uint8) :direction :intput)
  (src (:pointer :uint8) :direction :intput)
  (fmt audio-format)
  (len :uint32)
  (volume :float))

;; todo
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
