(local Concord (require :lib.concord))
(import-macros {: new-system} :macros.ecs)

(new-system ;cross-checkpoint
 {:pool [:checkpoint :crossed]
  :guides [:guide]}
 
 {:crossing
  (fn crossing [self _dt]
    (each [_ e (ipairs self.pool)]
      (set e.drawable.key e.checkpoint.inactive-key)
      (e:remove :crossed)
      (e:remove :active)
      (let [next e.next-point.point]
        (next:give :active)
        (set next.drawable.key next.checkpoint.active-key)
        (each [_ g (ipairs self.guides)]
          (if (= g.guide.to e) (set g.guide.to next))))))})