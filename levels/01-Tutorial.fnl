(local off-x -250)
(local radius (* 5 100000))

{:player-start [off-x radius (/ math.pi 2)]

 :start [0 radius math.pi]

 :checkpoints
 [[radius 0 (/ math.pi 2)]
  [0 (- radius) math.pi]
  [(- radius) 0 (/ math.pi -2)]]}