(local Concord (require :lib.concord))
(import-macros {: new-system} :macros.ecs)

(local ldraw love.graphics.draw)

(new-system ;draw
 {:pool [:position :drawable]}
 
 {:draw
  (fn [self]
    (each [_ e (ipairs self.pool)]
      ; (print (.. "Drawing " e.drawable.key))
      (let [world (self:getWorld)
            res (world:getResource e.drawable.key)]
        (ldraw res.img
              e.position.x e.position.y
              e.position.r
              1 1
              (/ res.width 2) (/ res.height 2)))))})