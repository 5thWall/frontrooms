(local Concord (require :lib.concord))

(Concord.component
 :drawable
 (fn [c image]
   (set c.img image)
   (set c.width (image:getWidth))
   (set c.height (image:getHeight))))