(local ecs (require :lib.concord))

(ecs.component :next-point
 (fn [c point]
   (set c.point point)))