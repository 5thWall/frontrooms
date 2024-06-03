(local Concord (require :lib.concord))
(import-macros {: new-system} :macros.ecs)

(new-system ;move-hitbox
 {:pool [:hitbox :position]}
 
 {:update
  (fn update [self _dt]
    (each [_ e (ipairs self.pool)]
      (when (not e.hitbox.hitbox)
            (let [world (self:getWorld)
                  asset (world:getResource e.hitbox.key)]
              (set e.hitbox.hitbox (asset.hitbox:copy))))
      (let [hitbox e.hitbox.hitbox
            x e.position.x
            y e.position.y
            r e.position.r]
        (hitbox:translateTo x y)
        (hitbox:rotateTo r y))))})