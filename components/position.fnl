(local Concord (require :lib.concord))

(Concord.component
 :position
 (fn [c x y r]
   (set c.x (or x 0))
   (set c.y (or y 0))
   (set c.r (or r 0))))