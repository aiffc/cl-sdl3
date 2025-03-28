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

(defwrap-fun "SDL_CreateGPUComputePipeline" :pointer
    (t t)
  (device :pointer)
  (createinfo (:pointer (:struct gpu-compute-pipeline-create-info)) :direction :input))

(defwrap-fun "SDL_CreateGPUGraphicsPipeline" :pointer
    (t t)
  (device :pointer)
  (createinfo (:pointer (:struct gpu-graphics-pipeline-create-info)) :direction :input))

(defwrap-fun "SDL_CreateGPUSampler" :pointer
    (t t)
  (device :pointer)
  (createinfo (:pointer (:struct gpu-sampler-create-info)) :direction :input))

(defwrap-fun "SDL_CreateGPUShader" :pointer
    (t t)
  (device :pointer)
  (createinfo (:pointer (:struct gpu-shader-create-info)) :direction :input))

(defwrap-fun "SDL_CreateGPUTexture" :pointer
    (t t)
  (device :pointer)
  (createinfo (:pointer (:struct gpu-texture-create-info)) :direction :input))

(defwrap-fun "SDL_CreateGPUBuffer" :pointer
    (t t)
  (device :pointer)
  (createinfo (:pointer (:struct gpu-buffer-create-info)) :direction :input))

(defwrap-fun "SDL_CreateGPUTransferBuffer" :pointer
    (t t)
  (device :pointer)
  (createinfo (:pointer (:struct gpu-transfer-buffer-create-info)) :direction :input))

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

(defwrap-fun "SDL_BeginGPURenderPass" :pointer
    (t t)
  (command-buffer :pointer)
  (color-target-infos (:pointer (:struct gpu-color-target-info)) :direction :input :bind-count num-color-targets)
  (num-color-targets :uint32 :bind-val color-target-infos)
  (depth-stencil-target-info (:pointer (:struct gpu-depth-stencil-target-info)) :direction :input))

(defexport-fun "SDL_BindGPUGraphicsPipeline" :void
  (render-pass :pointer)
  (graphics-pipeline :pointer))

(defwrap-fun "SDL_SetGPUViewport" :void
    (t t)
  (render-pass :pointer)
  (viewport (:pointer (:struct gpu-viewport)) :direction :input))

(defwrap-fun "SDL_SetGPUScissor" :void
    (t t)
  (render-pass :pointer)
  (scissor (:pointer (:struct rect)) :direction :input))

(defexport-fun "SDL_SetGPUBlendConstants" :void
  (render-pass :pointer)
  (blend-constants (:struct fcolor)))

(defexport-fun "SDL_SetGPUStencilReference" :void
  (render-pass :pointer)
  (reference :uint8))

(defwrap-fun "SDL_BindGPUVertexBuffers" :void
    (t t)
  (render-pass :pointer)
  (first-slot :uint32)
  (bindings (:pointer (:struct gpu-buffer-binding)) :direction :input :bind-count num-bindings)
  (num-bindings :uint32 :bind-val bindings))

(defwrap-fun "SDL_BindGPUIndexBuffer" :void
    (t t)
  (render-pass :pointer)
  (binding (:pointer (:struct gpu-buffer-binding)) :direction :input :bind-count index-element-size)
  (index-element-size gpu-index-element-size :bind-val binding))

(defwrap-fun "SDL_BindGPUVertexSamplers" :void
    (t t)
  (render-pass :pointer)
  (first-slot :uint32)
  (texture-sampler-bindings (:pointer (:struct gpu-texture-sampler-binding)) :direction :input :bind-count num-bindings)
  (num-bindings :uint32 :bind-val texture-sampler-bindings))

(defexport-fun "SDL_BindGPUVertexStorageTextures" :void
  (render-pass :pointer)
  (first-slot :uint32)
  (storage-textures (:pointer :pointer))
  (num-bindings :uint32))

(defwrap-fun "SDL_BindGPUVertexStorageBuffers" :void
    (t t)
  (render-pass :pointer)
  (first-slot :uint32)
  (storage-buffers (:pointer :pointer) :direction :input :bind-count num-bindings)
  (num-bindings :uint32 :bind-val storage-buffers))

(defwrap-fun "SDL_BindGPUFragmentSamplers" :void
    (t t)
  (render-pass :pointer)
  (first-slot :uint32)
  (texture-sampler-bindings (:pointer (:struct gpu-texture-sampler-binding)) :direction :input :bind-count num-bindings)
  (num-bindings :uint32 :bind-val texture-sampler-bindings))

(defwrap-fun "SDL_BindGPUFragmentStorageTextures" :void
    (t t)
  (render-pass :pointer)
  (first-slot :uint32)
  (storage-textures (:pointer :pointer) :direction :input :bind-count num-bindings)
  (num-bindings :uint32 :bind-val storage-textures))

(defwrap-fun "SDL_BindGPUFragmentStorageBuffers" :void
    (t t)
  (render-pass :pointer)
  (first-slot :uint32)
  (storage-buffers (:pointer :pointer) :direction :input :bind-count num-bindings)
  (num-bindings :uint32 :bind-val storage-buffers))

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

