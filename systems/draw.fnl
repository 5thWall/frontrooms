(local Concord (require :lib.concord))
(import-macros With :macros.with)
(import-macros {: new-system} :macros.ecs)

(local draw love.graphics.draw)

(new-system ;draw
 {:pool [:position :drawable]}
 
 {:draw
  (fn draw [self]
    (each [_ e (ipairs self.pool)]
      (draw e.drawable.img
            e.position.x e.position.y
            e.position.r
            1 1
            (/ e.drawable.width 2) (/ e.drawable.height 2))))})