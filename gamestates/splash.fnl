(local o-ten-one (require :lib.o-ten-one))
(local G (require :lib.gamestate))
(local main (require :gamestates.main))


{:init
 (fn init [self]
   (set self.splash (o-ten-one))
   (set self.splash.onDone (fn [] (G.switch main))))

 :update
 (fn update [self dt]
   (self.splash:update dt))

 :draw
 (fn draw [self]
   (self.splash:draw))

 :keypressed
 (fn keypressed [self]
   (self.splash:skip))

 :leave
 (fn leave []
   (love.graphics.setShader)
   (love.graphics.setCanvas)
   (love.graphics.setBlendMode :alpha))}