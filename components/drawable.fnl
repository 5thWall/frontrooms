(local Concord (require :lib.concord))
(local V (require :lib.vector))

(Concord.component
 :drawable
 (fn [c image]
   (set c.img image)
   (set c.width (image:getWidth))
   (set c.height (image:getHeight))
   (set c.r (/ (V.len c.width c.height) 2))))