(local Concord (require :lib.concord))

(Concord.component :thrust-offset
 (fn [c x y]
   (set c.x (or x 0))
   (set c.y (or y c.x))))