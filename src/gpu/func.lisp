(in-package :sdl3)

(defexport-fun "SDL_GPUSupportsShaderFormats" :bool
  (fmt-flags gpu-shader-format)
  (name :string))

(defexport-fun "SDL_GPUSupportsProperties" :bool
  (props properties-id))

(defexport-fun "SDL_CreateGPUDevice" :pointer
  (fmt-flags gpu-shader-format)
  (debug-mode :bool)
  (name :string))

(defexport-fun "SDL_CreateGPUDeviceWithProperties" :pointer
  (props properties-id))

(defexport-fun "SDL_DestroyGPUDevice" :void
  (device :pointer))

(defexport-fun "SDL_GetNumGPUDrivers" :int)

(defexport-fun "SDL_GetGPUDriver" :string
  (index :int))

(defexport-fun "SDL_GetGPUDeviceDriver" :string
  (device :pointer))

(defexport-fun "SDL_GetGPUShaderFormats" gpu-shader-format
  (device :pointer))

(defexport-fun "SDL_CreateGPUComputePipeline" :pointer
  (device :pointer)
  (createinfo (:pointer (:struct gpu-compute-pipeline-create-info))))

(defexport-fun "SDL_CreateGPUGraphicsPipeline" :pointer
  (device :pointer)
  (createinfo (:pointer (:struct gpu-graphics-pipeline-create-info))))

(defexport-fun "SDL_CreateGPUSampler" :pointer
  (device :pointer)
  (createinfo (:pointer (:struct gpu-sampler-create-info))))

(defexport-fun "SDL_CreateGPUShader" :pointer
  (device :pointer)
  (createinfo (:pointer (:struct gpu-shader-create-info))))

(defexport-fun "SDL_CreateGPUTexture" :pointer
  (device :pointer)
  (createinfo (:pointer (:struct gpu-texture-create-info))))

(defexport-fun "SDL_CreateGPUBuffer" :pointer
  (device :pointer)
  (createinfo (:pointer (:struct gpu-buffer-create-info))))

(defexport-fun "SDL_CreateGPUTransferBuffer" :pointer
  (device :pointer)
  (createinfo (:pointer (:struct gpu-transfer-buffer-create-info))))

(defexport-fun "SDL_SetGPUBufferName" :void
  (device :pointer)
  (buffer :pointer)
  (text :string))

(defexport-fun "SDL_SetGPUTextureName" :void
  (device :pointer)
  (texture :pointer)
  (text :string))

(defexport-fun "SDL_InsertGPUDebugLabel" :void
  (command-buffer :pointer)
  (text :string))

(defexport-fun "SDL_PushGPUDebugGroup" :void
  (command-buffer :pointer)
  (name :string))

(defexport-fun "SDL_PopGPUDebugGroup" :void
  (command-buffer :pointer))

(defexport-fun "SDL_ReleaseGPUTexture" :void
  (device :pointer)
  (texture :pointer))

(defexport-fun "SDL_ReleaseGPUSampler" :void
  (device :pointer)
  (sampler :pointer))

(defexport-fun "SDL_ReleaseGPUBuffer" :void
  (device :pointer)
  (buffer :pointer))

(defexport-fun "SDL_ReleaseGPUTransferBuffer" :void
  (device :pointer)
  (transfer-buffer :pointer))

(defexport-fun "SDL_ReleaseGPUComputePipeline" :void
  (device :pointer)
  (compute-pipeline :pointer))

(defexport-fun "SDL_ReleaseGPUShader" :void
  (device :pointer)
  (shader :pointer))

(defexport-fun "SDL_ReleaseGPUGraphicsPipeline" :void
  (device :pointer)
  (graphics-pipeline :pointer))

(defexport-fun "SDL_AcquireGPUCommandBuffer" :pointer
  (device :pointer))

(defexport-fun "SDL_PushGPUVertexUniformData" :void
  (command-buffer :pointer)
  (slot-index :uint32)
  (data :pointer)
  (length :uint32))

