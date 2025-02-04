(in-package :sdl3-ttf)

(cffi:defcfun ("TTF_Version" version) :int)
(export 'version)

(cffi:defcfun ("TTF_GetFreeTypeVersion" get-free-type-version) :void
  (major (:pointer :int))
  (minor (:pointer :int))
  (patch (:pointer :int)))
(export 'get-free-type-version)

(cffi:defcfun ("TTF_GetHarfBuzzVersion" get-harf-buzz-version) :void
  (major (:pointer :int))
  (minor (:pointer :int))
  (patch (:pointer :int)))
(export 'get-harf-buzz-version)

(cffi:defcfun ("TTF_Init" init) :bool)
(export 'init)

(cffi:defcfun ("TTF_OpenFont" open-font) :pointer
  (file :string)
  (ptsize :float))
(export 'open-font)

(cffi:defcfun ("TTF_OpenFontIO" open-font-io) :pointer
  (src :pointer)
  (closeio :bool)
  (ptsize :float))
(export 'open-font-io)

(cffi:defcfun ("TTF_OpenFontWithProperties" open-font-with-properties) :pointer
  (props sdl3::properties-id))
(export 'open-font-with-properties)

(cffi:defcfun ("TTF_CopyFont" copy-font) :pointer
  (existing_font :pointer))
(export 'copy-font)

(cffi:defcfun ("TTF_GetFontProperties" get-font-properties) sdl3::properties-id
  (font :pointer))
(export 'get-font-properties)

(cffi:defcfun ("TTF_GetFontGeneration" get-font-generation) :uint32
  (font :pointer))
(export 'get-font-generation)

(cffi:defcfun ("TTF_AddFallbackFont" add-fallback-font) :bool
  (font :pointer)
  (fallback :pointer))
(export 'add-fallback-font)

(cffi:defcfun ("TTF_RemoveFallbackFont" remove-fallback-font) :void
  (font :pointer)
  (fallback :pointer))
(export 'remove-fallback-font)

(cffi:defcfun ("TTF_ClearFallbackFonts" clear-fallback-fonts) :void
  (font :pointer))
(export 'clear-fallback-fonts)

(cffi:defcfun ("TTF_SetFontSize" set-font-size) :bool
  (font :pointer)
  (ptsize :float))
(export 'set-font-size)

(cffi:defcfun ("TTF_SetFontSizeDPI" set-font-size-dpi) :bool
  (font :pointer)
  (ptsize :float)
  (hdpi :int)
  (vdpi :int))
(export 'set-font-size-dpi)

(cffi:defcfun ("TTF_GetFontSize" get-font-size) :float
  (font :pointer))
(export 'get-font-size)

(cffi:defcfun ("TTF_GetFontDPI" get-font-dpi) :bool
  (font :pointer)
  (hdpi (:pointer :int))
  (vdpi (:pointer :int)))
(export 'get-font-dpi)

(cffi:defcfun ("TTF_SetFontStyle" set-font-style) :void
  (font :pointer)
  (style font-style-flags))
(export 'set-font-style)

(cffi:defcfun ("TTF_GetFontStyle" get-font-style) font-style-flags
  (font :pointer))
(export 'get-font-style)

(cffi:defcfun ("TTF_SetFontOutline" set-font-outline) :bool
  (font :pointer)
  (outline :int))
(export 'set-font-outline)

(cffi:defcfun ("TTF_GetFontOutline" get-font-outline) :int
  (font :pointer))
(export 'get-font-outline)

(cffi:defcfun ("TTF_SetFontHinting" set-font-hinting) :void
  (font :pointer)
  (hinting hinting-flags))
(export 'set-font-hinting)

(cffi:defcfun ("TTF_GetNumFontFaces" get-num-font-faces) :int
  (font :pointer))
(export 'get-num-font-faces)

(cffi:defcfun ("TTF_GetFontHinting" get-font-hinting) hinting-flags
  (font :pointer))
(export 'get-font-hinting)

(cffi:defcfun ("TTF_SetFontWrapAlignment" set-font-wrap-alignment) :void
  (font :pointer)
  (align horizontal-alignment))
(export 'set-font-wrap-alignment)

(cffi:defcfun ("TTF_GetFontWrapAlignment" get-font-wrap-alignment) horizontal-alignment
  (font :pointer))
(export 'get-font-wrap-alignment)

(cffi:defcfun ("TTF_GetFontHeight" get-font-height) :int
  (font :pointer))
(export 'get-font-height)

(cffi:defcfun ("TTF_GetFontAscent" get-font-ascent) :int
  (font :pointer))
(export 'get-font-ascent)

(cffi:defcfun ("TTF_GetFontDescent" get-font-descent) :int
  (font :pointer))
(export 'get-font-descent)

(cffi:defcfun ("TTF_SetFontLineSkip" set-font-line-skip) :void
  (font :pointer)
  (lineskip :int))
(export 'set-font-line-skip)

(cffi:defcfun ("TTF_GetFontLineSkip" get-font-line-skip) :int
  (font :pointer))
(export 'get-font-line-skip)

(cffi:defcfun ("TTF_SetFontKerning" set-font-kerning) :void
  (font :pointer)
  (enabled :bool))
(export 'set-font-kerning)

(cffi:defcfun ("TTF_GetFontKerning" get-font-kerning) :bool
  (font :pointer))
(export 'get-font-kerning)

(cffi:defcfun ("TTF_FontIsFixedWidth" font-is-fixed-width) :bool
  (font :pointer))
(export 'font-is-fixed-width)

(cffi:defcfun ("TTF_GetFontFamilyName" get-font-family-name) :string
  (font :pointer))
(export 'get-font-family-name)

(cffi:defcfun ("TTF_GetFontStyleName" get-font-style-name) :string
  (font :pointer))
(export 'get-font-style-name)

(cffi:defcfun ("TTF_SetFontDirection" set-font-direction) :bool
  (font :pointer)
  (direction direction))
(export 'set-font-direction)

(cffi:defcfun ("TTF_GetFontDirection" get-font-direction) direction
  (font :pointer))
(export 'get-font-direction)

(cffi:defcfun ("TTF_SetFontScript" set-font-script) :bool
  (font :pointer)
  (script :uint32))
(export 'set-font-script)

(cffi:defcfun ("TTF_GetFontScript" get-font-script) :uint32
  (font :pointer))
(export 'get-font-script)

(cffi:defcfun ("TTF_GetGlyphScript" get-glyph-script) :uint32
  (ch :uint32))
(export 'get-glyph-script)

(cffi:defcfun ("TTF_FontHasGlyph" font-has-glyph) :bool
  (font :pointer)
  (ch :uint32))
(export 'font-has-glyph)

(cffi:defcfun ("TTF_GetGlyphImage" get-glyph-image) (:pointer (:struct sdl3:surface))
  (font :pointer)
  (ch :uint32)
  (image_type (:pointer image-type)))
(export 'get-glyph-image)

(cffi:defcfun ("TTF_GetGlyphImageForIndex" get-glyph-image-for-index) (:pointer (:struct sdl3:surface))
  (font :pointer)
  (glyph_index :uint32)
  (image_type (:pointer image-type)))
(export 'get-glyph-image-for-index)

(cffi:defcfun ("TTF_GetGlyphMetrics" get-glyph-metrics) :bool
  (font :pointer)
  (ch :uint32)
  (minx (:pointer :int))
  (maxx (:pointer :int))
  (miny (:pointer :int))
  (maxy (:pointer :int))
  (advance (:pointer :int)))
(export 'get-glyph-metrics)

(cffi:defcfun ("TTF_GetStringSize" get-string-size) :bool
  (font :pointer)
  (text :string)
  (length sdl3::size-t)
  (w (:pointer :int))
  (h (:pointer :int)))
(export 'get-string-size)

(cffi:defcfun ("TTF_GetStringSizeWrapped" get-string-size-wrapped) :bool
  (font :pointer)
  (text :string)
  (length sdl3::size-t)
  (wrap_width :int)
  (w (:pointer :int))
  (h (:pointer :int)))
(export 'get-string-size-wrapped)

(cffi:defcfun ("TTF_MeasureString" measure-string) :bool
  (font :pointer)
  (text :string)
  (length sdl3::size-t)
  (max_width :int)
  (measured_width (:pointer :int))
  (measured_length (:pointer sdl3::size-t)))
(export 'measure-string)

(cffi:defcfun ("TTF_RenderText_Solid" render-text_-solid) (:pointer (:struct sdl3:surface))
  (font :pointer)
  (text :string)
  (length sdl3::size-t)
  (fg (:struct sdl3:color)))
(export 'render-text_-solid)

(cffi:defcfun ("TTF_RenderText_Solid_Wrapped" render-text_-solid_-wrapped) (:pointer (:struct sdl3:surface))
  (font :pointer)
  (text :string)
  (length sdl3::size-t)
  (fg (:struct sdl3:color))
  (wrapLength :int))
(export 'render-text_-solid_-wrapped)

(cffi:defcfun ("TTF_RenderGlyph_Solid" render-glyph_-solid) (:pointer (:struct sdl3:surface))
  (font :pointer)
  (ch :uint32)
  (fg (:struct sdl3:color)))
(export 'render-glyph_-solid)

(cffi:defcfun ("TTF_RenderText_Shaded" render-text_-shaded) (:pointer (:struct sdl3:surface))
  (font :pointer)
  (text :string)
  (length sdl3::size-t)
  (fg (:struct sdl3:color))
  (bg (:struct sdl3:color)))
(export 'render-text_-shaded)

(cffi:defcfun ("TTF_RenderText_Shaded_Wrapped" render-text_-shaded_-wrapped) (:pointer (:struct sdl3:surface))
  (font :pointer)
  (text :string)
  (length sdl3::size-t)
  (fg (:struct sdl3:color))
  (bg (:struct sdl3:color))
  (wrap_width :int))
(export 'render-text_-shaded_-wrapped)

(cffi:defcfun ("TTF_RenderGlyph_Shaded" render-glyph_-shaded) (:pointer (:struct sdl3:surface))
  (font :pointer)
  (ch :uint32)
  (fg (:struct sdl3:color))
  (bg (:struct sdl3:color)))
(export 'render-glyph_-shaded)

(cffi:defcfun ("TTF_RenderText_Blended" render-text_-blended) (:pointer (:struct sdl3:surface))
  (font :pointer)
  (text :string)
  (length sdl3::size-t)
  (fg (:struct sdl3:color)))
(export 'render-text_-blended)

(cffi:defcfun ("TTF_RenderText_Blended_Wrapped" render-text_-blended_-wrapped) (:pointer (:struct sdl3:surface))
  (font :pointer)
  (text :string)
  (length sdl3::size-t)
  (fg (:struct sdl3:color))
  (wrap_width :int))
(export 'render-text_-blended_-wrapped)

(cffi:defcfun ("TTF_RenderGlyph_Blended" render-glyph_-blended) (:pointer (:struct sdl3:surface))
  (font :pointer)
  (ch :uint32)
  (fg (:struct sdl3:color)))
(export 'render-glyph_-blended)

(cffi:defcfun ("TTF_RenderText_LCD" render-text_-l-c-d) (:pointer (:struct sdl3:surface))
  (font :pointer)
  (text :string)
  (length sdl3::size-t)
  (fg (:struct sdl3:color))
  (bg (:struct sdl3:color)))
(export 'render-text_-l-c-d)

(cffi:defcfun ("TTF_RenderText_LCD_Wrapped" render-text_-l-c-d_-wrapped) (:pointer (:struct sdl3:surface))
  (font :pointer)
  (text :string)
  (length sdl3::size-t)
  (fg (:struct sdl3:color))
  (bg (:struct sdl3:color))
  (wrap_width :int))
(export 'render-text_-l-c-d_-wrapped)

(cffi:defcfun ("TTF_RenderGlyph_LCD" render-glyph_-l-c-d) (:pointer (:struct sdl3:surface))
  (font :pointer)
  (ch :uint32)
  (fg (:struct sdl3:color))
  (bg (:struct sdl3:color)))
(export 'render-glyph_-l-c-d)

(cffi:defcfun ("TTF_CreateSurfaceTextEngine" create-surface-text-engine) :pointer)
(export 'create-surface-text-engine)

(cffi:defcfun ("TTF_DrawSurfaceText" draw-surface-text) :bool
  (text (:pointer (:struct text)))
  (x :int)
  (y :int)
  (surface (:pointer (:struct sdl3:surface))))
(export 'draw-surface-text)

(cffi:defcfun ("TTF_DestroySurfaceTextEngine" destroy-surface-text-engine) :void
  (engine :pointer))
(export 'destroy-surface-text-engine)

(cffi:defcfun ("TTF_CreateRendererTextEngine" create-renderer-text-engine) :pointer
  (renderer :pointer))
(export 'create-renderer-text-engine)

(cffi:defcfun ("TTF_CreateRendererTextEngineWithProperties" create-renderer-text-engine-with-properties) :pointer
  (props sdl3::properties-id))
(export 'create-renderer-text-engine-with-properties)

(cffi:defcfun ("TTF_DrawRendererText" draw-renderer-text) :bool
  (text (:pointer (:struct text)))
  (x :float)
  (y :float))
(export 'draw-renderer-text)

(cffi:defcfun ("TTF_DestroyRendererTextEngine" destroy-renderer-text-engine) :void
  (engine :pointer))
(export 'destroy-renderer-text-engine)

(cffi:defcfun ("TTF_CreateGPUTextEngine" create-gpu-text-engine) :pointer
  (device :pointer))
(export 'create-gpu-text-engine)

(cffi:defcfun ("TTF_CreateGPUTextEngineWithProperties" create-gpu-text-engine-with-properties) :pointer
  (props sdl3::properties-id))
(export 'create-gpu-text-engine-with-properties)

(cffi:defcfun ("TTF_GetGPUTextDrawData" get-gpu-text-draw-data) (:pointer (:struct gpu-atlas-draw-sequence))
  (text (:pointer (:struct text))))
(export 'get-gpu-text-draw-data)

(cffi:defcfun ("TTF_DestroyGPUTextEngine" destroy-gpu-text-engine) :void
  (engine :pointer))
(export 'destroy-gpu-text-engine)

(cffi:defcfun ("TTF_SetGPUTextEngineWinding" set-gpu-text-engine-winding) :void
  (engine :pointer)
  (winding gpu-text-engine-winding))
(export 'set-gpu-text-engine-winding)

(cffi:defcfun ("TTF_GetGPUTextEngineWinding" get-gpu-text-engine-winding) gpu-text-engine-winding
  (engine :pointer))
(export 'get-gpu-text-engine-winding)

(cffi:defcfun ("TTF_CreateText" create-text) (:pointer (:struct text))
  (engine :pointer)
  (font :pointer)
  (text :string)
  (length sdl3::size-t))
(export 'create-text)

(cffi:defcfun ("TTF_GetTextProperties" get-text-properties) sdl3::properties-id
  (text (:pointer (:struct text))))
(export 'get-text-properties)

(cffi:defcfun ("TTF_SetTextEngine" set-text-engine) :bool
  (text (:pointer (:struct text)))
  (engine :pointer))
(export 'set-text-engine)

(cffi:defcfun ("TTF_GetTextEngine" get-text-engine) :pointer
  (text (:pointer (:struct text))))
(export 'get-text-engine)

(cffi:defcfun ("TTF_SetTextFont" set-text-font) :bool
  (text (:pointer (:struct text)))
  (font :pointer))
(export 'set-text-font)

(cffi:defcfun ("TTF_GetTextFont" get-text-font) :pointer
  (text (:pointer (:struct text))))
(export 'get-text-font)

(cffi:defcfun ("TTF_SetTextDirection" set-text-direction) :bool
  (text (:pointer (:struct text)))
  (direction direction))
(export 'set-text-direction)

(cffi:defcfun ("TTF_GetTextDirection" get-text-direction) direction
  (text (:pointer (:struct text))))
(export 'get-text-direction)

(cffi:defcfun ("TTF_SetTextScript" set-text-script) :bool
  (text (:pointer (:struct text)))
  (script :uint32))
(export 'set-text-script)

(cffi:defcfun ("TTF_GetTextScript" get-text-script) :uint32
  (text (:pointer (:struct text))))
(export 'get-text-script)

(cffi:defcfun ("TTF_SetTextColor" set-text-color) :bool
  (text (:pointer (:struct text)))
  (r :uint8)
  (g :uint8)
  (b :uint8)
  (a :uint8))
(export 'set-text-color)

(cffi:defcfun ("TTF_SetTextColorFloat" set-text-color-float) :bool
  (text (:pointer (:struct text)))
  (r :float)
  (g :float)
  (b :float)
  (a :float))
(export 'set-text-color-float)

(cffi:defcfun ("TTF_GetTextColor" get-text-color) :bool
  (text (:pointer (:struct text)))
  (r (:pointer :uint8))
  (g (:pointer :uint8))
  (b (:pointer :uint8))
  (a (:pointer :uint8)))
(export 'get-text-color)

(cffi:defcfun ("TTF_GetTextColorFloat" get-text-color-float) :bool
  (text (:pointer (:struct text)))
  (r (:pointer :float))
  (g (:pointer :float))
  (b (:pointer :float))
  (a (:pointer :float)))
(export 'get-text-color-float)

(cffi:defcfun ("TTF_SetTextPosition" set-text-position) :bool
  (text (:pointer (:struct text)))
  (x :int)
  (y :int))
(export 'set-text-position)

(cffi:defcfun ("TTF_GetTextPosition" get-text-position) :bool
  (text (:pointer (:struct text)))
  (x (:pointer :int))
  (y (:pointer :int)))
(export 'get-text-position)

(cffi:defcfun ("TTF_SetTextWrapWidth" set-text-wrap-width) :bool
  (text (:pointer (:struct text)))
  (wrap_width :int))
(export 'set-text-wrap-width)

(cffi:defcfun ("TTF_GetTextWrapWidth" get-text-wrap-width) :bool
  (text (:pointer (:struct text)))
  (wrap_width (:pointer :int)))
(export 'get-text-wrap-width)

(cffi:defcfun ("TTF_SetTextWrapWhitespaceVisible" set-text-wrap-whitespace-visible) :bool
  (text (:pointer (:struct text)))
  (visible :bool))
(export 'set-text-wrap-whitespace-visible)

(cffi:defcfun ("(:struct text)WrapWhitespaceVisible" text-wrap-whitespace-visible) :bool
  (text (:pointer (:struct text))))
(export 'text-wrap-whitespace-visible)

(cffi:defcfun ("TTF_SetTextString" set-text-string) :bool
  (text (:pointer (:struct text)))
  (string :string)
  (length sdl3::size-t))
(export 'set-text-string)

(cffi:defcfun ("TTF_InsertTextString" insert-text-string) :bool
  (text (:pointer (:struct text)))
  (offset :int)
  (string :string)
  (length sdl3::size-t))
(export 'insert-text-string)

(cffi:defcfun ("TTF_AppendTextString" append-text-string) :bool
  (text (:pointer (:struct text)))
  (string :string)
  (length sdl3::size-t))
(export 'append-text-string)

(cffi:defcfun ("TTF_DeleteTextString" delete-text-string) :bool
  (text (:pointer (:struct text)))
  (offset :int)
  (length :int))
(export 'delete-text-string)

(cffi:defcfun ("TTF_GetTextSize" get-text-size) :bool
  (text (:pointer (:struct text)))
  (w (:pointer :int))
  (h (:pointer :int)))
(export 'get-text-size)

(cffi:defcfun ("TTF_GetTextSubString" get-text-sub-string) :bool
  (text (:pointer (:struct text)))
  (offset :int)
  (substring (:pointer (:struct sub-string))))
(export 'get-text-sub-string)

(cffi:defcfun ("TTF_GetTextSubStringForLine" get-text-sub-string-for-line) :bool
  (text (:pointer (:struct text)))
  (line :int)
  (substring (:pointer (:struct sub-string))))
(export 'get-text-sub-string-for-line)

(cffi:defcfun ("TTF_GetTextSubStringsForRange" get-text-sub-strings-for-range) (:pointer (:pointer (:struct sub-string)))
  (text (:pointer (:struct text)))
  (offset :int)
  (length :int)
  (count (:pointer :int)))
(export 'get-text-sub-strings-for-range)

(cffi:defcfun ("TTF_GetTextSubStringForPoint" get-text-sub-string-for-point) :bool
  (text (:pointer (:struct text)))
  (x :int)
  (y :int)
  (substring (:pointer (:struct sub-string))))
(export 'get-text-sub-string-for-point)

(cffi:defcfun ("TTF_GetPreviousTextSubString" get-previous-text-sub-string) :bool
  (text (:pointer (:struct text)))
  (substring (:pointer (:struct sub-string)))
  (previous (:pointer (:struct sub-string))))
(export 'get-previous-text-sub-string)

(cffi:defcfun ("TTF_GetNextTextSubString" get-next-text-sub-string) :bool
  (text (:pointer (:struct text)))
  (substring (:pointer (:struct sub-string)))
  (next (:pointer (:struct sub-string))))
(export 'get-next-text-sub-string)

(cffi:defcfun ("TTF_UpdateText" update-text) :bool
  (text (:pointer (:struct text))))
(export 'update-text)

(cffi:defcfun ("TTF_DestroyText" destroy-text) :void
  (text (:pointer (:struct text))))
(export 'destroy-text)

(cffi:defcfun ("TTF_CloseFont" close-font) :void
  (font :pointer))
(export 'close-font)

(cffi:defcfun ("TTF_Quit" quit) :void)
(export 'quit)

(cffi:defcfun ("TTF_WasInit" was-init) :int)
(export 'was-init)

