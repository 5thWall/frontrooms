(local {: entity} (require :lib.concord))
(local {: A} (require :components))
(local checkpoint A.checkpoint)
(local endpoint A.endpoint)

{:checkpoints
 [(: (entity) :assemble checkpoint 125 0 0 0)
  (: (entity) :assemble endpoint 1000 0 0)]}