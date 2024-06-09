(local off-x -250)
(local radius (* 5 1000))
(local woff 650)
(local ioff 300)
(local rand love.math.random)
(local v (require :lib.vector))

{:player-start [off-x radius (/ math.pi 2)]

 :start [0 radius math.pi]


 :asteroids
 (fcollect [n 1 210]
   (if (< n 50)
       (let [(x y) (v.fromPolar (* (rand) 2 math.pi) (- radius woff))]
         [x y false])
       (< n 150)
       (let [(x y) (v.fromPolar (* (rand) 2 math.pi) (+ radius woff))]
         [x y false])
       (let [(x y) (v.fromPolar (* (rand) 2 math.pi) (rand (- radius ioff) (+ radius ioff)))]
         [x y true])))

 :checkpoints
 [[radius 0 (/ math.pi 2)]
  [0 (- radius) math.pi]
  [(- radius) 0 (/ math.pi -2)]]}