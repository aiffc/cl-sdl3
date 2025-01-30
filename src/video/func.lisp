(in-package :sdl3)

(defexport-fun "SDL_GetNumVideoDrivers" :int)

(defexport-fun "SDL_GetVideoDriver" :string
  (index :int))

(defexport-fun "SDL_GetCurrentVideoDriver" :string)

(defexport-fun "SDL_GetSystemTheme" system-theme)

(defexport-fun "SDL_GetDisplays" (:pointer display-id)
  (count (:pointer :int)))

(defexport-fun "SDL_GetPrimaryDisplay" display-id)

(defexport-fun "SDL_GetDisplayProperties" properties-id
  (id display-id))

(defexport-fun "SDL_GetDisplayName" :string
  (id display-id))

(defwrap-fun "SDL_GetDisplayBounds" :bool
    (t t)
  (id display-id)
  (rect (:pointer (:struct rect)) :direction :output))

(defwrap-fun "SDL_GetDisplayUsableBounds" :bool
    (t t)
  (id display-id)
  (rect (:pointer (:struct rect)) :direction :output))

(defexport-fun "SDL_GetNaturalDisplayOrientation" display-operation
  (id display-id))

(defexport-fun "SDL_GetCurrentDisplayOrientation" display-operation
  (id display-id))

(defexport-fun "SDL_GetDisplayContentScale" :float
  (id display-id))

;; todo
(defexport-fun "SDL_GetFullscreenDisplayModes" (:pointer (:pointer (:struct display-mode)))
  (id display-id)
  (count (:pointer :int)))

(defwrap-fun "SDL_GetClosestFullscreenDisplayMode" :bool
    (t t)
  (id display-id)
  (w :int)
  (h :int)
  (refresh-rate :float)
  (include-high-density-modes :bool)
  (closest (:pointer (:struct display-mode)) :direction :output))

(defwrap-fun "SDL_GetDesktopDisplayMode" (:pointer (:struct display-mode))
    (t t t)
  (id display-id))

(defwrap-fun "SDL_GetCurrentDisplayMode" (:pointer (:struct display-mode))
    (t t t)
  (id display-id))

(defwrap-fun "SDL_GetDisplayForPoint" display-id
    (t t)
  (point (:pointer (:struct point)) :direction :output))

(defwrap-fun "SDL_GetDisplayForRect" display-id
    (t t)
  (rect (:pointer (:struct rect)) :direction :output))

(defexport-fun "SDL_GetDisplayForWindow" display-id
  (window :pointer))

(defexport-fun "SDL_GetWindowPixelDensity" :float
  (window :pointer))

(defexport-fun "SDL_GetWindowDisplayScale" :float
  (window :pointer))

(defexport-fun "SDL_SetWindowFullscreenMode" :bool
  (window :pointer)
  (mode (:pointer (:struct display-mode))))

(defexport-fun ("SDL_GetWindowICCProfile" get-window-icc-profile) :pointer
  (window :pointer)
  (size (:pointer size-t)))

(defexport-fun "SDL_GetWindowPixelFormat" pixel-format
  (window :pointer))

(defwrap-fun "SDL_GetWindows" (:pointer :pointer)
    (t t)
  (count (:pointer :int) :ret-count :pointer))

(defexport-fun "SDL_CreateWindow" :pointer
  (title :string)
  (width :int)
  (height :int)
  (flags window-flags))

(defexport-fun "SDL_CreatePopupWindow" :pointer
  (parent :pointer)
  (x :int)
  (y :int)
  (w :int)
  (h :int)
  (flags window-flags))

(defexport-fun "SDL_CreateWindowWithProperties" :pointer
  (props properties-id))

(defexport-fun ("SDL_GetWindowID" get-window-id) window-id
  (window :pointer))

(defexport-fun ("SDL_GetWindowFromID" get-window-from-id) :pointer
  (id window-id))

(defexport-fun "SDL_GetWindowParent" :pointer
  (window :pointer))

(defexport-fun "SDL_GetWindowProperties" properties-id
  (window :pointer))

(defexport-fun "SDL_GetWindowFlags" window-flags
  (window :pointer))

(defexport-fun "SDL_SetWindowTitle" :bool
  (window :pointer)
  (title :string))

(defexport-fun "SDL_GetWindowTitle" :string
  (window :pointer))

(defwrap-fun "SDL_SetWindowIcon" :bool
    (t t)
  (window :pointer)
  (icon (:pointer (:struct surface)) :direction :input))

