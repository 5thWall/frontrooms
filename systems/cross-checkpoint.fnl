(local Concord (require :lib.concord))
(import-macros {: new-system} :macros.ecs)

(new-system ;cross-checkpoint
 {:pool [:checkpoint :crossed]}
 
 {:crossing
  (fn crossing [self _dt]
    (each [_ e (ipairs self.pool)]
      (set e.drawable.key :image.checkpoint-deactivated)
      (e:remove :crossed)))})