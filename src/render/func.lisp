(in-package :sdl3)

(defexport-fun "SDL_GetNumRenderDrivers" :int)

(defexport-fun "SDL_GetRenderDriver" :string 
  (index :int))

(defwrap-fun "SDL_CreateWindowAndRenderer" :bool ()
  (title :string)
  (width :int)
  (height :int)
  (flags window-flags)
  (window (:pointer :pointer))
  (renderer (:pointer :pointer)))

(defexport-fun "SDL_CreateRenderer" :pointer
  (window :pointer)
  (name :string))

(defexport-fun "SDL_CreateRendererWithProperties" :pointer
  (id properties-id))

(defexport-fun "SDL_CreateSoftwareRenderer" :pointer
  (surface :pointer))

(defexport-fun "SDL_GetRenderer" :pointer
  (window :pointer))

(defexport-fun "SDL_GetRenderWindow" :pointer
  (render :pointer))

(defexport-fun "SDL_GetRendererName" :string
  (render :pointer))

(defexport-fun "SDL_GetRendererProperties" properties-id
  (render :pointer))

(defexport-fun "SDL_GetRenderOutputSize" :bool
  (render :pointer)
  (w (:pointer :int))
  (h (:pointer :int)))

(defexport-fun "SDL_GetCurrentRenderOutputSize" :bool
  (render :pointer)
  (w (:pointer :int))
  (h (:pointer :int)))

(defexport-fun "SDL_CreateTexture" (:pointer (:struct texture))
  (render :pointer)
  (fmt pixel-format)
  (access texture-access)
  (w :int)
  (h :int))

(defexport-fun "SDL_CreateTextureFromSurface" (:pointer (:struct texture))
  (render :pointer)
  (surface :pointer))

(defexport-fun "SDL_CreateTextureWithProperties" (:pointer (:struct texture))
  (render :pointer)
  (id properties-id))

(defexport-fun "SDL_GetTextureProperties" properties-id
  (texture (:pointer (:struct texture))))

(defexport-fun "SDL_GetRendererFromTexture" :pointer
  (texture (:pointer (:struct texture))))

(defexport-fun "SDL_GetTextureSize" :bool
  (texture (:pointer (:struct texture)))
  (w (:pointer :float))
  (h (:pointer :float)))

(defexport-fun "SDL_SetTextureColorMod" :bool
  (texture (:pointer (:struct texture)))
  (r :uint8)
  (g :uint8)
  (b :uint8))
(defexport-fun "SDL_SetTextureColorModFloat" :bool
  (texture (:pointer (:struct texture)))
  (r :float)
  (g :float)
  (b :float))

(defexport-fun "SDL_GetTextureColorMod" :bool
  (texture (:pointer (:struct texture)))
  (r (:pointer :uint8))
  (g (:pointer :uint8))
  (b (:pointer :uint8)))
(defexport-fun "SDL_GetTextureColorModFloat" :bool
  (texture (:pointer (:struct texture)))
    (r (:pointer :float))
  (g (:pointer :float))
  (b (:pointer :float)))

(defexport-fun "SDL_SetTextureAlphaMod" :bool
  (texture (:pointer (:struct texture)))
  (alpha :uint8))
(defexport-fun "SDL_SetTextureAlphaModFloat" :bool
  (texture (:pointer (:struct texture)))
  (alpha :float))
(defexport-fun "SDL_GetTextureAlphaMod" :bool
  (texture (:pointer (:struct texture)))
  (alpha (:pointer :uint8)))
(defexport-fun "SDL_GetTextureAlphaModFloat" :bool
  (texture (:pointer (:struct texture)))
  (alpha (:pointer :float)))

(defexport-fun "SDL_SetTextureBlendMode" :bool
  (texture (:pointer (:struct texture)))
  (mode blend-mode))
(defexport-fun "SDL_GetTextureBlendMode" :bool
  (texture (:pointer (:struct texture)))
  (mode (:pointer blend-mode)))

(defexport-fun "SDL_SetTextureScaleMode" :bool
  (texture (:pointer (:struct texture)))
  (mode scale-mode))
(defexport-fun "SDL_GetTextureScaleMode" :bool
  (texture (:pointer (:struct texture)))
  (mode (:pointer scale-mode)))

(defexport-fun "SDL_UpdateTexture" :bool
  (texture (:pointer (:struct texture)))
  (rect (:pointer (:struct rect)))
  (pixels :pointer)
  (pitch :int))

(defexport-fun ("SDL_UpdateYUVTexture" update-yuv-texture) :bool
  (texture (:pointer (:struct texture)))
  (rect (:pointer (:struct rect)))
  (yplane (:pointer :uint8))
  (ypitch :int)
  (uplane (:pointer :uint8))
  (upitch :int)
  (vplane (:pointer :uint8))
  (vpitch :int))
