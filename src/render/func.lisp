(in-package :sdl3)

(defexport-fun "SDL_GetNumRenderDrivers" :int)

(defexport-fun "SDL_GetRenderDriver" :string 
  (index :int))

(defwrap-fun "SDL_CreateWindowAndRenderer" :bool
    (t t)
  (title :string)
  (width :int)
  (height :int)
  (flags window-flags)
  (window (:pointer :pointer) :direction :output)
  (renderer (:pointer :pointer) :direction :output))

(defexport-fun "SDL_CreateRenderer" :pointer
  (window :pointer)
  (name :string))

(defexport-fun "SDL_CreateRendererWithProperties" :pointer
  (id properties-id))

(defexport-fun "SDL_CreateSoftwareRenderer" :pointer
  (surface (:pointer (:struct surface))))

(defexport-fun "SDL_GetRenderer" :pointer
  (window :pointer))

(defexport-fun "SDL_GetRenderWindow" :pointer
  (render :pointer))

(defexport-fun "SDL_GetRendererName" :string
  (render :pointer))

(defexport-fun "SDL_GetRendererProperties" properties-id
  (render :pointer))

(defwrap-fun "SDL_GetRenderOutputSize" :bool
    (t t)
  (render :pointer)
  (w (:pointer :int) :direction :output)
  (h (:pointer :int) :direction :output))

(defwrap-fun "SDL_GetCurrentRenderOutputSize" :bool
    (t t)
  (render :pointer)
  (w (:pointer :int) :direction :output)
  (h (:pointer :int) :direction :output))

;; we process texture as an object so don't wrap texture funcstion
(defexport-fun "SDL_CreateTexture" (:pointer (:struct texture))
  (render :pointer)
  (fmt pixel-format)
  (access texture-access)
  (w :int)
  (h :int))

(defexport-fun "SDL_CreateTextureFromSurface" (:pointer (:struct texture))
  (render :pointer)
  (surface (:pointer (:struct surface))))

(defexport-fun "SDL_CreateTextureWithProperties" (:pointer (:struct texture))
  (render :pointer)
  (id properties-id))

(defexport-fun "SDL_GetTextureProperties" properties-id
  (texture (:pointer (:struct texture))))

(defexport-fun "SDL_GetRendererFromTexture" :pointer
  (texture (:pointer (:struct texture))))

(defwrap-fun "SDL_GetTextureSize" :bool
    (t t)
  (texture (:pointer (:struct texture)))
  (w (:pointer :float) :direction :output)
  (h (:pointer :float) :direction :output))

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

(defwrap-fun "SDL_GetTextureColorMod" :bool
    (t t)
  (texture (:pointer (:struct texture)))
  (r (:pointer :uint8) :direction :output)
  (g (:pointer :uint8) :direction :output)
  (b (:pointer :uint8) :direction :output))
(defwrap-fun "SDL_GetTextureColorModFloat" :bool
    (t t)
  (texture (:pointer (:struct texture)))
  (r (:pointer :float) :direction :output)
  (g (:pointer :float) :direction :output)
  (b (:pointer :float) :direction :output))

(defexport-fun "SDL_SetTextureAlphaMod" :bool
  (texture (:pointer (:struct texture)))
  (alpha :uint8))
(defexport-fun "SDL_SetTextureAlphaModFloat" :bool
  (texture (:pointer (:struct texture)))
  (alpha :float))
(defwrap-fun "SDL_GetTextureAlphaMod" :bool
    (t t)
  (texture (:pointer (:struct texture)))
  (alpha (:pointer :uint8) :direction :output))
(defwrap-fun "SDL_GetTextureAlphaModFloat" :bool
    (t t)
  (texture (:pointer (:struct texture)))
  (alpha (:pointer :float) :direction :output))

(defexport-fun "SDL_SetTextureBlendMode" :bool
  (texture (:pointer (:struct texture)))
  (mode blend-mode))
(defwrap-fun "SDL_GetTextureBlendMode" :bool
    (t t)
  (texture (:pointer (:struct texture)))
  (mode (:pointer blend-mode) :direction :output))

(defexport-fun "SDL_SetTextureScaleMode" :bool
  (texture (:pointer (:struct texture)))
  (mode scale-mode))
(defwrap-fun "SDL_GetTextureScaleMode" :bool
    (t t)
  (texture (:pointer (:struct texture)))
  (mode (:pointer scale-mode) :direction :output))

(defwrap-fun "SDL_UpdateTexture" :bool
    (t t)
  (texture (:pointer (:struct texture)))
  (rect (:pointer (:struct rect)) :direction :input)
  (pixels :pointer)
  (pitch :int))

