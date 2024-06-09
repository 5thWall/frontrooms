(local Concord (require :lib.concord))
(local V (require :lib.vector))

(Concord.component
 :drawable
 (fn [c key sx sy]
   (set c.key key)
   (set c.sx (or sx 0.5))
   (set c.sy (or sy c.sx))))