(defexport-fun ("SDL_UpdateNVTexture" update-nvt-texture) :bool
  (texture (:pointer (:struct texture)))
  (rect (:pointer (:struct rect)))
  (yplane (:pointer :uint8))
  (ypitch :int)
  (uvplane (:pointer :uint8))
  (uvpitch :int))

(defexport-fun "SDL_LockTexture" :bool
  (texture (:pointer (:struct texture)))
  (rect (:pointer (:struct rect)))
  (pixels (:pointer :pointer))
  (pitch (:pointer :int)))

(defexport-fun "SDL_LockTextureToSurface" :bool
  (texture (:pointer (:struct texture)))
  (rect (:pointer (:struct rect)))
  (psurface (:pointer :pointer)))

(defexport-fun "SDL_UnlockTexture" :void
  (texture (:pointer (:struct texture))))

(defexport-fun "SDL_SetRenderTarget" :bool
  (renderer :pointer)
  (texture (:pointer (:struct texture))))

(defexport-fun "SDL_GetRenderTarget" (:pointer (:struct texture))
  (renderer :pointer))

(defexport-fun "SDL_SetRenderLogicalPresentation" :bool
  (renderer :pointer)
  (w :int)
  (h :int)
  (mode renderer-logical-presentation))

(defexport-fun "SDL_GetRenderLogicalPresentation" :bool
  (renderer :pointer)
  (w (:pointer :int))
  (h (:pointer :int))
  (mode (:pointer renderer-logical-presentation)))

(defexport-fun "SDL_GetRenderLogicalPresentationRect" :bool
  (renderer :pointer)
  (rect (:pointer (:struct rect))))

(defexport-fun "SDL_RenderCoordinatesFromWindow" :bool
  (renderer :pointer)
  (window-x :float)
  (window-y :float)
  (x (:pointer :float))
  (y (:pointer :float)))

(defexport-fun "SDL_RenderCoordinatesToWindow" :bool
  (renderer :pointer)
  (x :float)
  (y :float)
  (window-x (:pointer :float))
  (window-y (:pointer :float)))

(defexport-fun "SDL_SetRenderViewport" :bool
  (renderer :pointer)
  (rect (:pointer (:struct rect))))

(defexport-fun "SDL_GetRenderViewport" :bool
  (renderer :pointer)
  (rect (:pointer (:struct rect))))

(defexport-fun "SDL_RenderViewportSet" :bool
  (renderer :pointer))

(defexport-fun "SDL_GetRenderSafeArea" :bool
  (renderer :pointer)
  (rect (:pointer (:struct rect))))

(defexport-fun "SDL_SetRenderClipRect" :bool
  (renderer :pointer)
  (rect (:pointer (:struct rect))))

(defexport-fun "SDL_GetRenderClipRect" :bool
  (renderer :pointer)
  (rect (:pointer (:struct rect))))

(defexport-fun "SDL_RenderClipEnabled" :bool
  (renderer :pointer))

(defexport-fun "SDL_SetRenderScale" :bool
  (renderer :pointer)
  (x :float)
  (y :float))

(defexport-fun "SDL_GetRenderScale" :bool
  (renderer :pointer)
  (x (:pointer :float))
  (y (:pointer :float)))

(defexport-fun "SDL_SetRenderDrawColor" :bool
  (renderer :pointer)
  (r :uint8)
  (g :uint8)
  (b :uint8)
  (a :uint8))

(defexport-fun "SDL_SetRenderDrawColorFloat" :bool
  (renderer :pointer)
  (r :float)
  (g :float)
  (b :float)
  (a :float))

(defexport-fun "SDL_GetRenderDrawColor" :bool
  (renderer :pointer)
  (r (:pointer :uint8))
  (g (:pointer :uint8))
  (b (:pointer :uint8))
  (a (:pointer :uint8)))

(defexport-fun "SDL_GetRenderDrawColorFloat" :bool
  (renderer :pointer)
  (r (:pointer :float))
  (g (:pointer :float))
  (b (:pointer :float))
  (a (:pointer :float)))

(defexport-fun "SDL_SetRenderColorScale" :bool
  (renderer :pointer)
  (mode scale-mode))
(defexport-fun "SDL_GetRenderColorScale" :bool
  (renderer :pointer)
  (mode (:pointer scale-mode)))

(defexport-fun "SDL_SetRenderDrawBlendMode" :bool
  (renderer :pointer)
  (mode blend-mode))
(defexport-fun "SDL_GetRenderDrawBlendMode" :bool
  (renderer :pointer)
  (mode (:pointer blend-mode)))

(defexport-fun "SDL_RenderClear" :bool
  (renderer :pointer))

