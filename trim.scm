(define (Make-Border image drawable)
    (let* (
            ; variables you can modify yourself:
            (long 800)    ; define the value in pixels of the longest length you want your image to have (the horizontal length of a landscape photo)
            (short 532)   ; define the value in pixels of the shortest length you want your image to have (the vertical length of a landscape photo)
            (horipath "C:/Fotos/Hori.png")     ; define path of border image for horizontal photos 
            (vertipath "C:/Fotos/Verti.png")   ; define path of border image for vertical photos
            (squarepath "C:/Fotos/Square.png") ; define path of border image for square photos
            ; other vars you shouldn't modify:
            (wval  (car (gimp-image-width image)))
            (hval (car (gimp-image-height image)))
            (back-layer 0)
       )
   (if (> hval wval)            ; check if verti
            (begin
            (gimp-image-scale image short long)
            (set! back-layer(car (gimp-file-load-layer RUN-NONINTERACTIVE image vertipath)))
            )
       )
   (if (< hval wval)            ; check if hori
            (begin
            (gimp-image-scale image long short)
            (set! back-layer(car (gimp-file-load-layer RUN-NONINTERACTIVE image horipath)))
            )
       )
   (if (= hval wval)            ; check if square
            (begin
            (gimp-image-scale image short short)
            (set! back-layer(car (gimp-file-load-layer RUN-NONINTERACTIVE image squarepath)))
            )
       )
    (gimp-image-insert-layer image back-layer -1 0)
    (gimp-displays-flush)
  )
)
(script-fu-register "Make-Border"
                    "Auto-resize, create layer, add border, done!"
                    "Script by Bulevardi"
                    "Copyright (C) 2015 Bulevardi"
                    "BLVD i"
                    "Version 0.1"
                    "*"
                    SF-IMAGE "Input Image" 0
                    SF-DRAWABLE "Input Drawable" 0
)
(script-fu-menu-register "Make-Border" "<Image>/Bulevardi Scripts/")
