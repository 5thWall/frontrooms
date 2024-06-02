(local Concord (require :lib.concord))
(local {: A} (require :components))
(local S (require :systems))
(local images (require :assets))
(local Parallax (require :lib.parallax))
(local Camera (require :lib.camera))
(import-macros With :macros.with)
(local load-level (require :levels))


;;; Game State
{:world (Concord.world)


 :init
 (fn init [self assets]
  (let [world self.world
        camera (Camera.new 0 0)]
    (world:addSystems
      S.input
      S.turn
      S.accelerate
      S.move
      S.camera
      S.draw)

    (each [key img (pairs images)]
      (let [ikey (.. :image. key)]
        (print (.. "Setting Resource " ikey))
        (world:setResource ikey img)))
    (print "Finished loading resources")

    (-> (world:newEntity)
        (: :assemble A.player :image.playerShip))
    
    (load-level :01-Tutorial world)
    
    (world:setResource :layer.bg (Parallax.new camera 1 0.01))
    (world:setResource :layer.st1 (Parallax.new camera 1 0.10))
    (world:setResource :layer.st2 (Parallax.new camera 1 0.25))
    (world:setResource :layer.st3 (Parallax.new camera 1 0.30))
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
    (With.camera camera
      (bg-layer:draw (fn [] (bg-layer:draw_tiled_xy 0 0 bg-img.img)))
      (st1-layer:draw (fn [] (st1-layer:draw_tiled_xy 0 0 st1-img.img)))
      (st2-layer:draw (fn [] (st2-layer:draw_tiled_xy 0 0 st2-img.img)))
      (st3-layer:draw (fn [] (st3-layer:draw_tiled_xy 0 0 st3-img.img)))
      (self.world:emit :draw))))

 :keypressed
 (fn keypressed [self key scancode repeat?]
   (if (= key :escape)
       (love.event.quit 0)
       (self.world:emit :keypressed key scancode repeat?)))
 
 :keyreleased
 (fn keyreleased [self key scancode]
   (self.world:emit :keyreleased key scancode))}