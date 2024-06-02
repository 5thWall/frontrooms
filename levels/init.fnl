(fn load-level [name world]
  (let [level (require (.. :levels. name))]
    (each [_ chk (ipairs level.checkpoints)]
      (world:addEntity chk))))