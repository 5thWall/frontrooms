(local g love.graphics)
(local new-image g.newImage)
(local rand love.math.random)
(local v (require :lib.vector))
(local s (require :lib.strike))
(import-macros with :macros.with)


;;; Asset Loading
(fn img [fname roff]
  (let [img (new-image (.. :assets/ fname))
        width (img:getWidth) 
        height (img:getHeight)
        radius (/ (v.len width height) 2)
        roff (or roff 0)
        ; hitbox (s.trikers.Circle 0 0 radius 0)
        hitbox (s.trikers.Rectangle 0 0 width height 0)]
    {: img : height : width : hitbox : roff : radius}))


(fn with-hitbox [img]
  (set img.hitbox (s.trikers.Rectangle 0 0 img.width img.height 0))
  img)


;;; Starfield Stuff
(local star1 (new-image :assets/star1.png))
(local star2 (new-image :assets/star2.png))
(local star3 (new-image :assets/star3.png))


(fn gen-starfield [width height num star sx sy]
  (let [canvas (g.newCanvas width height)
        sw2 (/ (star:getWidth) 2)
        sh2 (/ (star:getHeight) 2)
        w (- width sw2)
        h (- height sh2)]
    (with.canvas canvas
      (for [_ 1 num]
        (g.draw star
                (rand sw2 w) (rand sh2 h)
                0
                sx sy
                sw2 sh2)))
    
    {:img canvas
     : width
     : height
     :roff 0
     :radius (/ (v.len w h) 2)}))


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

       ;; line middle
       lnw2 (/ (line:getWidth) 2)
       lnh2 (/ (* expansion (line:getHeight)) 2)
       lnvh2 (- (/ (* expansion (line:getHeight)) 2) 
               ylh2 blh2)
       lndx (* 4 lnw2)
       lndy (* 4 lnvh2)
       chbb (s.trikers.Rectangle 0 0 lndx lndy)
       
       ;; canvas size
       width (* 2 scale (math.max ylw2 blw2))
       height (* 2 scale (+ lnh2 ylh2 blh2))
       canvas (g.newCanvas width height)

       ;; canzas middle
       w2 (/ width 2)
       h2 (/ height 2)]
    (with.canvas canvas
      (g.push)
      (g.translate w2 h2)
      (g.scale scale scale)

      ;; Frame
      ; (with.color 1 1 1 1
      ;   (g.setLineWidth 5)
      ;   (g.line 0 0
      ;           width 0
      ;           width height
      ;           0 height
      ;           0 0))
       
      ;; Draw the line
      (g.draw line
              0 0 ;; x y
              0     ;; r
              1 expansion ;; sx sy
              lnw2 (/ lnh2 expansion)) ;; ox oy
    
      ;; Draw Blue
      (g.draw blue
              0 (- lnh2)
              0
              1 1
              blw2 blh2)
    
      ;; Draw Yellow
      (g.draw yellow
              0 lnh2
              math.pi
              1 1
              ylw2 ylh2)
      (g.pop))
      
    {:img canvas
     : width
     : height
     :hitbox chbb
     :roff 0
     :radius (/ (v.len width height) 2)}))

;; All Together!
{;Assets
  :arrow (img :arrow.png (/ math.pi 2))
  :background (img :background.png)
  :checkpoint (checkpoint check-blue check-yellow line-blue 3 8) 
  :checkpoint-deactivated (checkpoint check-blue check-yellow line-red 3 8)
  :endpoint (checkpoint end-blue end-yellow line-green 3 8)
  :endpoint-deactivated (checkpoint end-blue end-yellow line-red 3 8)
  :playerShip (-> (img :playerShip.png)
                  (with-hitbox))
  :speed (img :speed.png math.pi)
  :stars1 (gen-starfield 1500 1500 75 star1 0.8 0.5)
  :stars2 (gen-starfield 1500 1500 50 star2 0.6 0.5)
  :stars3 (gen-starfield 1500 1500 25 star3 0.5 0.5)
  :thrust (img :thrust.png)}
 