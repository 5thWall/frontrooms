(fn player [entity asset-key speed turn]
  (-> entity
      (: :give :player speed turn)
      (: :give :position 0 0 0)
      (: :give :velocity 0 0)
      (: :give :drawable asset-key)))


(fn checkpoint [entity x y tau]
  (-> entity
      (: :give :position x y tau)
      (: :give :drawable :image.checkpoint)
      ; (: :give :collidable :box tau len)
      (: :give :checkpoint)))

(fn endpoint [entity x y tau]
  (-> entity
      (: :give :position x y tau)
      (: :give :drawable :image.endpoint)
      (: :give :checkpoint)))

{: player : checkpoint : endpoint}