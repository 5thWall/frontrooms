(local Concord (require :lib.concord))
(local V (require :lib.vector))

(Concord.component
 :drawable
 (fn [c key]
   (set c.key key)))