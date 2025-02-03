(in-package :sdl3)

(cffi:defcenum texture-access
  :static
  :streaming
  :target)

(deflsp-type texture
  (format pixel-format)
  (w :int)
  (h :int)
  (refcount :int))

(cffi:defcenum renderer-logical-presentation
  :disabled
  :stretch
  :letterbox
  :overscan
  :integer_scale)

(deflsp-type vertex
  (position (:struct fpoint))
  (color (:struct fcolor))
  (tex-coord (:struct fpoint)))

(defconstant +renderer-name-string+                               "SDL.renderer.name")
(defconstant +renderer-window-pointer+                            "SDL.renderer.window")
(defconstant +renderer-surface-pointer+                           "SDL.renderer.surface")
(defconstant +renderer-vsync-number+                              "SDL.renderer.vsync")
(defconstant +renderer-max-texture-size-number+                   "SDL.renderer.max_texture_size")
(defconstant +renderer-texture-formats-pointer+                   "SDL.renderer.texture_formats")
(defconstant +renderer-output-colorspace-number+                  "SDL.renderer.output_colorspace")
(defconstant +renderer-hdr-enabled-boolean+                       "SDL.renderer.HDR_enabled")
(defconstant +renderer-sdr-white-point-float+                     "SDL.renderer.SDR_white_point")
(defconstant +renderer-hdr-headroom-float+                        "SDL.renderer.HDR_headroom")
(defconstant +renderer-d3d9-device-pointer+                       "SDL.renderer.d3d9.device")
(defconstant +renderer-d3d11-device-pointer+                      "SDL.renderer.d3d11.device")
(defconstant +renderer-d3d11-swapchain-pointer+                   "SDL.renderer.d3d11.swap_chain")
(defconstant +renderer-d3d12-device-pointer+                      "SDL.renderer.d3d12.device")
(defconstant +renderer-d3d12-swapchain-pointer+                   "SDL.renderer.d3d12.swap_chain")
(defconstant +renderer-d3d12-command-queue-pointer+               "SDL.renderer.d3d12.command_queue")
(defconstant +renderer-vulkan-instance-pointer+                   "SDL.renderer.vulkan.instance")
(defconstant +renderer-vulkan-surface-number+                     "SDL.renderer.vulkan.surface")
(defconstant +renderer-vulkan-physical-device-pointer+            "SDL.renderer.vulkan.physical_device")
(defconstant +renderer-vulkan-device-pointer+                     "SDL.renderer.vulkan.device")
(defconstant +renderer-vulkan-graphics-queue-family-index-number+ "SDL.renderer.vulkan.graphics_queue_family_index")
(defconstant +renderer-vulkan-present-queue-family-index-number+  "SDL.renderer.vulkan.present_queue_family_index")
(defconstant +renderer-vulkan-swapchain-image-count-number+       "SDL.renderer.vulkan.swapchain_image_count")
(defconstant +renderer-gpu-device-pointer+                        "SDL.renderer.gpu.device")

(export '+renderer-name-string+)
(export '+renderer-window-pointer+)
(export '+renderer-surface-pointer+)
(export '+renderer-vsync-number+)
(export '+renderer-max-texture-size-number+)
(export '+renderer-texture-formats-pointer+)
(export '+renderer-output-colorspace-number+)
(export '+renderer-hdr-enabled-boolean+)
(export '+renderer-sdr-white-point-float+)
(export '+renderer-hdr-headroom-float+)
(export '+renderer-d3d9-device-pointer+)
(export '+renderer-d3d11-device-pointer+)
(export '+renderer-d3d11-swapchain-pointer+)
(export '+renderer-d3d12-device-pointer+)
(export '+renderer-d3d12-swapchain-pointer+)
(export '+renderer-d3d12-command-queue-pointer+)
(export '+renderer-vulkan-instance-pointer+)
(export '+renderer-vulkan-surface-number+)
(export '+renderer-vulkan-physical-device-pointer+)
(export '+renderer-vulkan-device-pointer+)
(export '+renderer-vulkan-graphics-queue-family-index-number+)
(export '+renderer-vulkan-present-queue-family-index-number+)
(export '+renderer-vulkan-swapchain-image-count-number+)
(export '+renderer-gpu-device-pointer+)
