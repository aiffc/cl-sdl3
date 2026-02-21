(in-package :sdl3)

(defbitfield gpu-shader-format
  (:invalid  #x0)
  (:private  #x1)
  (:spirv    #x2)
  (:dxbc     #x4)
  (:dxil     #x8)
  (:msl      #x16)
  (:metallib #x32))

(deflsp-type gpu-compute-pipeline-create-info
  (code-size size-t)                       
  (code (:pointer :uint8))
  (entrypoint :string)
  (format gpu-shader-format)
  (num-samplers :uint32)
  (num-readonly-storage-textures :uint32)
  (num-readonly-storage-buffers :uint32)
  (num-readwrite-storage-textures :uint32)
  (num-readwrite-storage-buffers :uint32)
  (num-uniform-buffers :uint32)
  (threadcount-x :uint32)
  (threadcount-y :uint32)
  (threadcount-z :uint32)
  (props properties-id))

(defcenum gpu-vertex-input-rate
  :vertex
  :instance)

(deflsp-type gpu-vertex-buffer-description
  (slot :uint32)
  (pitch :uint32)
  (input-rate gpu-vertex-input-rate)
  (instance-step-rate :uint32))

(defcenum gpu-vertex-element-format
  :invalid
  :int
  :int2
  :int3
  :int4
  :uint
  :uint2
  :uint3
  :uint4
  :float
  :float2
  :float3
  :float4
  :byte2
  :byte4
  :ubyte2
  :ubyte4
  :byte2-norm
  :byte4-norm
  :ubyte2-norm
  :ubyte4-norm
  :short2
  :short4
  :ushort2
  :ushort4
  :short2-norm
  :short4-norm
  :ushort2-norm
  :ushort4-norm
  :half2
  :half4)

(deflsp-type gpu-vertex-attribute
  (location :uint32)
  (buffer-slot :uint32)
  (format gpu-vertex-element-format)
  (offset :uint32))

(deflsp-type gpu-vertex-input-state
  (vertex-buffer-descriptions (:pointer (:struct gpu-vertex-buffer-description)))
  (num-vertex-buffers :uint32)
  (vertex-attributes (:pointer (:struct gpu-vertex-attribute)))
  (num-vertex-attributes :uint32))

(defcenum gpu-primitive-type
  :trianglelist
  :trianglestrip
  :linelist
  :linestrip
  :pointlist)

(defcenum gpu-fill-mode
  :fill
  :line)

(defcenum gpu-cull-mode
  :none
  :front
  :back)

(defcenum gpu-front-face
  :counter-clockwise
  :clockwise)

(deflsp-type gpu-rasterizer-state
  (fill-mode gpu-fill-mode)
  (cull-mode gpu-cull-mode)
  (front-face gpu-front-face)
  (depth-bias-constant-factor :float)
  (depth-bias-clamp :float)
  (depth-bias-slope-factor :float)
  (enable-depth-bias :bool)
  (enable-depth-clip :bool)
  (padding1 :uint8)
  (padding2 :uint8))

(defcenum gpu-sample-count
  :1
  :2
  :4
  :8)

(deflsp-type gpu-multisample-state
  (sample-count gpu-sample-count)
  (sample-mask :uint32)
  (enable-mask :bool)
  (padding1 :uint8)
  (padding2 :uint8)
  (padding3 :uint8))

(defcenum gpu-compare-op
  :invalid
  :never
  :less
  :equal
  :less-or-equal
  :greater
  :not-equal
  :greater-or-equal
  :always)

(defcenum gpu-stencil-op
  :invalid
  :keep
  :zero
  :replace
  :increment-and-clamp
  :decrement-and-clamp
  :invert
  :increment-and-wrap
  :decrement-and-wrap)

(deflsp-type gpu-stencil-op-state
  (fail-op gpu-stencil-op)
  (pass-op gpu-stencil-op)
  (depth-fail-op gpu-stencil-op)
  (compare-op gpu-compare-op))

(deflsp-type gpu-depth-stencil-state
  (compare-op gpu-compare-op)
  (back-stencil-state (:struct gpu-stencil-op-state))
  (front-stencil-state (:struct gpu-stencil-op-state))
  (compare-mask :uint8)
  (write-mask :uint8)
  (enable-depth-test :bool)
  (enable-depth-write :bool)
  (enable-stencil-test :bool)
  (padding1 :uint8)
  (padding2 :uint8)
  (padding3 :uint8))

(defcenum gpu-texture-format
  :invalid
  :a8-unorm
  :r8-unorm
  :r8g8-unorm
  :r8g8b8a8-unorm
  :r16-unorm
  :r16g16-unorm
  :r16g16b16a16-unorm
  :r10g10b10a2-unorm
  :b5g6r5-unorm
  :b5g5r5a1-unorm
  :b4g4r4a4-unorm
  :b8g8r8a8-unorm
  :bc1-rgba-unorm
  :bc2-rgba-unorm
  :bc3-rgba-unorm
  :bc4-r-unorm
  :bc5-rg-unorm
  :bc7-rgba-unorm
  :bc6h-rgb-float
  :bc6h-rgb-ufloat
  :r8-snorm
  :r8g8-snorm
  :r8g8b8a8-snorm
  :r16-snorm
  :r16g16-snorm
  :r16g16b16a16-snorm
  :r16-float
  :r16g16-float
  :r16g16b16a16-float
  :r32-float
  :r32g32-float
  :r32g32b32a32-float
  :r11g11b10-ufloat
  :r8-uint
  :r8g8-uint
  :r8g8b8a8-uint
  :r16-uint
  :r16g16-uint
  :r16g16b16a16-uint
  :r32-uint
  :r32g32-uint
  :r32g32b32a32-uint
  :r8-int
  :r8g8-int
  :r8g8b8a8-int
  :r16-int
  :r16g16-int
  :r16g16b16a16-int
  :r32-int
  :r32g32-int
  :r32g32b32a32-int
  :r8g8b8a8-unorm-srgb
  :b8g8r8a8-unorm-srgb
  :bc1-rgba-unorm-srgb
  :bc2-rgba-unorm-srgb
  :bc3-rgba-unorm-srgb
  :bc7-rgba-unorm-srgb
  :d16-unorm
  :d24-unorm
  :d32-float
  :d24-unorm-s8-uint
  :d32-float-s8-uint
  :astc-4x4-unorm
  :astc-5x4-unorm
  :astc-5x5-unorm
  :astc-6x5-unorm
  :astc-6x6-unorm
  :astc-8x5-unorm
  :astc-8x6-unorm
  :astc-8x8-unorm
  :astc-10x5-unorm
  :astc-10x6-unorm
  :astc-10x8-unorm
  :astc-10x10-unorm
  :astc-12x10-unorm
  :astc-12x12-unorm
  :astc-4x4-unorm-srgb
  :astc-5x4-unorm-srgb
  :astc-5x5-unorm-srgb
  :astc-6x5-unorm-srgb
  :astc-6x6-unorm-srgb
  :astc-8x5-unorm-srgb
  :astc-8x6-unorm-srgb
  :astc-8x8-unorm-srgb
  :astc-10x5-unorm-srgb
  :astc-10x6-unorm-srgb
  :astc-10x8-unorm-srgb
  :astc-10x10-unorm-srgb
  :astc-12x10-unorm-srgb
  :astc-12x12-unorm-srgb
  :astc-4x4-float
  :astc-5x4-float
  :astc-5x5-float
  :astc-6x5-float
  :astc-6x6-float
  :astc-8x5-float
  :astc-8x6-float
  :astc-8x8-float
  :astc-10x5-float
  :astc-10x6-float
  :astc-10x8-float
  :astc-10x10-float
  :astc-12x10-float
  :astc-12x12-float)

(defcenum gpu-blend-factor
  :invalid
  :zero
  :one
  :src-color
  :one-minus-src-color
  :dst-color
  :one-minus-dst-color
  :src-alpha
  :one-minus-src-alpha
  :dst-alpha
  :one-minus-dst-alpha
  :constant-color
  :one-minus-constant-color
  :src-alpha-saturate)

(defcenum gpu-blend-op
 :invalid
 :add
 :subtract
 :reverse-subtract
 :min
 :max)

(defbitfield (color-component-flags :uint8)
  (:r #x1)
  (:g #x2)
  (:b #x4)
  (:a #x8))

(deflsp-type gpu-color-target-blend-state
  (src-color-blendfactor gpu-blend-factor)
  (dst-color-blendfactor gpu-blend-factor)
  (color-blend-op gpu-blend-op)
  (src-alpha-blendfactor gpu-blend-factor)
  (dst-alpha-blendfactor gpu-blend-factor)
  (alpha-blend-op gpu-blend-op)
  (color-write-mask color-component-flags)
  (enable-blend :bool)
  (enable-color-write-mask :bool)
  (padding1 :uint8)
  (padding2 :uint8))

(deflsp-type gpu-color-target-description
  (format gpu-texture-format)
  (blend-state (:struct gpu-color-target-blend-state)))

(deflsp-type gpu-graphics-pipeline-target-info
  (color-target-descriptions (:pointer (:struct gpu-color-target-description)))
  (num-color-targets :uint32)
  (depth-stencil-format gpu-texture-format)
  (has-depth-stencil-target :bool)
  (padding1 :uint8)
  (padding2 :uint8)
  (padding3 :uint8))

(deflsp-type gpu-graphics-pipeline-create-info
  (vertex-shader :pointer)
  (fragment-shader :pointer)
  (vertex-input-state (:struct gpu-vertex-input-state))
  (primitive-type gpu-primitive-type)
  (rasterizer-state (:struct gpu-rasterizer-state))
  (multisample-state (:struct gpu-multisample-state))
  (depth-stencil-state (:struct gpu-depth-stencil-state))
  (target-info (:struct gpu-graphics-pipeline-target-info))
  (props properties-id))

(defcenum gpu-filter
  :nearest
  :linear)

(defcenum gpu-sampler-mipmap-mode
  :nearest
  :linear)

(defcenum gpu-sampler-address-mode
  :repeat
  :mirrored-repeat
  :clamp-to-edge)

(deflsp-type gpu-sampler-create-info
  (min-filter gpu-filter)
  (mag-filter gpu-filter)
  (mipmap-mode gpu-sampler-mipmap-mode)
  (address-mode-u  gpu-sampler-mipmap-mode)
  (address-mode-v  gpu-sampler-mipmap-mode)
  (address-mode-w  gpu-sampler-mipmap-mode)
  (mip-lod-bias :float)
  (max-anisotropy :float)
  (compare-op gpu-compare-op)
  (min-lod :float)
  (max-lod :float)
  (enable-anisotropy :bool)
  (enable-compare :bool)
  (padding1 :uint8)
  (padding2 :uint8)
  (props properties-id))

(defcenum gpu-shader-stage
  :vertex
  :fragment)

(deflsp-type gpu-shader-create-info
  (code-size size-t)
  (code (:pointer :uint8))
  (entrypoint :string)
  (format gpu-shader-format)
  (stage gpu-shader-stage)
  (num-samplers :uint32)
  (num-storage-textures :uint32)
  (num-storage-buffers :uint32)
  (num-uniform-buffers :uint32)
  (props properties-id))

(defcenum gpu-texture-type
  :2d
  :2d-array
  :3d
  :cube
  :cube-array)

(defbitfield gpu-texture-usage-flags
  (:sampler                                 #x1)
  (:color-target                            #x2)
  (:depth-stencil-target                    #x4)
  (:graphics-storage-read                   #x8)
  (:compute-storage-read                    #x16)
  (:compute-storage-write                   #x32)
  (:compute-storage-simultaneous-read-write #x64))

(deflsp-type gpu-texture-create-info
  (type gpu-texture-type)
  (format gpu-texture-format)
  (usage gpu-texture-usage-flags)
  (width :uint32)
  (height :uint32)
  (layer-count-or-depth :uint32)
  (num-levels :uint32)
  (sample-count gpu-sample-count)
  (props properties-id))

(defbitfield gpu-buffer-usage-flags
  (:vertex                      #x1)
  (:index                       #x2)
  (:indirect                    #x4)
  (:graphics-storage-read       #x8)
  (:compute-storage-read        #x16)
  (:compute-storage-write       #x32))

(deflsp-type gpu-buffer-create-info
  (usage gpu-buffer-usage-flags)
  (size :uint32)
  (props properties-id))

(defcenum gpu-transfer-buffer-usage
  :upload
  :download)

(deflsp-type gpu-transfer-buffer-create-info
  (usage gpu-transfer-buffer-usage)
  (size :uint32)
  (props properties-id))

(defcenum gpu-load-op
  :load
  :clear
  :dont-care)

(defcenum gpu-store-op
  :store
  :dont-care
  :reslove
  :reslove-and-store)

(deflsp-type gpu-color-target-info
  (texture :pointer)
  (mip-level :uint32)
  (layer-or-depth-plane :uint32)
  (clear-color (:struct fcolor))
  (load-op gpu-load-op)
  (store-op gpu-store-op)
  (resolve-texture :pointer)
  (resolve-mip-level :uint32)
  (resolve-layer :uint32)
  (cycle :bool)
  (cycle-resolve-texture :bool)
  (padding1 :uint8)
  (padding2 :uint8))

(deflsp-type gpu-depth-stencil-target-info
  (texture :pointer)
  (clear-depth :float)
  (load-op gpu-load-op)
  (store-op gpu-store-op)
  (stencil-load-op gpu-load-op)
  (stencil-store-op gpu-store-op)
  (cycle :bool)
  (clear-stencil :uint8)
  (padding1 :uint8)
  (padding2 :uint8))

(deflsp-type gpu-viewport
  (x :float)
  (y :float)
  (w :float)
  (h :float)
  (min-depth :float)
  (max-depth :float))

(deflsp-type gpu-buffer-binding
  (buffer :pointer)
  (offset :uint32))

(defcenum gpu-index-element-size
  :16bit
  :32bit)

(deflsp-type gpu-storage-buffer-read-write-binding
  (buffer :pointer)
  (cycle :bool)
  (padding1 :uint8)
  (padding2 :uint8)
  (padding3 :uint8))

(deflsp-type gpu-storage-texture-read-write-binding
  (texture :pointer)
  (mip-level :uint32)
  (layer :uint32)
  (cycle :bool)
  (padding1 :uint8)
  (padding2 :uint8)
  (padding3 :uint8))

(deflsp-type gpu-texture-sampler-binding
  (texture :pointer)
  (sampler :pointer))

(deflsp-type gpu-transfer-buffer-location
  (buffer :pointer)
  (offset :uint32))

(deflsp-type gpu-buffer-region
  (buffer :pointer)
  (offset :uint32)
  (size :uint32))

(deflsp-type gpu-texture-location
  (texture :pointer)
  (mip-level :uint32)
  (layer :uint32)
  (x :uint32)
  (y :uint32)
  (z :uint32))

(deflsp-type gpu-buffer-location
  (buffer :pointer)
  (offset :uint32))

(deflsp-type gpu-texture-region
  (texture :pointer)
  (mip-level :uint32)
  (layer :uint32)
  (x :uint32)
  (y :uint32)
  (z :uint32)
  (w :uint32)
  (h :uint32)
  (d :uint32))

(deflsp-type gpu-texture-transfer-info
  (buffer :pointer)
  (offset :uint32)
  (pixels-per-row :uint32)
  (rows-per-layer :uint32))

(deflsp-type gpu-blit-region
  (texture :pointer)
  (mip-level :uint32)
  (layer-or-depth-plane :uint32)
  (x :uint32)
  (y :uint32)
  (w :uint32)
  (h :uint32))

(deflsp-type gpu-blit-info
  (source (:struct gpu-blit-region))
  (destination (:struct gpu-blit-region))
  (load-op gpu-load-op)
  (clear-color (:struct fcolor))
  (flip-mode flip-mode)
  (filter gpu-filter)
  (cycle :bool)
  (padding1 :uint8)
  (padding2 :uint8)
  (padding3 :uint8))

(defcenum gpu-swapchain-composition
  :sdr
  :sdr-linear
  :hdr-extended-linear
  :hdr10-st2084)

(defcenum gpu-present-mode
  :vsync
  :immediate
  :mailbox)

