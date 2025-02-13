(in-package :sdl3)

(defexport-fun "SDL_GetPixelFormatName" :string
  (fmt pixel-format))

(defwrap-fun "SDL_GetMasksForPixelFormat" :bool
    (t t)
  (fmt pixel-format)
  (bpp (:pointer :int) :direction :output)
  (rmask (:pointer :uint32) :direction :output)
  (gmask (:pointer :uint32) :direction :output)
  (bmask (:pointer :uint32) :direction :output)
  (amask (:pointer :uint32) :direction :output))

(defexport-fun "SDL_GetPixelFormatForMasks" pixel-format
  (bpp :int)
  (rmask :uint32)
  (gmask :uint32)
  (bmask :uint32)
  (amask :uint32))

(defwrap-fun "SDL_GetPixelFormatDetails" (:pointer (:struct pixel-format-detail))
    (t t)
  (fmt pixel-format))

(defexport-fun "SDL_CreatePalette" (:pointer (:struct palette))
  (ncolors :int))

(defwrap-fun "SDL_SetPaletteColors" :bool
    (t t)
  (palette (:pointer (:struct palette)))
  (colors (:pointer (:struct color)) :direction :input :bind-count ncolors)
  (firstcolor :int)
  (ncolors :int :bind-val colors))

(defexport-fun "SDL_DestroyPalette" :void
  (palette (:pointer (:struct palette))))

(defwrap-fun "SDL_MapRGB" :uint32
    (t t)
  (fmt (:pointer (:struct pixel-format-detail)))
  (palette (:pointer (:struct palette)) :direction :input)
  (r :uint8)
  (g :uint8)
  (b :uint8))

(defwrap-fun "SDL_MapRGBA" :uint32
    (t t)
  (fmt (:pointer (:struct pixel-format-detail)))
  (palette (:pointer (:struct palette)) :direction :input)
  (r :uint8)
  (g :uint8)
  (b :uint8)
  (a :uint8))

(defwrap-fun "SDL_GetRGB" :void
    (t)
  (pixel :uint32)
  (fmt (:pointer (:struct pixel-format-detail)))
  (palette (:pointer (:struct palette)) :direction :input)
  (r (:pointer :uint8) :direction :output)
  (g (:pointer :uint8) :direction :output)
  (b (:pointer :uint8) :direction :output))

(defwrap-fun "SDL_GetRGBA" :void
    (t)
  (fmt (:pointer (:struct pixel-format-detail)))
  (palette (:pointer (:struct palette)) :direction :output)
  (r (:pointer :uint8) :direction :output)
  (g (:pointer :uint8) :direction :output)
  (b (:pointer :uint8) :direction :output)
  (a (:pointer :uint8) :direction :output))
