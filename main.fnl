(local Gamestate (require :lib.gamestate))

(fn love.load []
  (love.mouse.setGrabbed true)
  ;; start a thread listening on stdin
  (: (love.thread.newThread "require('love.event')
while 1 do love.event.push('stdin', io.read('*line')) end") :start)

  (Gamestate.registerEvents)
  (Gamestate.switch (require :gamestates.main)))

(fn love.handlers.stdin [line]
  ;; evaluate lines read from stdin as fennel code
  (let [(ok val) (pcall fennel.eval line)]
    (print (if ok (fennel.view val) val))))

