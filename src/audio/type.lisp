(in-package :sdl3)

(defctype audio-device-id :uint32)

(defcenum audio-format
  (:unknown  #x0000)
  (:u8       #x0008)
  (:s8       #x8008) 
  (:s16le    #x8010) 
  (:s16be    #x9010) 
  (:s32le    #x8020) 
  (:s32be    #x9020) 
  (:f32le    #x8120) 
  (:f32be    #x9120))

(deflsp-type audio-spec
  (format audio-format)
  (channels :int)
  (freq :int))
