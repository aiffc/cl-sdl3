(in-package :sdl3)

(cffi:defcenum blend-factor
  (:blendfactor-zero                #x1)
  (:blendfactor-one                 #x2)
  (:blendfactor-src-color           #x3)
  (:blendfactor-one-minus-src-color #x4)
  (:blendfactor-src-alpha           #x5)
  (:blendfactor-one-minus-src-alpha #x6)
  (:blendfactor-dst-color           #x7)
  (:blendfactor-one-minus-dst-color #x8)
  (:blendfactor-dst-alpha           #x9)
  (:blendfactor-one-minus-dst-alpha #xa))

(cffi:defcenum blend-operation
  (:blendoperation-add              #x1)
  (:blendoperation-subtract         #x2)
  (:blendoperation-rev-subtract     #x3)
  (:blendoperation-minimum          #x4)
  (:blendoperation-maximum          #x5))

(cffi:defbitfield blend-mode 
  (:sdl-blendmode-none                  #x00000000)
  (:sdl-blendmode-blend                 #x00000001)
  (:sdl-blendmode-blend-premultiplied   #x00000010)
  (:sdl-blendmode-add                   #x00000002)
  (:sdl-blendmode-add-premultiplied     #x00000020)
  (:sdl-blendmode-mod                   #x00000004)
  (:sdl-blendmode-mul                   #x00000008)
  (:sdl-blendmode-invalid               #x7fffffff))
