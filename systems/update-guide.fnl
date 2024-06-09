(local Concord (require :lib.concord))
(import-macros {: new-system} :macros.ecs)
(local v (require :lib.vector))
(local from-ship 200) ;; How far away from the ship the guide appears

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
              (dx dy) (v.add px py ;; translated to the player
                             (v.mul from-ship ;; THE line but from origin
                               (v.normalize (v.sub cx cy px py)))) ;; normal from player to checkpoint
              tau (v.angleTo (v.sub cx cy dx dy))]
          ; (print (.. px :: py :| ax :: ay :| dx :: dy :| tau))
          (set e.position.x dx)
          (set e.position.y dy)
          (set e.position.r tau)))))})
  

  ; :draw
  ; (fn draw [self])})