(defwrap-fun "SDL_UpdateYUVTexture" :bool
    (t t)
  (texture (:pointer (:struct texture)))
  (rect (:pointer (:struct rect)) :direction :input)
  (yplane (:pointer :uint8) :direction :input :bind-count ypitch)
  (ypitch :int :bind-val yplane)
  (uplane (:pointer :uint8) :direction :input :bind-count upitch)
  (upitch :int :bind-val uplane)
  (vplane (:pointer :uint8) :direction :input :bind-count vpitch)
  (vpitch :int :bind-val vplane))
(defwrap-fun "SDL_UpdateNVTexture" :bool
    (t t)
  (texture (:pointer (:struct texture)))
  (rect (:pointer (:struct rect)) :direction :input)
  (yplane (:pointer :uint8) :direction :input :bind-count ypitch)
  (ypitch :int :bind-val yplane)
  (uvplane (:pointer :uint8) :direction :input :bind-count uvpitch)
  (uvpitch :int :bind-val uvplane))

(defwrap-fun "SDL_LockTexture" :bool
    (t t)
  (texture (:pointer (:struct texture)))
  (rect (:pointer (:struct rect)) :direction :input)
  (pixels (:pointer :pointer))
  (pitch (:pointer :int)))

(defwrap-fun "SDL_LockTextureToSurface" :bool
    (t t)
  (texture (:pointer (:struct texture)))
  (rect (:pointer (:struct rect)) :direction :input)
  (psurface (:pointer (:pointer (:struct surface))) :direction :output))

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

(defwrap-fun "SDL_GetRenderLogicalPresentation" :bool
    (t t)
  (renderer :pointer)
  (w (:pointer :int) :direction :output)
  (h (:pointer :int) :direction :output)
  (mode (:pointer renderer-logical-presentation) :direction :output))

(defwrap-fun "SDL_GetRenderLogicalPresentationRect" :bool
    (t t)
  (renderer :pointer)
  (rect (:pointer (:struct rect)) :direction :output))

(defwrap-fun "SDL_RenderCoordinatesFromWindow" :bool
    (t t)
  (renderer :pointer)
  (window-x :float)
  (window-y :float)
  (x (:pointer :float) :direction :output)
  (y (:pointer :float) :direction :output))

(defwrap-fun "SDL_RenderCoordinatesToWindow" :bool
    (t t)
  (renderer :pointer)
  (x :float)
  (y :float)
  (window-x (:pointer :float) :direction :output)
  (window-y (:pointer :float) :direction :output))

(defwrap-fun "SDL_SetRenderViewport" :bool
    (t t)
  (renderer :pointer)
  (rect (:pointer (:struct rect)) :direction :input))

(defwrap-fun "SDL_GetRenderViewport" :bool
    (t t)
  (renderer :pointer)
  (rect (:pointer (:struct rect)) :direction :output))

(defexport-fun "SDL_RenderViewportSet" :bool
  (renderer :pointer))

(defwrap-fun "SDL_GetRenderSafeArea" :bool
    (t t)
  (renderer :pointer)
  (rect (:pointer (:struct rect)) :direction :output))

(defwrap-fun "SDL_SetRenderClipRect" :bool
    (t t)
  (renderer :pointer)
  (rect (:pointer (:struct rect)) :direction :input))

(defwrap-fun "SDL_GetRenderClipRect" :bool
    (t t)
  (renderer :pointer)
  (rect (:pointer (:struct rect)) :direction :output))

(defexport-fun "SDL_RenderClipEnabled" :bool
  (renderer :pointer))

(defexport-fun "SDL_SetRenderScale" :bool
  (renderer :pointer)
  (x :float)
  (y :float))

(defwrap-fun "SDL_GetRenderScale" :bool
    (t t)
  (renderer :pointer)
  (x (:pointer :float) :direction :output)
  (y (:pointer :float) :direction :output))

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

(defwrap-fun "SDL_GetRenderDrawColor" :bool
    (t t)
  (renderer :pointer)
  (r (:pointer :uint8) :direction :output)
  (g (:pointer :uint8) :direction :output)
  (b (:pointer :uint8) :direction :output)
  (a (:pointer :uint8) :direction :output))

(defwrap-fun "SDL_GetRenderDrawColorFloat" :bool
    (t t)
  (renderer :pointer)
  (r (:pointer :float) :direction :output)
  (g (:pointer :float) :direction :output)
  (b (:pointer :float) :direction :output)
  (a (:pointer :float) :direction :output))

(defexport-fun "SDL_SetRenderColorScale" :bool
  (renderer :pointer)
  (mode scale-mode))
(defwrap-fun "SDL_GetRenderColorScale" :bool
    (t t)
  (renderer :pointer)
  (mode (:pointer scale-mode) :direction :output))

(defexport-fun "SDL_SetRenderDrawBlendMode" :bool
  (renderer :pointer)
  (mode blend-mode))
