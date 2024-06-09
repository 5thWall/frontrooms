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


{: player : checkpoint : endpoint}