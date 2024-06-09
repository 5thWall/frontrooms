(local a (. (require :components) :A))
(local checkpoint a.checkpoint)
(local endpoint a.endpoint)
(local player a.player)

(fn load-level [name world]
  (let [level (require (.. :levels. name))
        (sx sy stau) (unpack level.start)]
    ;; Starting line
    (local start (-> (world:newEntity)
                     (: :assemble endpoint sx sy stau)))
    
    (-> (world:newEntity)
        (: :give :guide start)
        (: :give :position sx sy)
        (: :give :drawable :image.arrow 0.2 0.2))
    
    (var prev start) ;; hold on to the chain
    
    ;; Add checkpoints
    (each [_ chk (ipairs level.checkpoints)]
      (let [(x y tau) (unpack chk)
            point (-> (world:newEntity) ;; make checkpoint
                      (: :assemble checkpoint x y tau)
                      (: :give :active)
                      (: :give :prev-point prev))]
        (prev:give :next-point point)
        (set prev point)))
    (prev:give :next-point start)
    
    ;; Set player position
    (let [(x y tau) (unpack level.player-start)]
      (-> (world:newEntity)
          (: :assemble player x y tau)))))