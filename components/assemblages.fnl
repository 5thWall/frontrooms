(fn player [e asset-key speed turn]
  (-> (e:give :player speed turn)
      (: :give :position 0 0 0)
      (: :give :velocity 0 0)
      (: :give :drawable asset-key)))

{: player}