(defexport-fun "SDL_PushGPUFragmentUniformData" :void
  (command-buffer :pointer)
  (slot-index :uint32)
  (data :pointer)
  (length :uint32))

(defexport-fun "SDL_PushGPUComputeUniformData" :void
  (command-buffer :pointer)
  (slot-index :uint32)
  (data :pointer)
  (length :uint32))

(defexport-fun "SDL_BeginGPURenderPass" :pointer
  (command-buffer :pointer)
  (color-target-infos (:pointer (:struct gpu-color-tage-info)))
  (num-color-targets :uint32)
  (depth-stencil-target-info (:pointer gpu-depth-stencil-target-info)))

(defexport-fun "SDL_BindGPUGraphicsPipeline" :void
  (render-pass :pointer)
  (graphics-pipeline :pointer))

(defexport-fun "SDL_SetGPUViewport" :void
  (render-pass :pointer)
  (viewport (:pointer (:struct gpu-viewport))))

(defexport-fun "SDL_SetGPUScissor" :void
  (render-pass :pointer)
  (scissor (:pointer (:struct rect))))

(defexport-fun "SDL_SetGPUBlendConstants" :void
  (render-pass :pointer)
  (blend-constants (:struct fcolor)))

(defexport-fun "SDL_SetGPUStencilReference" :void
  (render-pass :pointer)
  (reference :uint8))

(defexport-fun "SDL_BindGPUVertexBuffers" :void
  (render-pass :pointer)
  (first-slot :uint32)
  (bindings (:pointer (:struct gpu-buffer-binding)))
  (num-bindings :uint32))

(defexport-fun "SDL_BindGPUIndexBuffer" :void
  (render-pass :pointer)
  (binding (:pointer (:struct gpu-buffer-binding)))
  (index-element-size gpu-index-element-size))

(defexport-fun "SDL_BindGPUVertexSamplers" :void
  (render-pass :pointer)
  (first-slot :uint32)
  (texture-sampler-bindings (:pointer (:struct gpu-texture-sampler-binding)))
  (num-bindings :uint32))

(defexport-fun "SDL_BindGPUVertexStorageTextures" :void
  (render-pass :pointer)
  (first-slot :uint32)
  (storage-textures (:pointer :pointer))
  (num-bindings :uint32))

(defexport-fun "SDL_BindGPUVertexStorageBuffers" :void
  (render-pass :pointer)
  (first-slot :uint32)
  (storage-buffers (:pointer :pointer))
  (num-bindings :uint32))

(defexport-fun "SDL_BindGPUFragmentSamplers" :void
  (render-pass :pointer)
  (first-slot :uint32)
  (texture-sampler-bindings (:pointer (:struct gpu-texture-sampler-binding)))
  (num-bindings :uint32))

(defexport-fun "SDL_BindGPUFragmentStorageTextures" :void
  (render-pass :pointer)
  (first-slot :uint32)
  (storage-textures (:pointer :pointer))
  (num-bindings :uint32))

(defexport-fun "SDL_BindGPUFragmentStorageBuffers" :void
  (render-pass :pointer)
  (first-slot :uint32)
  (storage-buffers (:pointer :pointer))
  (num-bindings :uint32))

(defexport-fun "SDL_DrawGPUIndexedPrimitives" :void
  (render-pass :pointer)
  (num-indices :uint32)
  (num-instances :uint32)
  (first-index :uint32)
  (vertex-offset :int32)
  (first-instance :uint32))

(defexport-fun "SDL_DrawGPUPrimitives" :void
  (render-pass :pointer)
  (num-vertices :uint32)
  (num-instances :uint32)
  (first-vertex :uint32)
  (first-instance :uint32))

(defexport-fun "SDL_DrawGPUPrimitivesIndirect" :void
  (render-pass :pointer)
  (buffer :pointer)
  (offset :uint32)
  (draw-count :uint32))

