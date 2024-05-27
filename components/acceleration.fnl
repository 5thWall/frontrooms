(local Concord (require :lib.concord))

(Concord.component :acceleration
 (fn [c speed]
   (set c.speed speed)))