(defwrap-fun "SDL_BeginGPUComputePass" :pointer
    (t t)
  (command-buffer :pointer)
  (storage-texture-bindings
   (:pointer (:struct gpu-storage-texture-read-write-binding))
   :direction :input :bind-count num-storage-texture-bindings)
  (num-storage-texture-bindings :uint32 :bind-val storage-texture-bindings)
  (storage-buffer-bindings (:pointer (:struct gpu-storage-buffer-read-write-binding))
			   :direction :input :bind-count num-storage-buffer-bindings)
  (num-storage-buffer-bindings :uint32 :bind-val storage-buffer-bindings))

(defexport-fun "sdl_bindgpucomputepipeline" :void
  (compute-pass :pointer)
  (compute-pipeline :pointer))

(defwrap-fun "SDL_BindGPUComputeSamplers" :void
    (t t)
  (compute-pass :pointer)
  (first-slot :uint32)
  (texture-sampler-bindings (:pointer (:struct gpu-texture-sampler-binding)) :direction :input :bind-count num-bindings)
  (num-bindings :uint32 :bind-val texture-sampler-bindings))

(defwrap-fun "SDL_BindGPUComputeStorageTextures" :void
    (t t)
  (compute-pass :pointer)
  (first-slot :uint32)
  (storage-textures (:pointer :pointer) :direction :input :bind-count num-bindings)
  (num-bindings :uint32 :bind-val storage-textures))

(defwrap-fun "SDL_BindGPUComputeStorageBuffers" :void
    (t t)
  (compute-pass :pointer)
  (first-slot :uint32)
  (storage-buffers (:pointer :pointer) :direction :input :bind-count num-bindings)
  (num-bindings :uint32 :bind-val storage-buffers))

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

(defwrap-fun "SDL_UploadToGPUTexture" :void
    (t t)
  (copy-pass :pointer)
  (source (:pointer (:struct gpu-texture-transfer-info)) :direction :input)
  (destination (:pointer (:struct gpu-texture-region)) :direction :input)
  (cycle :bool))

(defwrap-fun "SDL_UploadToGPUBuffer" :void
    (t t)
  (copy-pass :pointer)
  (source (:pointer (:struct gpu-transfer-buffer-location)) :direction :input)
  (destination (:pointer (:struct gpu-buffer-region)) :direction :input)
  (cycle :bool))

(defwrap-fun "SDL_CopyGPUTextureToTexture" :void
    (t t)
  (copy-pass :pointer)
  (source (:pointer (:struct gpu-texture-location)) :direction :input)
  (destination (:pointer (:struct gpu-texture-location)) :direction :input)
  (w :uint32)
  (h :uint32)
  (d :uint32)
  (cycle :bool))

(defwrap-fun "SDL_CopyGPUBufferToBuffer" :void
    (t t)
  (copy-pass :pointer)
  (source (:pointer (:struct gpu-buffer-location)) :direction :input)
  (destination (:pointer (:struct gpu-buffer-location)) :direction :input)
  (size :uint32)
  (cycle :bool))

(defwrap-fun "SDL_DownloadFromGPUTexture" :void
    (t t)
  (copy-pass :pointer)
  (source (:pointer (:struct gpu-texture-region)) :direction :input)
  (destination (:pointer (:struct gpu-texture-transfer-info)) :direction :input))

(defwrap-fun "SDL_DownloadFromGPUBuffer" :void
    (t t)
  (copy-pass :pointer)
  (source (:pointer (:struct gpu-buffer-region)) :direction :input)
  (destination (:pointer (:struct gpu-transfer-buffer-location)) :direction :input))

(defexport-fun "SDL_EndGPUCopyPass" :void
  (copy-pass :pointer))

(defexport-fun "SDL_GenerateMipmapsForGPUTexture" :void
  (command-buffer :pointer)
  (texture :pointer))

(defwrap-fun "SDL_BlitGPUTexture" :void
    (t t)
  (command-buffer :pointer)
  (info (:pointer (:struct gpu-blit-info)) :direction :input))

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

(defwrap-fun "SDL_AcquireGPUSwapchainTexture" :bool
    (t t)
  (command-buffer :pointer)
  (window :pointer)
  (swapchain-texture (:pointer :pointer) :direction :output)
  (swapchain-texture-width (:pointer :uint32) :direction :output)
  (swapchain-texture-height (:pointer :uint32) :direction :output))

(defexport-fun "SDL_WaitForGPUSwapchain" :bool
  (device :pointer)
  (window :pointer))

(defwrap-fun "SDL_WaitAndAcquireGPUSwapchainTexture" :bool
    (t t)
  (command-buffer :pointer)
  (window :pointer)
  (swapchain-texture (:pointer :pointer) :direction :output)
  (swapchain-texture-width (:pointer :uint32) :direction :output)
  (swapchain-texture-height (:pointer :uint32) :direction :output))

(defexport-fun "SDL_SubmitGPUCommandBuffer" :bool
  (command-buffer :pointer))

(defexport-fun "SDL_SubmitGPUCommandBufferAndAcquireFence" :pointer
  (command-buffer :pointer))

(defexport-fun "SDL_CancelGPUCommandBuffer" :bool
  (command-buffer :pointer))

(defexport-fun "SDL_WaitForGPUIdle" :bool
  (device :pointer))

(defwrap-fun "SDL_WaitForGPUFences" :bool
    (t t)
  (device :pointer)
  (wait-all :bool)
  (fences (:pointer :pointer) :direction :input :bind-count num-fences)
  (num-fences :uint32 :bind-val fences))

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

(defexport-fun "SDL_GDKSuspendGPU" :void
  (device :pointer))

(defexport-fun "SDL_GDKResumeGPU" :void
  (device :pointer))

