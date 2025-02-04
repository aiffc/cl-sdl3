(in-package :sdl3-image)

(cffi:defcfun ("IMG_Version" version) :int)
(export 'version)

(cffi:defcfun ("IMG_LoadTyped_IO" load-typed-io) (:pointer (:struct sdl3:surface))
  (src :pointer)
  (closeio :bool)
  (type :string))
(export 'load-typed-io)

(cffi:defcfun ("IMG_Load" img-load) (:pointer (:struct sdl3:surface))
  (file :string))
(export 'img-load)

(cffi:defcfun ("IMG_Load_IO" load-io) (:pointer (:struct sdl3:surface))
  (src :pointer)
  (closeio :bool))
(export 'load-io)

(cffi:defcfun ("IMG_LoadTexture" load-texture) (:pointer (:struct sdl3:texture))
  (renderer :pointer)
  (file :string))
(export 'load-texture)

(cffi:defcfun ("IMG_LoadTexture_IO" load-texture-io) (:pointer (:struct sdl3:texture))
  (renderer :pointer)
  (src :pointer)
  (closeio :bool))
(export 'load-texture-io)

(cffi:defcfun ("IMG_LoadTextureTyped_IO" load-texture-typed-io) (:pointer (:struct sdl3:texture))
  (renderer :pointer)
  (src :pointer)
  (closeio :bool)
  (type :string))
(export 'load-texture-typed-io)

(cffi:defcfun ("IMG_isAVIF" is-avif) :bool
  (src :pointer))
(export 'is-avif)

(cffi:defcfun ("IMG_isICO" is-ico) :bool
  (src :pointer))
(export 'is-ico)

(cffi:defcfun ("IMG_isCUR" is-cur) :bool
  (src :pointer))
(export 'is-cur)

(cffi:defcfun ("IMG_isBMP" is-bmp) :bool
  (src :pointer))
(export 'is-bmp)

(cffi:defcfun ("IMG_isGIF" is-gif) :bool
  (src :pointer))
(export 'is-gif)

(cffi:defcfun ("IMG_isJPG" is-jpg) :bool
  (src :pointer))
(export 'is-jpg)

(cffi:defcfun ("IMG_isJXL" is-jxl) :bool
  (src :pointer))
(export 'is-jxl)

(cffi:defcfun ("IMG_isLBM" is-lbm) :bool
  (src :pointer))
(export 'is-lbm)

(cffi:defcfun ("IMG_isPCX" is-pcx) :bool
  (src :pointer))
(export 'is-pcx)

(cffi:defcfun ("IMG_isPNG" is-png) :bool
  (src :pointer))
(export 'is-png)

(cffi:defcfun ("IMG_isPNM" is-pnm) :bool
  (src :pointer))
(export 'is-pnm)

(cffi:defcfun ("IMG_isSVG" is-svg) :bool
  (src :pointer))
(export 'is-svg)

(cffi:defcfun ("IMG_isQOI" is-qoi) :bool
  (src :pointer))
(export 'is-qoi)

(cffi:defcfun ("IMG_isTIF" is-tif) :bool
  (src :pointer))
(export 'is-tif)

(cffi:defcfun ("IMG_isXCF" is-xcf) :bool
  (src :pointer))
(export 'is-xcf)

(cffi:defcfun ("IMG_isXPM" is-xpm) :bool
  (src :pointer))
(export 'is-xpm)

(cffi:defcfun ("IMG_isXV" is-xv) :bool
  (src :pointer))
(export 'is-xv)

(cffi:defcfun ("IMG_isWEBP" is-webp) :bool
  (src :pointer))
(export 'is-webp)

(cffi:defcfun ("IMG_LoadAVIF_IO" load-avif-io) (:pointer (:struct sdl3:surface))
  (src :pointer))
(export 'load-avif-io)

(cffi:defcfun ("IMG_LoadICO_IO" load-ico-io) (:pointer (:struct sdl3:surface))
  (src :pointer))
(export 'load-ico-io)

(cffi:defcfun ("IMG_LoadCUR_IO" load-cur-io) (:pointer (:struct sdl3:surface))
  (src :pointer))
(export 'load-cur-io)

(cffi:defcfun ("IMG_LoadBMP_IO" load-bmp-io) (:pointer (:struct sdl3:surface))
  (src :pointer))
(export 'load-bmp-io)

(cffi:defcfun ("IMG_LoadGIF_IO" load-gif-io) (:pointer (:struct sdl3:surface))
  (src :pointer))
(export 'load-gif-io)

(cffi:defcfun ("IMG_LoadJPG_IO" load-jpg-io) (:pointer (:struct sdl3:surface))
  (src :pointer))
(export 'load-jpg-io)

(cffi:defcfun ("IMG_LoadJXL_IO" load-jxl-io) (:pointer (:struct sdl3:surface))
  (src :pointer))
(export 'load-jxl-io)

(cffi:defcfun ("IMG_LoadLBM_IO" load-lbm-io) (:pointer (:struct sdl3:surface))
  (src :pointer))
(export 'load-lbm-io)

(cffi:defcfun ("IMG_LoadPCX_IO" load-pcx-io) (:pointer (:struct sdl3:surface))
  (src :pointer))
(export 'load-pcx-io)

(cffi:defcfun ("IMG_LoadPNG_IO" load-png-io) (:pointer (:struct sdl3:surface))
  (src :pointer))
(export 'load-png-io)

(cffi:defcfun ("IMG_LoadPNM_IO" load-pnm-io) (:pointer (:struct sdl3:surface))
  (src :pointer))
(export 'load-pnm-io)

(cffi:defcfun ("IMG_LoadSVG_IO" load-svg-io) (:pointer (:struct sdl3:surface))
  (src :pointer))
(export 'load-svg-io)

(cffi:defcfun ("IMG_LoadQOI_IO" load-qoi-io) (:pointer (:struct sdl3:surface))
  (src :pointer))
(export 'load-qoi-io)

(cffi:defcfun ("IMG_LoadTGA_IO" load-tga-io) (:pointer (:struct sdl3:surface))
  (src :pointer))
(export 'load-tga-io)

(cffi:defcfun ("IMG_LoadTIF_IO" load-tif-io) (:pointer (:struct sdl3:surface))
  (src :pointer))
(export 'load-tif-io)

(cffi:defcfun ("IMG_LoadXCF_IO" load-xcf-io) (:pointer (:struct sdl3:surface))
  (src :pointer))
(export 'load-xcf-io)

(cffi:defcfun ("IMG_LoadXPM_IO" load-xpm-io) (:pointer (:struct sdl3:surface))
  (src :pointer))
(export 'load-xpm-io)

(cffi:defcfun ("IMG_LoadXV_IO" load-xv-io) (:pointer (:struct sdl3:surface))
  (src :pointer))
(export 'load-xv-io)

(cffi:defcfun ("IMG_LoadWEBP_IO" load-webp-io) (:pointer (:struct sdl3:surface))
  (src :pointer))
(export 'load-webp-io)

(cffi:defcfun ("IMG_LoadSizedSVG_IO" load-sized-svg-io) (:pointer (:struct sdl3:surface))
  (src :pointer)
  (width :int)
  (height :int))
(export 'load-sized-svg-io)

(cffi:defcfun ("IMG_ReadXPMFromArray" read-xpm-from-array) (:pointer (:struct sdl3:surface))
  (xpm (:pointer :string)))
(export 'read-xpm-from-array)

(cffi:defcfun ("IMG_ReadXPMFromArrayToRGB888" read-xpm-from-array-to-rgb888) (:pointer (:struct sdl3:surface))
  (xpm (:pointer :string)))
(export 'read-xpm-from-array-to-rgb888)

(cffi:defcfun ("IMG_SaveAVIF" save-avif) :bool
  (surface (:pointer (:struct sdl3:surface)))
  (file :string)
  (quality :int))
(export 'save-avif)

(cffi:defcfun ("IMG_SaveAVIF_IO" save-avif-io) :bool
  (surface (:pointer (:struct sdl3:surface)))
  (dst :pointer)
  (closeio :bool)
  (quality :int))
(export 'save-avif-io)

(cffi:defcfun ("IMG_SavePNG" save-png) :bool
  (surface (:pointer (:struct sdl3:surface)))
  (file :string))
(export 'save-png)

(cffi:defcfun ("IMG_SavePNG_IO" save-png-io) :bool
  (surface (:pointer (:struct sdl3:surface)))
  (dst :pointer)
  (closeio :bool))
(export 'save-png-io)

(cffi:defcfun ("IMG_SaveJPG" save-jpg) :bool
  (surface (:pointer (:struct sdl3:surface)))
  (file :string)
  (quality :int))
(export 'save-jpg)

(cffi:defcfun ("IMG_SaveJPG_IO" save-jpg-io) :bool
  (surface (:pointer (:struct sdl3:surface)))
  (dst :pointer)
  (closeio :bool)
  (quality :int))
(export 'save-jpg-io)

(cffi:defcfun ("IMG_LoadAnimation" load-animation) (:pointer (:struct animation))
  (file :string))
(export 'load-animation)

(cffi:defcfun ("IMG_LoadAnimation_IO" load-animation-io) (:pointer (:struct animation))
  (src :pointer)
  (closeio :bool))
(export 'load-animation-io)

(cffi:defcfun ("IMG_LoadAnimationTyped_IO" load-animation-typed-io) (:pointer (:struct animation))
  (src :pointer)
  (closeio :bool)
  (type :string))
(export 'load-animation-typed-io)

(cffi:defcfun ("IMG_FreeAnimation" free-animation) :void
  (anim (:pointer (:struct animation))))
(export 'free-animation)

(cffi:defcfun ("IMG_LoadGIFAnimation_IO" load-gif-animation-io) (:pointer (:struct animation))
  (src :pointer))
(export 'load-gif-animation-io)

(cffi:defcfun ("IMG_LoadWEBPAnimation_IO" load-webp-animation-io) (:pointer (:struct animation))
  (src :pointer))
(export 'load-webp-animation-io)

