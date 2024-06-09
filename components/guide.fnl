(local ecs (require :lib.concord))

(ecs.component :guide
 (fn [c to] (set c.to to)))