(local Concord (require :lib.concord))
(import-macros {: new-system} :macros.ecs)

(new-system ;cross-checkpoint
 {:pool [:checkpoint :crossed]}
 
 {:crossing
  (fn crossing [self _dt]
    (each [_ e (ipairs self.pool)]
      (set e.drawable.key e.checkpoint.inactive-key)
      (e:remove :crossed)
      (e:remove :active)))})