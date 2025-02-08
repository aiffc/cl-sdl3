(in-package :sdl3)

(defcenum texture-access
  :static
  :streaming
  :target)

(deflsp-type texture
  (format pixel-format)
  (w :int)
  (h :int)
  (refcount :int))

(defcenum renderer-logical-presentation
  :disabled
  :stretch
  :letterbox
  :overscan
  :integer_scale)

(deflsp-type vertex
  (position (:struct fpoint))
  (color (:struct fcolor))
  (tex-coord (:struct fpoint)))

(alexandria:define-constant +renderer-name-string+                               "SDL.renderer.name" :test #'string=)
(alexandria:define-constant +renderer-window-pointer+                            "SDL.renderer.window" :test #'string=)
(alexandria:define-constant +renderer-surface-pointer+                           "SDL.renderer.surface" :test #'string=)
(alexandria:define-constant +renderer-vsync-number+                              "SDL.renderer.vsync" :test #'string=)
(alexandria:define-constant +renderer-max-texture-size-number+                   "SDL.renderer.max_texture_size" :test #'string=)
(alexandria:define-constant +renderer-texture-formats-pointer+                   "SDL.renderer.texture_formats" :test #'string=)
(alexandria:define-constant +renderer-output-colorspace-number+                  "SDL.renderer.output_colorspace" :test #'string=)
(alexandria:define-constant +renderer-hdr-enabled-boolean+                       "SDL.renderer.HDR_enabled" :test #'string=)
(alexandria:define-constant +renderer-sdr-white-point-float+                     "SDL.renderer.SDR_white_point" :test #'string=)
(alexandria:define-constant +renderer-hdr-headroom-float+                        "SDL.renderer.HDR_headroom" :test #'string=)
(alexandria:define-constant +renderer-d3d9-device-pointer+                       "SDL.renderer.d3d9.device" :test #'string=)
(alexandria:define-constant +renderer-d3d11-device-pointer+                      "SDL.renderer.d3d11.device" :test #'string=)
(alexandria:define-constant +renderer-d3d11-swapchain-pointer+                   "SDL.renderer.d3d11.swap_chain" :test #'string=)
(alexandria:define-constant +renderer-d3d12-device-pointer+                      "SDL.renderer.d3d12.device" :test #'string=)
(alexandria:define-constant +renderer-d3d12-swapchain-pointer+                   "SDL.renderer.d3d12.swap_chain" :test #'string=)
(alexandria:define-constant +renderer-d3d12-command-queue-pointer+               "SDL.renderer.d3d12.command_queue" :test #'string=)
(alexandria:define-constant +renderer-vulkan-instance-pointer+                   "SDL.renderer.vulkan.instance" :test #'string=)
(alexandria:define-constant +renderer-vulkan-surface-number+                     "SDL.renderer.vulkan.surface" :test #'string=)
(alexandria:define-constant +renderer-vulkan-physical-device-pointer+            "SDL.renderer.vulkan.physical_device" :test #'string=)
(alexandria:define-constant +renderer-vulkan-device-pointer+                     "SDL.renderer.vulkan.device" :test #'string=)
(alexandria:define-constant +renderer-vulkan-graphics-queue-family-index-number+ "SDL.renderer.vulkan.graphics_queue_family_index" :test #'string=)
(alexandria:define-constant +renderer-vulkan-present-queue-family-index-number+  "SDL.renderer.vulkan.present_queue_family_index" :test #'string=)
(alexandria:define-constant +renderer-vulkan-swapchain-image-count-number+       "SDL.renderer.vulkan.swapchain_image_count" :test #'string=)
(alexandria:define-constant +renderer-gpu-device-pointer+                        "SDL.renderer.gpu.device" :test #'string=)

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
