(local off-x -250)
(local radius (* 5 1000))
(local woff 650)
(local ioff 300)
(local twopi (* math.pi 2))
(local halfpi (/ math.pi 2))
(local rand love.math.random)
(local v (require :lib.vector))
(local {: map-range} (require :util))

{:player-start [off-x radius (/ math.pi 2)]

 :start [0 radius math.pi]


 :asteroids
 (fcollect [n 1 40]
   (if (< n 6)
       (let [(x y) (v.fromPolar (map-range n 0 1 50 0 twopi) (- radius woff))]
         [x y false])
       (< n 24)
       (let [(x y) (v.fromPolar (map-range n 0 1 50 0 twopi) (+ radius woff))]
         [x y false])
       (let [(x y) (v.fromPolar (* (rand) twopi) (rand (- radius ioff) (+ radius ioff)))]
         [x y true])))

;  :asteroids
;  (fcollect [n 1 210]
;    (if (< n 50)
;        (let [(x y) (v.fromPolar (* (rand) twopi) (- radius woff))]
;          [x y false])
;        (< n 150)
;        (let [(x y) (v.fromPolar (* (rand) twopi) (+ radius woff))]
;          [x y false])
;        (let [(x y) (v.fromPolar (* (rand) twopi) (rand (- radius ioff) (+ radius ioff)))]
;          [x y true])))

 :checkpoints
 [[radius 0 halfpi]
  [0 (- radius) (- math.pi)]
  [(- radius) 0 (- halfpi)]]}