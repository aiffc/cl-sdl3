(in-package :sdl3)

(defctype vk-surface-khr
  #. (if (= 8 (cffi:foreign-type-size :pointer))
	 :pointer
	 :uint64))

(defexport-fun "SDL_Vulkan_LoadLibrary" :bool
  (path :string))

(defexport-fun "SDL_Vulkan_GetVkGetInstanceProcAddr"  :pointer)

(defexport-fun "SDL_Vulkan_UnloadLibrary" :void)

(defexport-fun "SDL_Vulkan_GetInstanceExtensions" (:pointer :string)
  (count :uint32))

(defexport-fun "SDL_Vulkan_CreateSurface" :bool
  (window :pointer)
  (instance :pointer)
  (allocator :pointer)
  (surface (:pointer vk-surface-khr)))

(defexport-fun "SDL_Vulkan_DestroySurface" :void
  (instance :pointer)
  (surface vk-surface-khr)
  (allocator :pointer))

(defexport-fun "SDL_Vulkan_GetPresentationSupport" :bool
  (instance :pointer)
  (physical-device :pointer)
  (queue-family-index :uint32))