(defexport-fun "SDL_DrawGPUIndexedPrimitivesIndirect" :void
  (render-pass :pointer)
  (buffer :pointer)
  (offset :uint32)
  (draw-count :uint32))

(defexport-fun "SDL_EndGPURenderPass" :void
  (render-pass :pointer))

(defexport-fun "SDL_BeginGPUComputePass" :pointer
  (command-buffer :pointer)
  (storage-texture-bindings
   (:pointer (:struct gpu-storage-texture-read-write-binding)))
  (num-storage-texture-bindings :uint32)
  (storage-buffer-bindings (:pointer (:struct gpu-storage-buffer-read-write-binding)))
  (num-storage-buffer-bindings :uint32))

(defexport-fun "sdl_bindgpucomputepipeline" :void
  (compute-pass :pointer)
  (compute-pipeline :pointer))

(defexport-fun "SDL_BindGPUComputeSamplers" :void
  (compute-pass :pointer)
  (first-slot :uint32)
  (texture-sampler-bindings (:pointer (:struct gpu-texture-sampler-binding)))
  (num-bindings :uint32))

(defexport-fun "SDL_BindGPUComputeStorageTextures" :void
  (compute-pass :pointer)
  (first-slot :uint32)
  (storage-textures (:pointer :pointer))
  (num-bindings :uint32))

(defexport-fun "SDL_BindGPUComputeStorageBuffers" :void
  (compute-pass :pointer)
  (first-slot :uint32)
  (storage-buffers (:pointer :pointer))
  (num-bindings :uint32))

(defexport-fun "SDL_DispatchGPUCompute" :void
  (compute-pass :pointer)
  (groupcount-x :uint32)
  (groupcount-y :uint32)
  (groupcount-z :uint32))

(defexport-fun "SDL_DispatchGPUComputeIndirect" :void
  (compute-pass :pointer)
  (buffer :pointer)
  (offset :uint32))

(defexport-fun "SDL_EndGPUComputePass" :void
  (compute-pass :pointer))

(defexport-fun "SDL_MapGPUTransferBuffer" (:pointer :void)
  (device :pointer)
  (transfer-buffer :pointer)
  (cycle :bool))

(defexport-fun "SDL_UnmapGPUTransferBuffer" :void
  (device :pointer)
  (transfer-buffer :pointer))

(defexport-fun "SDL_BeginGPUCopyPass" :pointer
  (command-buffer :pointer))

(defexport-fun "SDL_UploadToGPUTexture" :void
  (copy-pass :pointer)
  (source (:pointer (:struct gpu-texture-transfer-info)))
  (destination (:pointer (:struct gpu-texture-region)))
  (cycle :bool))

(defexport-fun "SDL_UploadToGPUBuffer" :void
  (copy-pass :pointer)
  (source (:pointer (:struct gpu-transfer-buffer-location)))
  (destination (:pointer (:struct gpu-buffer-region)))
  (cycle :bool))

(defexport-fun "SDL_CopyGPUTextureToTexture" :void
  (copy-pass :pointer)
  (source (:pointer (:struct gpu-texture-location)))
  (destination (:pointer (:struct gpu-texture-location)))
  (w :uint32)
  (h :uint32)
  (d :uint32)
  (cycle :bool))

(defexport-fun "SDL_CopyGPUBufferToBuffer" :void
  (copy-pass :pointer)
  (source (:pointer (:struct gpu-buffer-location)))
  (destination (:pointer (:struct gpu-buffer-location)))
  (size :uint32)
  (cycle :bool))

(defexport-fun "SDL_DownloadFromGPUTexture" :void
  (copy-pass :pointer)
  (source (:pointer (:struct gpu-texture-region)))
  (destination (:pointer (:struct gpu-texture-transfer-info))))

(defexport-fun "SDL_DownloadFromGPUBuffer" :void
  (copy-pass :pointer)
  (source (:pointer (:struct gpu-buffer-region)))
  (destination (:pointer (:struct gpu-transfer-buffer-location))))

(defexport-fun "SDL_EndGPUCopyPass" :void
  (copy-pass :pointer))

