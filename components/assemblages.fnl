(local rand love.math.random)
(local twopi (* 2 math.pi))


(fn player [entity x y tau]
  (-> entity
      (: :give :player 50 180)
      (: :give :position x y tau)
      (: :give :velocity 0 0)
      (: :give :drawable :image.playerShip)
      (: :give :hitbox :image.playerShip)
      (: :give :thrust-offset 0 24)))
      

(fn checkpoint [entity x y tau]
  (-> entity
      (: :give :position x y tau)
      (: :give :drawable :image.checkpoint)
      (: :give :hitbox :image.checkpoint)
      (: :give :checkpoint false :image.checkpoint :image.checkpoint-deactivated)))


(fn endpoint [entity x y tau]
  (-> entity
      (: :give :position x y tau)
      (: :give :drawable :image.endpoint)
      (: :give :hitbox :image.endpoint)
      (: :give :active)
      (: :give :checkpoint true :image.endpoint :image.endpoint-deactivated)))


(local masteroids
 [:image.masteroid1
  :image.masteroid2
  :image.masteroid3
  :image.masteroid4])

(local asteroids
 [:image.asteroid1
  :image.asteroid2
  :image.asteroid3
  :image.asteroid4])
  
 
(fn getrand [table]
  (. table (rand (length table))))

(fn asteroid [entity x y moveable?]
  (var asset nil)
  (if moveable? (set asset (getrand masteroids)) (set asset (getrand asteroids)))
  (-> entity
      (: :give :position x y (rand 0 twopi))
      (: :give :drawable asset)
      (: :give :hitbox asset)))


{: player : checkpoint : endpoint : asteroid}