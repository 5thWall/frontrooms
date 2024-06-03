(local ecs (require :lib.concord))

(ecs.component :hitbox
 (fn [c key]
   (set c.key key)))