(in-package :sdl3)

(defexport-fun ("SDL_GetNumLogicalCPUCores" get-num-logical-cpu-cores) :int)

(defexport-fun ("SDL_GetCPUCacheLineSize" get-cpu-cache-line-size) :int)

(defexport-fun "SDL_HasAltiVec" :bool)

(defexport-fun ("SDL_HasMMX" has-mmx) :bool)

(defexport-fun ("SDL_HasSSE" has-sse) :bool)

(defexport-fun ("SDL_HasSSE2" has-sse2) :bool)

(defexport-fun ("SDL_HasSSE3" has-sse3) :bool)

(defexport-fun ("SDL_HasSSE41" has-sse41) :bool)

(defexport-fun ("SDL_HasSSE42" has-sse42) :bool)

(defexport-fun ("SDL_HasAVX" has-avx) :bool)

(defexport-fun ("SDL_HasAVX2" has-avx2) :bool)

(defexport-fun ("SDL_HasAVX512F" has-avx512f) :bool)

(defexport-fun ("SDL_HasARMSIMD" has-arm-simd) :bool)

(defexport-fun ("SDL_HasNEON" has-neon) :bool)

(defexport-fun ("SDL_HasLSX" has-lsx) :bool)

(defexport-fun ("SDL_HasLASX" has-lasx) :bool)

(defexport-fun ("SDL_GetSystemRAM" get-system-ram) :int)

(defexport-fun ("SDL_GetSIMDAlignment" get-simd-alignment) size-t)
