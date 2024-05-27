(local Concord (require :lib.concord))
(local V (require :lib.vector))
(local {:map-range map : clamp} (require :util))
(import-macros {: new-system} :macros.ecs)

(local max-speed (math.pow 500 2))

(new-system ;camera
 {:players [:player :position]}
 
 {:update
  (fn update [self _dt]
    (let [player (. self.players 1) ;; minimum information needed for the camera
          (vx vy) (values player.velocity.dx player.velocity.dy)
          world (self:getWorld)
          camera (world:getResource :camera.main)
          ; pradius (. (world:getResource player.drawable.key) :radius)
          (width height) (love.window.getMode)
          smallest (math.min height width)
          radius (/ (math.min (- smallest (/ smallest 10))
                              (- smallest (* 4.5 60)))
                    2)            
          speed (clamp (V.len2 vx vy) 0 max-speed)
          (dx dy) (V.normalize vx vy) ;; normal movement vector
          (xoff yoff) (V.mul (map speed 0 max-speed 0 radius) dx dy)]
      (print player.drawable.key)
      ; (print (.. "Speed: " (* 100 (/ speed max-speed)) "%"))
      (camera:lockPosition (+ player.position.x xoff)
                           (+ player.position.y yoff))))}) ;; otherwise focus on the player
     