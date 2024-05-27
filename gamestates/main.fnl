(local Concord (require :lib.concord))
(local C (require :components))
(local S (require :systems))
(local Parallax (require :lib.parallax))
(local Camera (require :lib.camera))
(import-macros With :macros.with)


;;; Game State
{:world (Concord.world)

 :init
 (fn init [self]
  (let [world self.world
        player-ship (love.graphics.newImage "assets/playerShip.png")
        camera (Camera.new 0 0)
        background (Parallax.new camera 0.25)]
    (world:addSystems
      S.input
      S.turn
      S.accelerate
      S.move
      S.camera
      S.draw)

    (-> (world:newEntity)
        (: :give :player)
        (: :give :position 0 0 0)
        (: :give :velocity 0 0)
        (: :give :drawable player-ship))
    
    (world:setResource :layer.bg background)
    (world:setResource :camera.main camera)
    (world:setResource :image.bg (love.graphics.newImage "assets/background.png"))))

 :update
 (fn update [self dt] (self.world:emit :update dt))

 :draw
 (fn draw [self]
  (love.graphics.setBackgroundColor 1 1 1)
  (let [world self.world
        camera (world:getResource :camera.main)
        bg-layer (world:getResource :layer.bg)
        bg-img (world:getResource :image.bg)]
    (With.camera camera
      (bg-layer:draw_tiled_xy 0 0 bg-img)
      (self.world:emit :draw))))

 :keypressed
 (fn keypressed [self key scancode repeat?]
   (if (= key :escape) (love.event.quit 0))
   (self.world:emit :keypressed key scancode repeat?))
 
 :keyreleased
 (fn keyreleased [self key scancode]
   (self.world:emit :keyreleased key scancode))}