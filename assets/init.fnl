(local new-image love.graphics.newImage)
(local V (require :lib.vector))
(local rand love.math.random)
(local G love.graphics)
(import-macros with :macros.with)

;;;; Asset loding and generation
;;;; Loads images and constructs usefull trees/maps/etc...


;;; Asset Loading
(fn img [fname]
  (let [img (new-image (.. :assets/ fname))
        height (img:getHeight)
        width (img:getWidth)]
    {
      : img : height : width
      :radius (/ (V.len height width) 2)}))


;;; Starfield Stuff
(local star1 (new-image :assets/star1.png))
(local star2 (new-image :assets/star2.png))
(local star3 (new-image :assets/star3.png))


(fn gen-starfield [width height num star sx sy]
  (let [canvas (G.newCanvas width height)
        sw2 (/ (star:getWidth) 2)
        sh2 (/ (star:getHeight) 2)
        w (- width sw2)
        h (- height sh2)]
    (with.canvas canvas
      (for [_ 1 num]
        (G.draw star
                (rand sw2 w) (rand sh2 h)
                0
                sx sy
                sw2 sh2)))
    
    {:img canvas
     : width
     : height
     :radius (/ (V.len w h) 2)}))


;;; Check/Endpoints
(local check-blue (new-image :assets/checkBlue.png))
(local check-yellow (new-image :assets/checkYellow.png))
(local end-blue (new-image :assets/endBlue.png))
(local end-yellow (new-image :assets/endYellow.png))
(local line-blue (new-image :assets/lineBlue.png))
(local line-red (new-image :assets/lineRed.png))
(local line-green (new-image :assets/lineGreen.png))


(fn checkpoint [blue yellow line scale expansion]
 (let [;; yellow middle
       ylw2 (/ (yellow:getWidth) 2) 
       ylh2 (/ (yellow:getHeight) 2)

       ;; blue middle
       blw2 (/ (blue:getWidth) 2)
       blh2 (/ (blue:getHeight) 2)

       ;; linje middle
       lnw2 (/ (line:getWidth) 2)
       lnh2 (/ (* expansion (line:getHeight)) 2)
       lnvh2 (/ (- (* expansion (line:getHeight)) ;; visible line middle
                   ylh2 blh2)
                2)
       
       ;; canvas size
       width (* 2 scale (math.max ylw2 blw2))
       height (* 2 scale (+ lnvh2 ylh2 blh2))
       canvas (G.newCanvas width height)

       ;; canzas middle
       w2 (/ width 2)
       h2 (/ height 2)]
    (with.canvas canvas
      ;; Bounding box
      (with.color 1 1 1 1
        (G.setLineStyle :rough)
        (G.setLineWidth 5)
        (G.line 0 0
                width 0
                width height
                0 height
                0 0))
       
      ;; Draw the line
      (G.draw line
              w2 h2 ;; x y
              0     ;; r
              scale (* scale expansion) ;; sx sy
              lnw2 (/ lnh2 expansion)) ;; ox oy
    
      ;; Draw Blue
      (G.draw blue
              w2 (- h2 (* scale lnh2))
              0
              scale scale
              blw2 blh2)
    
      ;; Draw Yellow
      (G.draw yellow
              w2 (+ h2 (* scale lnh2))
              math.pi
              scale scale
              ylw2 ylh2))
      
    {:img canvas
     : width
     : height
     :radius (/ (V.len width height) 2)}))

;; All Together!
{;Assets
  :background (img :background.png)
  :checkpoint (checkpoint check-blue check-yellow line-blue 3 8) 
  :checkpoint-deactivated (checkpoint check-blue check-yellow line-red 3 8)
  :endpoint (checkpoint end-blue end-yellow line-green 3 8)
  :endpoint-deactivated (checkpoint end-blue end-yellow line-red 3 8)
  :playerShip (img :playerShip.png)
  :stars1 (gen-starfield 1500 1500 75 star1 0.8 0.5)
  :stars2 (gen-starfield 1500 1500 50 star2 0.6 0.5)
  :stars3 (gen-starfield 1500 1500 25 star3 0.5 0.5)}
 