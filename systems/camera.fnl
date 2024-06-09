(local Concord (require :lib.concord))
(local V (require :lib.vector))
(local {:map-range map : clamp} (require :util))
(local get-window-wh love.window.getMode)
(import-macros {: new-system} :macros.ecs)

(local max-speed (math.pow 250 2))

(new-system ;camera
 {:players [:player :position]}
 
 {:update
  (fn update [self _dt]
    (let [player (. self.players 1) ;; minimum information needed for the camera
          (vx vy) (values player.velocity.dx player.velocity.dy)
          world (self:getWorld)
          camera (world:getResource :camera.main)
          pradius (. (world:getResource player.drawable.key) :radius)
          (width height) (get-window-wh)
          window-size (math.min height width)
          radius (- (* 5 pradius) (/ window-size 2))
          speed (clamp (V.len2 vx vy) 0 max-speed)
          (dx dy) (V.normalize vx vy)
          (xoff yoff) (V.mul (map speed 0 max-speed 0 radius) dx dy)]
      ; (print (.. "Speed: " (* 100 (/ speed max-speed)) "%"))
      (camera:lockPosition (+ player.position.x xoff)
                           (+ player.position.y yoff))))})
     