(defexport-fun "SDL_SetWindowPosition" :bool
  (window :pointer)
  (x :int)
  (y :int))

(defwrap-fun "SDL_GetWindowPosition" :bool
    (t t)
  (window :pointer)
  (x (:pointer :int) :direction :output)
  (y (:pointer :int) :direction :output))

(defexport-fun "SDL_SetWindowSize" :bool
  (window :pointer)
  (w :int)
  (h :int))

(defwrap-fun "SDL_GetWindowSize" :bool
    (t t)
  (window :pointer)
  (w (:pointer :int) :direction :output)
  (h (:pointer :int) :direction :output))

(defwrap-fun "SDL_GetWindowSafeArea" :bool
    (t t)
  (window :pointer)
  (rect (:pointer (:struct rect)) :direction :output))

(defexport-fun "SDL_SetWindowAspectRatio" :bool
  (window :pointer)
  (min :float)
  (max :float))

(defexport-fun "SDL_GetWindowAspectRatio" :bool
  (window :pointer)
  (min (:pointer :float))
  (max (:pointer :float)))

(defwrap-fun "SDL_GetWindowBordersSize" :bool
  (window :pointer)
  (top (:pointer :int) :direction :output)
  (left (:pointer :int) :direction :output)
  (bottom (:pointer :int) :direction :output)
  (right (:pointer :int) :direction :output))

(defwrap-fun "SDL_GetWindowSizeInPixels" :bool
  (window :pointer)
  (w (:pointer :int) :direction :output)
  (h (:pointer :int) :direction :output))

(defexport-fun "SDL_SetWindowMinimumSize" :bool
  (window :pointer)
  (w :int)
  (h :int))

(defwrap-fun "SDL_GetWindowMinimumSize" :bool
    (t t)
  (window :pointer)
  (w (:pointer :int) :direction :output)
  (h (:pointer :int) :direction :output))

(defexport-fun "SDL_SetWindowMaximumSize" :bool
  (window :pointer)
  (w :int)
  (h :int))

(defwrap-fun "SDL_GetWindowMaximumSize" :bool
    (t t)
  (window :pointer)
  (w (:pointer :int) :direction :output)
  (h (:pointer :int) :direction :output))

(defexport-fun "SDL_SetWindowBordered" :bool
  (window :pointer)
  (bordered :bool))

(defexport-fun "SDL_SetWindowResizable" :bool
  (window :pointer)
  (resizable :bool))

(defexport-fun "SDL_SetWindowAlwaysOnTop" :bool
  (window :pointer)
  (optop :bool))

(defexport-fun "SDL_ShowWindow" :bool
  (window :pointer))

(defexport-fun "SDL_HideWindow" :bool
  (window :pointer))

(defexport-fun "SDL_RaiseWindow" :bool
  (window :pointer))

(defexport-fun "SDL_MaximizeWindow" :bool
  (window :pointer))

(defexport-fun "SDL_MinimizeWindow" :bool
  (window :pointer))

(defexport-fun "SDL_RestoreWindow" :bool
  (window :pointer))

(defexport-fun "SDL_SetWindowFullscreen" :bool
  (window :pointer)
  (fullscreen :bool))

(defexport-fun "SDL_SyncWindow" :bool
  (window :pointer))

(defexport-fun "SDL_WindowHasSurface" :bool
  (window :pointer))

(defwrap-fun "SDL_GetWindowSurface" (:pointer (:struct surface))
    (t t t)
  (window :pointer))

(defexport-fun "SDL_SetWindowSurfaceVSync" :bool
  (window :pointer)
  (vsync :int))

(defwrap-fun "SDL_GetWindowSurfaceVSync" :bool
    (t t)
  (window :pointer)
  (vsync (:pointer :int) :direction :output))

(defexport-fun "SDL_UpdateWindowSurface" :bool
  (window :pointer))

(defwrap-fun "SDL_UpdateWindowSurfaceRects" :bool
    (t t)
  (window :pointer)
  (rect (:pointer (:struct rect)) :direction :input :bind-count numrects)
  (numrects :int :bind-val rect))

(defexport-fun "SDL_DestroyWindowSurface" :bool
  (window :pointer))

(defexport-fun "SDL_SetWindowKeyboardGrab" :bool
  (window :pointer)
  (grabbed :bool))

(defexport-fun "SDL_SetWindowMouseGrab" :bool
  (window :pointer)
  (grabbed :bool))