(defexport-fun "SDL_RenderPoint" :bool
  (renderer :pointer)
  (x :float)
  (y :float))
(defwrap-fun "SDL_RenderPoints" :bool (:render-multi fpoint)
  (renderer :pointer)
  (points (:pointer (:struct fpoint)))
  (count :int))

(defexport-fun "SDL_RenderLine" :bool
  (renderer :pointer)
  (x0 :float)
  (y0 :float)
  (x1 :float)
  (y1 :float))
(defwrap-fun "SDL_RenderLines" :bool (:render-multi fpoint)
  (renderer :pointer)
  (points (:pointer (:struct fpoint)))
  (count :int))

(defwrap-fun "SDL_RenderRect" :bool (:render-single frect)
  (renderer :pointer)
  (rect (:pointer (:struct frect))))
(defwrap-fun "SDL_RenderRects" :bool (:render-multi frect)
  (renderer :pointer)
  (rects (:pointer (:struct frect)))
  (count :int))
(defwrap-fun "SDL_RenderFillRect" :bool (:render-single frect)
  (renderer :pointer)
  (rects (:pointer (:struct frect))))
(defwrap-fun "SDL_RenderFillRects" :bool (:render-multi frect)
  (renderer :pointer)
  (rects (:pointer (:struct frect)))
  (count :int))

(defexport-fun "SDL_RenderTexture" :bool
  (renderer :pointer)
  (texture (:pointer (:struct texture)))
  (src (:pointer (:struct frect)))
  (dst (:pointer (:struct frect))))
(defexport-fun "SDL_RenderTextureRotated" :bool
  (renderer :pointer)
  (texture (:pointer (:struct texture)))
  (src (:pointer (:struct frect)))
  (dst (:pointer (:struct frect)))
  (angle :double)
  (center (:pointer (:struct fpoint)))
  (flip flip-mode))
(defexport-fun "SDL_RenderTextureAffine" :bool
  (renderer :pointer)
  (texture (:pointer (:struct texture)))
  (src (:pointer (:struct frect)))
  (right (:pointer (:struct fpoint)))
  (origin (:pointer (:struct fpoint))))
(defexport-fun "SDL_RenderTextureTiled" :bool
  (renderer :pointer)
  (texture (:pointer (:struct texture)))
  (src (:pointer (:struct frect)))
  (scale :double)
  (dst (:pointer (:struct frect))))
(defexport-fun "SDL_RenderTexture9Grid" :bool
  (renderer :pointer)
  (texture (:pointer (:struct texture)))
  (left-widht :float)
  (right-widht :float)
  (top-height :float)
  (button-height :float)
  (scale :double)
  (dst (:pointer (:struct frect))))

(defexport-fun "SDL_RenderGeometry" :bool
  (renderer :pointer)
  (texture (:pointer (:struct texture)))
  (vertices (:pointer (:struct vertex)))
  (num-vertices :int)
  (indices (:pointer :int))
  (num-indices :int))
(defexport-fun "SDL_RenderGeometryRaw" :bool
  (renderer :pointer)
  (texture (:pointer (:struct texture)))
  (xy (:pointer :float))
  (xy-stride :int)
  (color (:pointer (:struct fcolor)))
  (color-stride :int)
  (uv (:pointer :float))
  (uv-stride :int)
  (num-vertices :int)
  (indices :pointer)
  (num-indices :int)
  (size-indices :int))

(defexport-fun "SDL_RenderReadPixels" :pointer
  (renderer :pointer)
  (rect (:pointer (:struct rect))))

(defexport-fun "SDL_RenderPresent" :bool
  (renderer :pointer))

(defexport-fun "SDL_DestroyTexture" :void
  (texture (:pointer (:struct texture))))

(defexport-fun "SDL_DestroyRenderer" :void
  (renderer :pointer))

(defexport-fun "SDL_FlushRenderer" :bool
  (renderer :pointer))
(defexport-fun "SDL_GetRenderMetalLayer" :pointer
  (renderer :pointer))

(defexport-fun "SDL_GetRenderMetalCommandEncoder" :pointer
  (renderer :pointer))

(defexport-fun "SDL_AddVulkanRenderSemaphores" :bool
  (renderer :pointer)
  (wait-stage-mask :uint32)
  (wait-semaphre :int64)
  (signal-semaphore :int64))

(defexport-fun "SDL_SetRenderVSync" :bool
  (renderer :pointer)
  (vsync :int))
(defexport-fun "SDL_GetRenderVSync" :bool
  (renderer :pointer)
  (vsync (:pointer :int)))

(defexport-fun "SDL_RenderDebugText" :bool
  (renderer :pointer)
  (x :float)
  (y :float)
  (str :string))

