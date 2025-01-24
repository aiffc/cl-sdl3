(in-package :sdl3)

(cffi:defctype vk-surface-khr
  #. (if (= 8 (cffi:foreign-type-size :pointer))
	 :pointer
	 :uint64))

(defexport-fun ("SDL_Vulkan_LoadLibrary" vulkan-load-library) :bool
  (path :string))

(defexport-fun ("SDL_Vulkan_GetVkGetInstanceProcAddr" vulkan-get-vk-get-instance-proc-addr)  :pointer)

(defexport-fun ("SDL_Vulkan_UnloadLibrary" vulkan-unload-library) :void)

(defexport-fun ("SDL_Vulkan_GetInstanceExtensions" vulkan-get-instance-extensions) (:pointer :string)
  (count :uint32))

(defexport-fun ("SDL_Vulkan_CreateSurface" vulkan-create-surface) :bool
  (window :pointer)
  (instance :pointer)
  (allocator :pointer)
  (surface (:pointer vk-surface-khr)))

(defexport-fun ("SDL_Vulkan_DestroySurface" vulkan-destroy-surface) :void
  (instance :pointer)
  (surface vk-surface-khr)
  (allocator :pointer))

(defexport-fun ("SDL_Vulkan_GetPresentationSupport" vulkan-get-presentation-support) :bool
  (instance :pointer)
  (physical-device :pointer)
  (queue-family-index :uint32))
