(in-package :sdl3)

(defexport-fun "SDL_CreateSurface" (:pointer (:struct surface))
  (width :int)
  (height :int)
  (fmt pixel-format))

(defexport-fun "SDL_CreateSurfaceFrom" (:pointer (:struct surface))
  (width :int)
  (height :int)
  (fmt pixel-format)
  (pixels :pointer)
  (pitch :int))

(defexport-fun "SDL_DestroySurface" :void
  (surface (:pointer (:struct surface))))

(defexport-fun "SDL_GetSurfaceProperties" properties-id
  (surface (:pointer (:struct surface))))

(defexport-fun "SDL_SetSurfaceColorspace" :bool
  (surface (:pointer (:struct surface)))
  (color-spec colorspace))

(defexport-fun "SDL_GetSurfaceColorspace" colorspace
  (surface (:pointer (:struct surface))))

(defexport-fun "SDL_CreateSurfacePalette" (:pointer (:struct palette))
  (surface (:pointer (:struct surface))))

(defexport-fun "SDL_SetSurfacePalette" :bool
  (surface (:pointer (:struct surface)))
  (palette (:pointer (:struct palette))))

(defexport-fun "SDL_GetSurfacePalette" (:pointer (:struct palette))
  (surface (:pointer (:struct surface))))

(defexport-fun "SDL_AddSurfaceAlternateImage" :bool
  (surface (:pointer (:struct surface)))
  (image :pointer))

(defexport-fun "SDL_SurfaceHasAlternateImages" :bool
  (surface (:pointer (:struct surface))))

