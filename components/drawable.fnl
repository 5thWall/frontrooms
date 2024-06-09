(local Concord (require :lib.concord))
(local V (require :lib.vector))

(Concord.component
 :drawable
 (fn [c key sx sy]
   (set c.key key)
   (set c.sx (or sx 0.65))
   (set c.sy (or sy c.sx))))