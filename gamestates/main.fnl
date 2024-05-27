(local Concord (require :lib.concord))
(local A (. (require :components) :A))
(local S (require :systems))
(local I (require :assets))
(local Parallax (require :lib.parallax))
(local Camera (require :lib.camera))
(import-macros With :macros.with)


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

    (each [key img (pairs I)]
      (let [ikey (.. :image. key)]
        (print (.. "Setting Resource " ikey))
        (world:setResource ikey img)))

    (-> (world:newEntity)
        (: :assemble A.player :image.playerShip))
    
    (world:setResource :layer.bg1 (Parallax.new camera 0.25))
    ; (world:setResource :layer.bg2 (Parallax.new camera 0.50))
    ; (world.setResource :layer.bg3 (Parallax.new camera 0.75))
    (world:setResource :camera.main camera)))

 :update
 (fn update [self dt] (self.world:emit :update dt))

 :draw
 (fn draw [self]
  (love.graphics.setBackgroundColor 1 1 1)
  (let [world self.world
        camera (world:getResource :camera.main)
        bg-layer (world:getResource :layer.bg1)
        bg-img (world:getResource :image.background)]
    (With.camera camera
      (bg-layer:draw_tiled_xy 0 0 bg-img.img)
      (self.world:emit :draw))))

 :keypressed
 (fn keypressed [self key scancode repeat?]
   (if (= key :escape)
       (love.event.quit 0)
       (self.world:emit :keypressed key scancode repeat?)))
 
 :keyreleased
 (fn keyreleased [self key scancode]
   (self.world:emit :keyreleased key scancode))}