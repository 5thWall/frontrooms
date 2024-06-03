(fn player [entity asset-key speed turn]
  (-> entity
      (: :give :player speed turn)
      (: :give :position 0 0 0)
      (: :give :velocity 0 0)
      (: :give :drawable asset-key)
      (: :give :hitbox asset-key)))
      


(fn checkpoint [entity x y tau]
  (-> entity
      (: :give :position x y tau)
      (: :give :drawable :image.checkpoint)
      (: :give :hitbox :image.checkpoint)
      (: :give :checkpoint)))

(fn endpoint [entity x y tau]
  (-> entity
      (: :give :position x y tau)
      (: :give :drawable :image.endpoint)
      (: :give :hitbox :image.endpoint)
      (: :give :checkpoint)))

{: player : checkpoint : endpoint}