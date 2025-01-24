(in-package :sdl3)

(defexport-fun "SDL_CreateSurface" :pointer
  (width :int)
  (height :int)
  (fmt pixel-format))

(defexport-fun "SDL_CreateSurfaceFrom" :pointer
  (width :int)
  (height :int)
  (fmt pixel-format)
  (pixels :pointer)
  (pitch :int))

(defexport-fun "SDL_DestroySurface" :void
  (surface :pointer))

(defexport-fun "SDL_GetSurfaceProperties" properties-id
  (surface :pointer))

(defexport-fun "SDL_SetSurfaceColorspace" :bool
  (surface :pointer)
  (color-spec colorspace))

(defexport-fun "SDL_GetSurfaceColorspace" colorspace
  (surface :pointer))

(defexport-fun "SDL_CreateSurfacePalette" (:pointer (:struct palette))
  (surface :pointer))

(defexport-fun "SDL_SetSurfacePalette" :bool
  (surface :pointer)
  (palette (:pointer (:struct palette))))

(defexport-fun "SDL_GetSurfacePalette" (:pointer (:struct palette))
  (surface :pointer))

(defexport-fun "SDL_AddSurfaceAlternateImage" :bool
  (surface :pointer)
  (image :pointer))

(defexport-fun "SDL_SurfaceHasAlternateImages" :bool
  (surface :pointer))

(defexport-fun "SDL_GetSurfaceImages" (:pointer :pointer)
  (surface :pointer)
  (count (:pointer :int)))

(defexport-fun "SDL_RemoveSurfaceAlternateImages" :void
  (surface :pointer))

(defexport-fun "SDL_LockSurface" :bool
  (surface :pointer))

(defexport-fun "SDL_UnlockSurface" :void
  (surface :pointer))

(defexport-fun ("SDL_LoadBMP_IO" load-bmp-io) :pointer
  (src :pointer)
  (closeio :bool))

(defexport-fun ("SDL_LoadBMP" load-bmp) :pointer
  (file :string))

(defexport-fun ("SDL_SaveBMP_IO" save-bmp-io) :bool
  (surface :pointer)
  (dst :pointer)
  (closeio :bool))

(defexport-fun ("SDL_SaveBMP" save-bmp) :bool
  (surface :pointer)
  (file :string))

(defexport-fun ("SDL_SetSurfaceRLE" set-surface-rle) :bool
  (surface :pointer)
  (enabled :bool))

(defexport-fun ("SDL_SurfaceHasRLE" surface-has-rle) :bool
  (surface :pointer))

(defexport-fun "SDL_SetSurfaceColorKey" :bool
  (surface :pointer)
  (enabled :bool)
  (key :uint32))

(defexport-fun "SDL_SurfaceHasColorKey" :bool
  (surface :pointer))

(defexport-fun "SDL_GetSurfaceColorKey" :bool
  (surface :pointer)
  (key (:pointer :uint32)))

(defexport-fun "SDL_SetSurfaceColorMod" :bool
  (surface :pointer)
  (r :uint8)
  (g :uint8)
  (b :uint8))

(defexport-fun "SDL_GetSurfaceColorMod" :bool
  (surface :pointer)
  (r (:pointer :uint8))
  (g (:pointer :uint8))
  (b (:pointer :uint8)))

(defexport-fun "SDL_SetSurfaceAlphaMod" :bool
  (surface :pointer)
  (alpha :uint8))

(defexport-fun "SDL_GetSurfaceAlphaMod" :bool
  (surface :pointer)
  (alpha (:pointer :uint8)))

(defexport-fun "SDL_SetSurfaceBlendMode" :bool
  (surface :pointer)
  (mode blend-mode))

(defexport-fun "SDL_GetSurfaceBlendMode" :bool
  (surface :pointer)
  (mode (:pointer blend-mode)))

(defexport-fun "SDL_SetSurfaceClipRect" :bool
  (surface :pointer)
  (rect (:pointer (:struct rect))))

(defexport-fun "SDL_GetSurfaceClipRect" :bool
  (surface :pointer)
  (rect (:pointer (:struct rect))))

(defexport-fun "SDL_FlipSurface" :bool
  (surface :pointer)
  (flip flip-mode))

(defexport-fun "SDL_DuplicateSurface" :pointer
  (surface :pointer))

(defexport-fun "SDL_ScaleSurface" :pointer
  (surface :pointer)
  (width :int)
  (height :int)
  (mode scale-mode))

(defexport-fun "SDL_ConvertSurface" :pointer
  (surface :pointer)
  (fmt pixel-format))

(defexport-fun "SDL_ConvertSurfaceAndColorspace" :pointer
  (surface :pointer)
  (fmt pixel-format)
  (palette (:pointer (:struct palette)))
  (colorspace colorspace)
  (props properties-id))

