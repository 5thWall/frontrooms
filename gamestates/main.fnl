(local Concord (require :lib.concord))
(local C (require :components))
(local S (require :systems))

;;; Game State
{:world (Concord.world)

 :init
 (fn init [self]
  (let [world self.world
        player-ship (love.graphics.newImage "assets/playerShip.png")]
    (world:addSystems S.draw)
    (-> (world:newEntity)
        (: :give :player)
        (: :give :position 0 0 0)
        (: :give :drawable player-ship))))

 :update
 (fn update [self dt] (self.world:emit :update dt))

 :draw
 (fn draw [self]
  (love.graphics.setBackgroundColor 1 1 1)
  (self.world:emit :draw))

 :keypressed
 (fn keypressed [self key _scancode _repeat?]
   (if (= key :escape) (love.event.quit 0)))
}