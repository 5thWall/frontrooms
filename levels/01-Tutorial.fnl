(local {: entity} (require :lib.concord))
(local {: A} (require :components))
(local checkpoint A.checkpoint)
(local endpoint A.endpoint)

{:checkpoints
 [(: (entity) :assemble endpoint 125 0 0 0)
  (: (entity) :assemble checkpoint 1000 0 0 0)]}