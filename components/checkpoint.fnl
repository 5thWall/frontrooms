(local Concord (require :lib.concord))

(Concord.component :checkpoint
  (fn [c start? active-img inactive-img]
    (set c.start? start?)
    (set c.active-key active-img)
    (set c.inactive-key inactive-img)))