(defwrap-fun "SDL_GetRenderDrawBlendMode" :bool
    (t t)
  (renderer :pointer)
  (mode (:pointer blend-mode) :direction :output))

(defexport-fun "SDL_RenderClear" :bool
  (renderer :pointer))

(defexport-fun "SDL_RenderPoint" :bool
  (renderer :pointer)
  (x :float)
  (y :float))
(defwrap-fun "SDL_RenderPoints" :bool
    (t)
  (renderer :pointer)
  (points (:pointer (:struct fpoint)) :direction :input :bind-count count)
  (count :int :bind-val points))

(defexport-fun "SDL_RenderLine" :bool
  (renderer :pointer)
  (x0 :float)
  (y0 :float)
  (x1 :float)
  (y1 :float))
(defwrap-fun "SDL_RenderLines" :bool
    (t t)
  (renderer :pointer)
  (points (:pointer (:struct fpoint)) :direction :input :bind-count count)
  (count :int :bind-val points))

(defwrap-fun "SDL_RenderRect" :bool
    (t t)
  (renderer :pointer)
  (rect (:pointer (:struct frect)) :direction :input))
(defwrap-fun "SDL_RenderRects" :bool
    (t t)
  (renderer :pointer)
  (rects (:pointer (:struct frect)) :direction :input :bind-count count)
  (count :int :bind-val rects))
(defwrap-fun "SDL_RenderFillRect" :bool
    (t t)
  (renderer :pointer)
  (rect (:pointer (:struct frect)) :direction :input))
(defwrap-fun "SDL_RenderFillRects" :bool
    (t t)
  (renderer :pointer)
  (rects (:pointer (:struct frect)) :direction :input :bind-count count)
  (count :int :bind-val rects))

(defwrap-fun "SDL_RenderTexture" :bool
    (t t)
  (renderer :pointer)
  (texture (:pointer (:struct texture)))
  (src (:pointer (:struct frect)) :direction :input)
  (dst (:pointer (:struct frect)) :direction :input))
(defwrap-fun "SDL_RenderTextureRotated" :bool
    (t t)
  (renderer :pointer)
  (texture (:pointer (:struct texture)))
  (src (:pointer (:struct frect)) :direction :input)
  (dst (:pointer (:struct frect)) :direction :input)
  (angle :double)
  (center (:pointer (:struct fpoint)) :direction :input)
  (flip flip-mode))
(defwrap-fun "SDL_RenderTextureAffine" :bool
    (t t)
  (renderer :pointer)
  (texture (:pointer (:struct texture)))
  (src (:pointer (:struct frect)) :direction :input)
  (right (:pointer (:struct fpoint)) :direction :input)
  (origin (:pointer (:struct fpoint)) :direction :input))
(defwrap-fun "SDL_RenderTextureTiled" :bool
    (t t)
  (renderer :pointer)
  (texture (:pointer (:struct texture)))
  (src (:pointer (:struct frect)) :direction :input)
  (scale :double)
  (dst (:pointer (:struct frect)) :direction :input))
(defwrap-fun "SDL_RenderTexture9Grid" :bool
    (renderer :pointer)
  (texture (:pointer (:struct texture)))
  (left-widht :float)
  (right-widht :float)
  (top-height :float)
  (button-height :float)
  (scale :double)
  (dst (:pointer (:struct frect)) :direction :input))

(defwrap-fun "SDL_RenderGeometry" :bool
    (t t)
  (renderer :pointer)
  (texture (:pointer (:struct texture)))
  (vertices (:pointer (:struct vertex)) :direction :input :bind-count num-vertices)
  (num-vertices :int :bind-val vertices)
  (indices (:pointer :int) :direction :input :bind-count num-indices)
  (num-indices :int :bind-val indices))
(defwrap-fun "SDL_RenderGeometryRaw" :bool
    (t t)
  (renderer :pointer)
  (texture (:pointer (:struct texture)))
  (xy (:pointer :float) :direction :input :bind-count xy-stride)
  (xy-stride :int :bind-val xy)
  (color (:pointer (:struct fcolor)) :direction :input :bind-count color-stride)
  (color-stride :int :bind-val color)
  (uv (:pointer :float) :direction :input :bind-count uv-stride)
  (uv-stride :int :bind-val uv)
  (num-vertices :int)
  (indices :pointer)
  (num-indices :int)
  (size-indices :int))

(defwrap-fun "SDL_RenderReadPixels" (:pointer (:struct surface))
    (t t)
  (renderer :pointer)
  (rect (:pointer (:struct rect)) :direction :input))

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
(defwrap-fun "SDL_GetRenderVSync" :bool
    (t t)
  (renderer :pointer)
  (vsync (:pointer :int) :direction :output))

(defexport-fun "SDL_RenderDebugText" :bool
  (renderer :pointer)
  (x :float)
  (y :float)
  (str :string))

