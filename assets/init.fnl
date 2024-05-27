(local new-image love.graphics.newImage)
(local V (require :lib.vector))
(local rand love.math.random)
(local G love.graphics)


(local star1 (new-image :assets/star1.png))
(local star2 (new-image :assets/star2.png))
(local star3 (new-image :assets/star3.png))


(fn gen-starfield [width height num star scale]
  (let [canvas (G.newCanvas width height)
        sw2 (/ (star:getWidth) 2)
        sh2 (/ (star:getHeight) 2)
        w (- width sw2)
        h (- height sh2)]
    (G.setCanvas canvas)
    (for [_ 1 num]
      (G.draw star
              (rand sw2 w) (rand sh2 h)
              0
              scale scale
              sw2 sh2))
              
    (G.setCanvas)
    
    {:img canvas
     :width w
     :height h
     :radius (/ (V.len w h) 2)}))


(fn img [fname]
  (let [img (new-image (.. :assets/ fname))
        height (img:getHeight)
        width (img:getWidth)]
    {
      : img : height : width
      :radius (/ (V.len height width) 2)}))

{;Assets
  :background (img :background.png)
  :playerShip (img :playerShip.png)
  :stars1 (gen-starfield 1500 1500 150 star1 0.5)
  :stars2 (gen-starfield 1500 1500 100 star2 0.5)
  :stars3 (gen-starfield 1500 1500 50 star3 0.5)}
 