(defexport-fun "SDL_GenerateMipmapsForGPUTexture" :void
  (command-buffer :pointer)
  (texture :pointer))

(defexport-fun "SDL_BlitGPUTexture" :void
  (command-buffer :pointer)
  (info (:pointer (:struct gpu-blit-info))))

(defexport-fun "SDL_WindowSupportsGPUSwapchainComposition" :bool
  (device :pointer)
  (window :pointer)
  (swapchain-composition gpu-swapchain-composition))

(defexport-fun "SDL_WindowSupportsGPUPresentMode" :bool
  (device :pointer)
  (window :pointer)
  (present-mode gpu-present-mode))

(defexport-fun "SDL_ClaimWindowForGPUDevice" :bool
  (device :pointer)
  (window :pointer))

(defexport-fun "SDL_ReleaseWindowFromGPUDevice" :void
  (device :pointer)
  (window :pointer))

(defexport-fun "SDL_SetGPUSwapchainParameters" :bool
  (device :pointer)
  (window :pointer)
  (swapchain-composition gpu-swapchain-composition)
  (present-mode gpu-present-mode))

(defexport-fun "SDL_SetGPUAllowedFramesInFlight" :bool
  (device :pointer)
  (allowed-frames-in-flight :uint32))

(defexport-fun "SDL_GetGPUSwapchainTextureFormat" gpu-texture-format
  (device :pointer)
  (window :pointer))

(defexport-fun "SDL_AcquireGPUSwapchainTexture" :bool
  (command-buffer :pointer)
  (window :pointer)
  (swapchain-texture (:pointer :pointer))
  (swapchain-texture-width (:pointer :uint32))
  (swapchain-texture-height (:pointer :uint32)))

(defexport-fun "SDL_WaitForGPUSwapchain" :bool
  (device :pointer)
  (window :pointer))

(defexport-fun "SDL_WaitAndAcquireGPUSwapchainTexture" :bool
  (command-buffer :pointer)
  (window :pointer)
  (swapchain-texture (:pointer :pointer))
  (swapchain-texture-width (:pointer :uint32))
  (swapchain-texture-height (:pointer :uint32)))

(defexport-fun "SDL_SubmitGPUCommandBuffer" :bool
  (command-buffer :pointer))

(defexport-fun "SDL_SubmitGPUCommandBufferAndAcquireFence" :pointer
  (command-buffer :pointer))

(defexport-fun "SDL_CancelGPUCommandBuffer" :bool
  (command-buffer :pointer))

(defexport-fun "SDL_WaitForGPUIdle" :bool
  (device :pointer))

(defexport-fun "SDL_WaitForGPUFences" :bool
  (device :pointer)
  (wait-all :bool)
  (fences (:pointer :pointer))
  (num-fences :uint32))

(defexport-fun "SDL_QueryGPUFence" :bool
  (device :pointer)
  (fence :pointer))

(defexport-fun "SDL_ReleaseGPUFence" :void
  (device :pointer)
  (fence :pointer))

(defexport-fun "gpu-texture-formatTexelBlockSize" :uint32
  (fmt gpu-texture-format))

(defexport-fun "SDL_GPUTextureSupportsFormat" :bool
  (device :pointer)
  (fmt gpu-texture-format)
  (type gpu-texture-type)
  (usage gpu-texture-usage-flags))

(defexport-fun "SDL_GPUTextureSupportsSampleCount" :bool
  (device :pointer)
  (fmt gpu-texture-format)
  (sample-count gpu-sample-count))

(defexport-fun "SDL_CalculateGPUTextureFormatSize" :uint32
  (fmt gpu-texture-format)
  (width :uint32)
  (height :uint32)
  (depth-or-layer-count :uint32))

(defexport-fun ("SDL_GDKSuspendGPU" gdk-suspend-gpu) :void
  (device :pointer))

(defexport-fun ("SDL_GDKResumeGPU" gdk-resump-gpu) :void
  (device :pointer))

