(local Concord (require :lib.concord))


(fn d2r [t] (/ (* t math.pi) 180))


(Concord.component :player
  (fn [c speed turn-speed]
    (set c.speed (or speed 50))
    (set c.turn-speed (d2r (or turn-speed 180)))))