(defexport-fun "SDL_GetWindowKeyboardGrab" :bool
  (window :pointer))

(defexport-fun "SDL_GetWindowMouseGrab" :bool
  (window :pointer))

(defexport-fun "SDL_GetGrabbedWindow" :pointer)

(defwrap-fun "SDL_SetWindowMouseRect" :bool
    (t t)
  (window :pointer)
  (rect (:pointer (:struct rect)) :direction :input))

(defwrap-fun "SDL_GetWindowMouseRect" (:pointer (:struct rect))
    (t t t)
  (window :pointer))

(defexport-fun "SDL_SetWindowOpacity" :bool
  (window :pointer)
  (opacity :float))

(defexport-fun "SDL_GetWindowOpacity" :float
  (window :pointer))

(defexport-fun "SDL_SetWindowParent" :bool
  (window :pointer)
  (parent :pointer))

(defexport-fun "SDL_SetWindowModal" :bool
  (window :pointer)
  (modal :bool))

(defexport-fun "SDL_SetWindowFocusable" :bool
  (window :pointer)
  (focusable :bool))

(defexport-fun "SDL_ShowWindowSystemMenu" :bool
  (window :pointer)
  (x :int)
  (y :int))

(defexport-fun "SDL_SetWindowHitTest" :bool
  (window :pointer)
  (callback :pointer)
  (data :pointer))

(defwrap-fun "SDL_SetWindowShape" :bool
    (t t)
  (window :pointer)
  (shape (:pointer (:struct surface)) :direction :input))

(defexport-fun "SDL_FlashWindow" :bool
  (window :pointer)
  (operation flash-operation))

(defexport-fun "SDL_DestroyWindow" :void
  (window :pointer))

(defexport-fun "SDL_ScreenSaverEnabled" :bool)

(defexport-fun "SDL_EnableScreenSaver" :bool)

(defexport-fun "SDL_DisableScreenSaver" :bool)

(defexport-fun ("SDL_GL_LoadLibrary" gl-load-library) :bool
  (path :string))

(defexport-fun ("SDL_GL_GetProcAddress" gl-get-proce-address) :pointer
  (proc :string))

(defexport-fun ("SDL_EGL_GetProcAddress" egl-get-proce-address) :pointer
  (proc :string))

(defexport-fun ("SDL_GL_UnloadLibrary" gl-unload-library) :void)

(defexport-fun ("SDL_GL_ExtensionSupported" gl-extensions-supported) :bool
  (extension :string))

(defexport-fun ("SDL_GL_ResetAttributes" gl-reset-attributes) :void)

(defexport-fun ("SDL_GL_SetAttribute" gl-set-attribute) :bool
  (attr glattr)
  (value :int))

(defwrap-fun ("SDL_GL_GetAttribute" gl-get-attribute) :bool
    (t t)
  (attr glattr)
  (value (:pointer :int) :direction :output))

(defexport-fun ("SDL_GL_CreateContext" gl-create-context) :pointer
  (window :pointer))

(defexport-fun ("SDL_GL_MakeCurrent" gl-make-current) :bool
  (window :pointer)
  (context :pointer))

(defexport-fun ("SDL_GL_GetCurrentWindow" gl-get-current-window) :pointer)

(defexport-fun ("SDL_GL_GetCurrentContext" gl-get-current-context) :pointer)

(defexport-fun ("SDL_EGL_GetCurrentDisplay" egl-get-current-display) :pointer)

(defexport-fun ("SDL_EGL_GetCurrentConfig" egl_-get-current-config) :pointer)

(defexport-fun ("SDL_EGL_GetWindowSurface" egl-get-window-surface) :pointer
  (window :pointer))

(defexport-fun ("SDL_EGL_SetAttributeCallbacks" egl-set-attribute-callbacks) :void
  (platformAttribCallback :pointer)
  (surfaceAttribCallback :pointer)
  (contextAttribCallback :pointer)
  (data :pointer))

(defexport-fun ("SDL_GL_SetSwapInterval" gl-set-interval) :bool
  (interval :int))

(defwrap-fun ("SDL_GL_GetSwapInterval" gl-get-swap-interval) :bool
    (t t)
  (interval (:pointer :int) :direction :output))

(defexport-fun ("SDL_GL_SwapWindow" gl-swap-window) :bool
  (window :pointer))

(defexport-fun ("SDL_GL_DestroyContext" gl-destroy-context) :bool
  (content :pointer))
