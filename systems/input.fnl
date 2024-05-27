(local Concord (require :lib.concord))
(import-macros {: new-system} :macros.ecs)
(import-macros {: unless} :macros.util)


(fn up? [key scancode]
  (or (= key :up) (= scancode :w)))


(fn left? [key scancode]
  (or (= key :left) (= scancode :a)))


(fn right? [key scancode]
  (or (= key :right) (= scancode :d)))


(fn shoot? [key _scancode]
  (= key :space))



(new-system ;input
 {:pool [:player]}
 

 {:keypressed
  (fn keypressed [self key scancode repeat?]
    (fn accelerate []
      (each [_ e (ipairs self.pool)]
        (e:ensure :acceleration e.player.speed)))
    
    (fn rotate [dir]
      (each [_ e (ipairs self.pool)]
        (e:ensure :turn (* dir e.player.turn-speed))
        (set e.turn.speed e.player.turn-speed)))
    
    (fn shoot []
      (each [_ e (ipairs self.pool)]
        (e:ensure :shooting e.player.fire-rate)))
    
    (unless repeat?
      (if (up? key scancode)
          (accelerate)
          (left? key scancode)
          (rotate -1)
          (right? key scancode)
          (rotate 1)
          (shoot? key scancode)
          (shoot))))
  
  
  :keyreleased
  (fn keyreleased [self key scancode]

    (fn stop []
      (each [_ e (ipairs self.pool)]
        (if (e:has :acceleration)
            (e:remove :acceleration))))

    (fn stopt []
      (each [_ e (ipairs self.pool)]
        (if (e:has :turn)
            (e:remove :turn))))

    (fn stops []
      (each [_ e (ipairs self.pool)]
        (if (e:has :shoot)
            (e:remove :shoot))))
       

    (if (up? key scancode)
        (stop)
        (or (left? key scancode)
            (right? key scancode))
        (stopt)
        (shoot? key scancode)
        (stops)))})