(defwrap-fun "SDL_GetSurfaceImages" (:pointer (:struct surface))
    (t t)
  (surface (:pointer (:struct surface)))
  (count (:pointer :int) :ret-count '(:struct surface)))

(defexport-fun "SDL_RemoveSurfaceAlternateImages" :void
  (surface (:pointer (:struct surface))))

(defexport-fun "SDL_LockSurface" :bool
  (surface (:pointer (:struct surface))))

(defexport-fun "SDL_UnlockSurface" :void
  (surface (:pointer (:struct surface))))

(defexport-fun ("SDL_LoadBMP_IO" load-bmp-io) (:pointer (:struct surface))
  (src :pointer)
  (closeio :bool))

(defexport-fun ("SDL_LoadBMP" load-bmp) (:pointer (:struct surface))
  (file :string))

(defexport-fun ("SDL_SaveBMP_IO" save-bmp-io) :bool
  (surface (:pointer (:struct surface)))
  (dst :pointer)
  (closeio :bool))

(defexport-fun ("SDL_SaveBMP" save-bmp) :bool
  (surface (:pointer (:struct surface)))
  (file :string))

(defexport-fun ("SDL_SetSurfaceRLE" set-surface-rle) :bool
  (surface (:pointer (:struct surface)))
  (enabled :bool))

(defexport-fun ("SDL_SurfaceHasRLE" surface-has-rle) :bool
  (surface (:pointer (:struct surface))))

(defexport-fun "SDL_SetSurfaceColorKey" :bool
  (surface (:pointer (:struct surface)))
  (enabled :bool)
  (key :uint32))

(defexport-fun "SDL_SurfaceHasColorKey" :bool
  (surface (:pointer (:struct surface))))

(defwrap-fun "SDL_GetSurfaceColorKey" :bool
    (t t)
  (surface (:pointer (:struct surface)))
  (key (:pointer :uint32) :direction :output))

(defexport-fun "SDL_SetSurfaceColorMod" :bool
  (surface (:pointer (:struct surface)))
  (r :uint8)
  (g :uint8)
  (b :uint8))

(defwrap-fun "SDL_GetSurfaceColorMod" :bool
    (t t)
  (surface (:pointer (:struct surface)))
  (r (:pointer :uint8) :direction :output)
  (g (:pointer :uint8) :direction :output)
  (b (:pointer :uint8) :direction :output))

(defexport-fun "SDL_SetSurfaceAlphaMod" :bool
  (surface (:pointer (:struct surface)))
  (alpha :uint8))

(defexport-fun "SDL_GetSurfaceAlphaMod" :bool
  (surface (:pointer (:struct surface)))
  (alpha (:pointer :uint8)))

(defexport-fun "SDL_SetSurfaceBlendMode" :bool
  (surface (:pointer (:struct surface)))
  (mode blend-mode))

(defwrap-fun "SDL_GetSurfaceBlendMode" :bool
    (t t)
  (surface (:pointer (:struct surface)))
  (mode (:pointer blend-mode) :direction :output))

(defwrap-fun "SDL_SetSurfaceClipRect" :bool
    (t t)
  (surface (:pointer (:struct surface)))
  (rect (:pointer (:struct rect)) :direction :input))

(defwrap-fun "SDL_GetSurfaceClipRect" :bool
    (t t)
  (surface (:pointer (:struct surface)))
  (rect (:pointer (:struct rect)) :direction :output))

(defexport-fun "SDL_FlipSurface" :bool
  (surface (:pointer (:struct surface)))
  (flip flip-mode))

(defexport-fun "SDL_DuplicateSurface" :pointer
  (surface (:pointer (:struct surface))))

(defexport-fun "SDL_ScaleSurface" :pointer
  (surface (:pointer (:struct surface)))
  (width :int)
  (height :int)
  (mode scale-mode))

(defexport-fun "SDL_ConvertSurface" :pointer
  (surface (:pointer (:struct surface)))
  (fmt pixel-format))

(defexport-fun "SDL_ConvertSurfaceAndColorspace" :pointer
  (surface (:pointer (:struct surface)))
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
  (surface (:pointer (:struct surface)))
  (liner :bool))

(defexport-fun "SDL_ClearSurface" :bool
  (surface (:pointer (:struct surface)))
  (r :float)
  (g :float)
  (b :float)
  (a :float))

(defwrap-fun "SDL_FillSurfaceRect" :bool
    (t t)
  (surface (:pointer (:struct surface)))
  (rect (:pointer (:struct rect)) :direction :input)
  (color :uint32))

(defwrap-fun "SDL_FillSurfaceRects" :bool
    (t t)
  (surface (:pointer (:struct surface)))
  (rect (:pointer (:struct rect)) :direction :input :bind-count count)
  (count :int :bind-val rect)
  (color :uint32))

(defwrap-fun "SDL_BlitSurface" :bool
    (t t)
  (ssurface (:pointer (:struct surface)))
  (srect (:pointer (:struct rect)) :direction :input)
  (dsurface (:pointer (:struct surface)))
  (drect (:pointer (:struct rect)) :direction :input))

(defwrap-fun "SDL_BlitSurfaceUnchecked" :bool
    (t t)
  (ssurface (:pointer (:struct surface)))
  (srect (:pointer (:struct rect)) :direction :input)
  (dsurface (:pointer (:struct surface)))
  (drect (:pointer (:struct rect)) :direction :input))

(defwrap-fun "SDL_BlitSurfaceScaled" :bool
    (t t)
  (ssurface (:pointer (:struct surface)))
  (srect (:pointer (:struct rect)) :direction :input)
  (dsurface (:pointer (:struct surface)))
  (drect (:pointer (:struct rect)) :direction :input)
  (mode scale-mode))

(defwrap-fun "SDL_BlitSurfaceUncheckedScaled" :bool
    (t t)
  (ssurface (:pointer (:struct surface)))
  (srect (:pointer (:struct rect)) :direction :input)
  (dsurface (:pointer (:struct surface)))
  (drect (:pointer (:struct rect)) :direction :input)
  (mode scale-mode))

(defwrap-fun "SDL_BlitSurfaceTiled" :bool
    (t t)
  (ssurface (:pointer (:struct surface)))
  (srect (:pointer (:struct rect)) :direction :input)
  (dsurface (:pointer (:struct surface)))
  (drect (:pointer (:struct rect)) :direction :input))

(defwrap-fun "SDL_BlitSurfaceTiledWithScale" :bool
    (t t)
  (ssurface (:pointer (:struct surface)))
  (srect (:pointer (:struct rect)) :direction :input)
  (scale :float)
  (mode scale-mode)
  (dsurface (:pointer (:struct surface)))
  (drect (:pointer (:struct rect)) :direction :input))

(defwrap-fun "SDL_BlitSurface9Grid" :bool
    (t t)
  (ssurface (:pointer (:struct surface)))
  (srect (:pointer (:struct rect)) :direction :input)
  (left-widht :int)
  (right-widht :int)
  (top-height :int)
  (button-height :int)
  (scale :float)
  (mode scale-mode)
  (dsurface (:pointer (:struct surface)))
  (drect (:pointer (:struct rect)) :direction :input))

(defexport-fun ("SDL_MapSurfaceRGB" map-surface-rgb) :uint32
  (surface (:pointer (:struct surface)))
  (r :uint8)
  (g :uint8)
  (b :uint8))

(defexport-fun ("SDL_MapSurfaceRGBA" map-surface-rgba) :uint32
  (surface (:pointer (:struct surface)))
  (r :uint8)
  (g :uint8)
  (b :uint8)
  (a :uint8))

(defwrap-fun "SDL_ReadSurfacePixel" :bool
    (t t)
  (surface (:pointer (:struct surface)))
  (x :int)
  (y :int)
  (r (:pointer :uint8) :direcion :output)
  (g (:pointer :uint8) :direcion :output)
  (b (:pointer :uint8) :direcion :output)
  (a (:pointer :uint8) :direcion :output))

(defwrap-fun "SDL_ReadSurfacePixelFloat" :bool
    (t t)
  (surface (:pointer (:struct surface)))
  (x :int)
  (y :int)
  (r (:pointer :float) :direction :output)
  (g (:pointer :float) :direction :output)
  (b (:pointer :float) :direction :output)
  (a (:pointer :float) :direction :output))

(defexport-fun "SDL_WriteSurfacePixel" :bool
  (surface (:pointer (:struct surface)))
  (x :int)
  (y :int)
  (r :uint8)
  (g :uint8)
  (b :uint8)
  (a :uint8))

(defexport-fun "SDL_WriteSurfacePixelFloat" :bool
  (surface (:pointer (:struct surface)))
  (x :int)
  (y :int)
  (r :float)
  (g :float)
  (b :float)
  (a :float))
