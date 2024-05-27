(local Concord (require :lib.concord))
(import-macros {: incf} :macros.util)
(import-macros {: new-system} :macros.ecs)

(new-system ;move
 {:pool [:position :velocity]}
 
 {:update
  (fn update [self dt]
    (each [_ e (ipairs self.pool)]
       (incf e.position.x (* e.velocity.dx dt))
       (incf e.position.y (* e.velocity.dy dt))))})