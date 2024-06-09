(local Concord (require :lib.concord))
(import-macros {: new-system} :macros.ecs)
(local ldraw love.graphics.draw)

(new-system ;draw-thrust
 {:pool [:position :acceleration :thrust-offset]}
 
 {:draw
  (fn draw [self]
    (let [world (self:getWorld)
          img (world:getResource :image.thrust)]
     (each [_ e (ipairs self.pool)]
        (ldraw img.img
               e.position.x e.position.y
               e.position.r
               img.sx img.sy
               (+ (/ img.width 2) e.thrust-offset.x) (- e.thrust-offset.y)))))})
         