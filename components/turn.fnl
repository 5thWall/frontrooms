(local Concord (require :lib.concord))

(Concord.component :turn
 (fn [c turn-speed]
   (set c.turn-speed turn-speed)))