(local Concord (require :lib.concord))
(local s (require :lib.strike))
(import-macros {: new-system} :macros.ecs)

(new-system ;checkpoint-hit
 {:pool [:hitbox :checkpoint]
  :players [:hitbox :player]}
 
 {:update
  (fn update [self _dt]
    (let [player (. self.players 1)
          pbox player.hitbox.hitbox]
      (var hit? false)
      (each [_ e (ipairs self.pool)]
        (let [cbox e.hitbox.hitbox]
          (when (s.aabb pbox cbox)
            (print "close enough")
            (when (s.triking pbox cbox)
              (print "Strike detected")
              (set hit? true)
              (e:give :crossed))))
      
       (when hit?
             (let [world (self:getWorld)]
               (world:emit :crossing))))))})           