(defexport-fun "SDL_ConvertPixels" :bool
  (width :int)
  (height :int)
  (src-format pixel-format)
  (src :pointer)
  (src-pitch :int)
  (dst-format pixel-format)
  (dst :pointer)
  (dst-pitch :int))

(defexport-fun "SDL_ConvertPixelsAndColorspace" :bool
  (width :int)
  (height :int)
  (src-format pixel-format)
  (src-colorspace colorspace)
  (src-properties-id properties-id)
  (src :pointer)
  (src-pitch :int)
  (dst-format pixel-format)
  (dst-colorspace colorspace)
  (dst-properties-id properties-id)
  (dst :pointer)
  (dst-pitch :int))

(defexport-fun "SDL_PremultiplyAlpha" :bool
  (width :int)
  (height :int)
  (src-format pixel-format)
  (src :pointer)
  (src-pitch :int)
  (dst-format pixel-format)
  (dst :pointer)
  (dst-pitch :int)
  (liner :bool))

(defexport-fun "SDL_PremultiplySurfaceAlpha" :bool
  (surface :pointer)
  (liner :bool))

(defexport-fun "SDL_ClearSurface" :bool
  (surface :pointer)
  (r :float)
  (g :float)
  (b :float)
  (a :float))

(defexport-fun "SDL_FillSurfaceRect" :bool
  (surface :pointer)
  (rect (:pointer (:struct rect)))
  (color :uint32))

(defexport-fun "SDL_FillSurfaceRects" :bool
  (surface :pointer)
  (rect (:pointer (:struct rect)))
  (count :int)
  (color :uint32))

(defexport-fun "SDL_BlitSurface" :bool
  (ssurface :pointer)
  (srect (:pointer (:struct rect)))
  (dsurface :pointer)
  (drect (:pointer (:struct rect))))

(defexport-fun "SDL_BlitSurfaceUnchecked" :bool
  (ssurface :pointer)
  (srect (:pointer (:struct rect)))
  (dsurface :pointer)
  (drect (:pointer (:struct rect))))

(defexport-fun "SDL_BlitSurfaceScaled" :bool
  (ssurface :pointer)
  (srect (:pointer (:struct rect)))
  (dsurface :pointer)
  (drect (:pointer (:struct rect)))
  (mode scale-mode))

(defexport-fun "SDL_BlitSurfaceUncheckedScaled" :bool
  (ssurface :pointer)
  (srect (:pointer (:struct rect)))
  (dsurface :pointer)
  (drect (:pointer (:struct rect)))
  (mode scale-mode))

(defexport-fun "SDL_BlitSurfaceTiled" :bool
  (ssurface :pointer)
  (srect (:pointer (:struct rect)))
  (dsurface :pointer)
  (drect (:pointer (:struct rect))))

(defexport-fun "SDL_BlitSurfaceTiledWithScale" :bool
  (ssurface :pointer)
  (srect (:pointer (:struct rect)))
  (scale :float)
  (mode scale-mode)
  (dsurface :pointer)
  (drect (:pointer (:struct rect))))

(defexport-fun "SDL_BlitSurface9Grid" :bool
  (ssurface :pointer)
  (srect (:pointer (:struct rect)))
  (left-widht :int)
  (right-widht :int)
  (top-height :int)
  (button-height :int)
  (scale :float)
  (mode scale-mode)
  (dsurface :pointer)
  (drect (:pointer (:struct rect))))

(defexport-fun ("SDL_MapSurfaceRGB" map-surface-rgb) :uint32
  (surface :pointer)
  (r :uint8)
  (g :uint8)
  (b :uint8))

(defexport-fun ("SDL_MapSurfaceRGBA" map-surface-rgba) :uint32
  (surface :pointer)
  (r :uint8)
  (g :uint8)
  (b :uint8)
  (a :uint8))

(defexport-fun "SDL_ReadSurfacePixel" :bool
  (surface :pointer)
  (x :int)
  (y :int)
  (r (:pointer :uint8))
  (g (:pointer :uint8))
  (b (:pointer :uint8))
  (a (:pointer :uint8)))

(defexport-fun "SDL_ReadSurfacePixelFloat" :bool
  (surface :pointer)
  (x :int)
  (y :int)
  (r (:pointer :float))
  (g (:pointer :float))
  (b (:pointer :float))
  (a (:pointer :float)))

(defexport-fun "SDL_WriteSurfacePixel" :bool
  (surface :pointer)
  (x :int)
  (y :int)
  (r :uint8)
  (g :uint8)
  (b :uint8)
  (a :uint8))

(defexport-fun "SDL_WriteSurfacePixelFloat" :bool
  (surface :pointer)
  (x :int)
  (y :int)
  (r :float)
  (g :float)
  (b :float)
  (a :float))
