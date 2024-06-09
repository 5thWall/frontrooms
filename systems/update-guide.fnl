(local Concord (require :lib.concord))
(import-macros {: new-system} :macros.ecs)
(local v (require :lib.vector))
(local tau-offset (/ math.pi 2))

(new-system ;update-guide
 {:pool [:guide :position :drawable]
  :players [:player :position]}
 
 {:update
  (fn update [self dt]
    (let [player (. self.players 1)
          px player.position.x
          py player.position.y]
      (each [_ e (ipairs self.pool)]
        (let [cx e.guide.to.position.x
              cy e.guide.to.position.y
              (dx dy) (v.mul 200 (v.normalize (v.sub cx cy px py)))
              (ax ay) (v.add px py dx dy)
              tau (+ tau-offset (v.angleTo (v.sub cx cy ax ay)))]
          ; (print (.. px :: py :| ax :: ay :| dx :: dy :| tau))
          (set e.position.x ax)
          (set e.position.y ay)
          (set e.position.r tau)))))})
  

  ; :draw
  ; (fn draw [self])})