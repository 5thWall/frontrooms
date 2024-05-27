(local Concord (require :lib.concord))
(import-macros {: new-system} :macros.ecs)
(import-macros {: incf} :macros.util)

(fn x-component [tau m]
  (* m (math.sin tau)))

(fn y-component [tau m]
  (* -1 m (math.cos tau)))

(new-system ;accelerate
 {:pool [:acceleration :velocity]}
 
 {:update
  (fn update [self dt]
    (each [_ e (ipairs self.pool)]
      (let [tau e.position.r
            speed e.acceleration.speed]
          (incf e.velocity.dx (* dt (x-component tau speed)))
          (incf e.velocity.dy (* dt (y-component tau speed))))))})