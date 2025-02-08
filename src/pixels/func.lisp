(in-package :sdl3)

(defexport-fun "SDL_GetPixelFormatName" :string
  (fmt pixel-format))

(defexport-fun "SDL_GetMasksForPixelFormat" :bool
  (fmt pixel-format)
  (bpp (:pointer :int))
  (rmask (:pointer :uint32))
  (gmask (:pointer :uint32))
  (bmask (:pointer :uint32))
  (amask (:pointer :uint32)))

(defexport-fun "SDL_GetPixelFormatForMasks" pixel-format
  (bpp :int)
  (rmask :uint32)
  (gmask :uint32)
  (bmask :uint32)
  (amask :uint32))

(defexport-fun "SDL_GetPixelFormatDetails" (:pointer (:struct pixel-format-detail))
  (fmt pixel-format))

(defexport-fun "SDL_CreatePalette" (:pointer (:struct palette))
  (ncolors :int))

(defexport-fun "SDL_SetPaletteColors" :bool
  (palette (:pointer (:struct palette)))
  (colors (:pointer (:struct color)))
  (firstcolor :int)
  (ncolors :int))

(defexport-fun "SDL_DestroyPalette" :void
  (palette (:pointer (:struct palette))))

(defwrap-fun "SDL_MapRGB" :uint32
    (t t)
  (fmt (:pointer (:struct pixel-format-detail)))
  (palette (:pointer (:struct palette)) :direction :input)
  (r :uint8)
  (g :uint8)
  (b :uint8))

(defexport-fun "SDL_MapRGBA" :uint32
  (fmt (:pointer (:struct pixel-format-detail)))
  (palette (:pointer (:struct palette)))
  (r :uint8)
  (g :uint8)
  (b :uint8)
  (a :uint8))

(defexport-fun "SDL_GetRGB" :void
  (fmt (:pointer (:struct pixel-format-detail)))
  (palette (:pointer (:struct palette)))
  (r (:pointer :uint8))
  (g (:pointer :uint8))
  (b (:pointer :uint8)))

(defexport-fun "SDL_GetRGBA" :void
  (fmt (:pointer (:struct pixel-format-detail)))
  (palette (:pointer (:struct palette)))
  (r (:pointer :uint8))
  (g (:pointer :uint8))
  (b (:pointer :uint8))
  (a (:pointer :uint8)))
