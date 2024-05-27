(local Concord (require :lib.concord))
(import-macros {: new-system} :macros.ecs)
(import-macros {: incf} :macros.util)

(new-system ;turn
 {:pool [:turn :position]}
 
 {:update
  (fn update [self dt]
    (each [_ e (ipairs self.pool)]
      (incf e.position.r (* dt e.turn.turn-speed))))})