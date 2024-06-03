(local Concord (require :lib.concord))
(local g love.graphics)
(import-macros {: new-system} :macros.ecs)
(import-macros with :macros.with)

(new-system ;draw-hitbox
 {:pool [:hitbox :position]}
 
 {:draw
  (fn draw [self dt]
    (each [_ e (ipairs self.pool)]
      (let [(x1 y1 dx dy) (e.hitbox.hitbox:getBbox)
            x2 (+ x1 dx)
            y2 (+ y1 dy)
            ox e.position.x
            oy e.position.y]
        (g.push)
        (with.color 1 0 0 1
          (g.line x1 y1
                  x2 y1
                  x2 y2
                  x1 y2
                  x1 y1))
        (g.pop))))})