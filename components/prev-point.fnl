(local Concord (require :lib.concord))

(Concord.component :prev-point
 (fn [c point]
   (set c.point point)))