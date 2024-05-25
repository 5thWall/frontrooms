(local Concord (require :lib.concord))

(Concord.component
 :drawable
 (fn [c image]
   (set c.img image)
   (set c.w (image:getWidth))
   (set c.h (image:getHeight))))