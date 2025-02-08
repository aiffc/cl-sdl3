(in-package :sdl3)

(defexport-fun "SDL_GetNumLogicalCPUCores" :int)

(defexport-fun "SDL_GetCPUCacheLineSize" :int)

(defexport-fun "SDL_HasAltiVec" :bool)

(defexport-fun "SDL_HasMMX" :bool)

(defexport-fun "SDL_HasSSE" :bool)

(defexport-fun "SDL_HasSSE2" :bool)

(defexport-fun "SDL_HasSSE3" :bool)

(defexport-fun "SDL_HasSSE41" :bool)

(defexport-fun "SDL_HasSSE42" :bool)

(defexport-fun "SDL_HasAVX" :bool)

(defexport-fun "SDL_HasAVX2" :bool)

(defexport-fun "SDL_HasAVX512F" :bool)

(defexport-fun "SDL_HasARMSIMD" :bool)

(defexport-fun "SDL_HasNEON" :bool)

(defexport-fun "SDL_HasLSX" :bool)

(defexport-fun "SDL_HasLASX" :bool)

(defexport-fun "SDL_GetSystemRAM" :int)

(defexport-fun "SDL_GetSIMDAlignment" size-t)
