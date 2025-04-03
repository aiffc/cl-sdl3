(in-package :sdl3-mixer)

(defbitfield init-flags
  (:flac       #x00000001)
  (:mod        #x00000002)
  (:mp3        #x00000008)
  (:ogg        #x00000010)
  (:mid        #x00000020)
  (:opus       #x00000040)
  (:wavpack    #x00000080))

(defcenum music-type
  :none
  :wav
  :mod
  :mid
  :ogg
  :mp3
  :flac
  :opus
  :wavpack
  :gme)

(defcenum fading
  :no-fading
  :fading-out
  :fading-in)

(cffi:defcstruct chunk
  (allocated :int)
  (abuf (:pointer :uint8))
  (alen (:pointer :uint32))
  (volume :uint8))
