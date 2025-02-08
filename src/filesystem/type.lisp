(in-package :sdl3)

(defcenum folder 
  :home         
  :desktop      
  :documents    
  :downloads    
  :music        
  :pictures     
  :publicshare  
  :savedgames   
  :screenshots  
  :templates    
  :videos       
  :count)

(defcenum path-type
  :none
  :file
  :directory
  :other)

(deflsp-type path-info
  (type path-type)
  (size :uint64)
  (create-time stime)
  (modify-time stime)
  (access-time stime))

(defbitfield glob-flags
  (:glob-caseinsensitive 1))
