(local ecs (require :lib.concord))
(local a (. (require :components) :A))
(local s (require :systems))
(local images (require :assets))
(local parallax (require :lib.parallax))
(local camera (require :lib.camera))
(import-macros with :macros.with)
(local load-level (require :levels))


;;; Game State
{:world (ecs.world)


 :init
 (fn init [self assets]
  (let [world self.world
        camera (camera.new 0 0)]
    (world:addSystems
      s.input
      s.turn
      s.accelerate
      s.move
      s.update-hitbox
      s.checkpoint-hit
      s.cross-checkpoint
      s.update-guide
      s.camera
      s.draw-thrust
      s.draw)
      ; s.draw-hitbox)

    (each [key img (pairs images)]
      (let [ikey (.. :image. key)]
        (print (.. "Setting Resource " ikey))
        (world:setResource ikey img)))
    (print "Finished loading resources")
    
    (load-level :01-Tutorial world)
    
    (world:setResource :layer.bg (parallax.new camera 1 0.01))
    (world:setResource :layer.st1 (parallax.new camera 1 0.10))
    (world:setResource :layer.st2 (parallax.new camera 1 0.25))
    (world:setResource :layer.st3 (parallax.new camera 1 0.30))
    (world:setResource :camera.main camera)))

 :update
 (fn update [self dt] (self.world:emit :update dt))

 :draw
 (fn draw [self]
  (love.graphics.setBackgroundColor 1 1 1)
  (let [world self.world
        camera (world:getResource :camera.main)
        bg-layer (world:getResource :layer.bg)
        bg-img (world:getResource :image.background)
        st1-layer (world:getResource :layer.st1)
        st1-img (world:getResource :image.stars1)
        st2-layer (world:getResource :layer.st2)
        st2-img (world:getResource :image.stars2)
        st3-layer (world:getResource :layer.st3)
        st3-img (world:getResource :image.stars3)]
    (with.camera camera
      (camera:zoomTo 1)
      (bg-layer:draw (fn [] (bg-layer:draw_tiled_xy 0 0 bg-img.img)))
      (st1-layer:draw (fn [] (st1-layer:draw_tiled_xy 0 0 st1-img.img)))
      (st2-layer:draw (fn [] (st2-layer:draw_tiled_xy 0 0 st2-img.img)))
      (st3-layer:draw (fn [] (st3-layer:draw_tiled_xy 0 0 st3-img.img)))
      (camera:zoomTo 0.5)
      (self.world:emit :draw))))

 :keypressed
 (fn keypressed [self key scancode repeat?]
   (if (= key :escape)
       (love.event.quit 0)
       (self.world:emit :keypressed key scancode repeat?)))
 
 :keyreleased
 (fn keyreleased [self key scancode]
   (self.world:emit :keyreleased key scancode))}