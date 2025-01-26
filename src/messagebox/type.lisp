(in-package :sdl3)

(cffi:defbitfield message-box-flags 
  (:messagebox-error                    #x00000010)
  (:messagebox-warning                  #x00000020)
  (:messagebox-information              #x00000040)
  (:messagebox-buttons-left-to-right    #x00000080)
  (:messagebox-buttons-right-to-left    #x00000100))

(cffi:defbitfield message-box-button-flags
  (:messagebox-button-returnkey-default #x00000001)
  (:messagebox-button-escapekey-default #x00000002))

(deflsp-type message-box-color 
  (r :uint8)
  (g :uint8)
  (b :uint8))

(cffi:defcenum message-box-color-type 
  :messagebox-color-background
  :messagebox-color-text
  :messagebox-color-button-border
  :messagebox-color-button-background
  :messagebox-color-button-selected
  :messagebox-color-count)

(deflsp-type message-box-color-scheme
  (colors (:struct message-box-color) :count 5)) ;; messagebox-color-count

(deflsp-type message-box-button-data 
  (flags message-box-button-flags)
  (button-id :int)
  (text :string))

(deflsp-type message-box-data
  (flags message-box-flags)
  (window :pointer)
  (title :string)
  (message :string)
  (numbuttons :int)
  (buttons (:pointer (:struct message-box-button-data )))
  (color-scheme (:pointer (:struct message-box-color-scheme))))
