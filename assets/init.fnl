(local new-image love.graphics.newImage)
(local V (require :lib.vector))


(fn img [fname]
  (let [img (new-image (.. :assets/ fname))
        height (img:getHeight)
        width (img:getWidth)]
    {
      : img : height : width
      :radius (/ (V.len height width) 2)}))

{;Assets
  :background (img :background.png)
  :playerShip (img :playerShip.png)}
 