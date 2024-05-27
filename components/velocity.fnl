(local Concord (require :lib.concord))

(Concord.component :velocity
 (fn [c dx dy]
    (set c.dx (or dx 0))
    (set c.dy (or dy 0))))
   