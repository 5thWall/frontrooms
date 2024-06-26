(love.filesystem.setRequirePath "?.lua;?/init.lua")
(local G (require :lib.gamestate))
(local GS (require :gamestates))
    

(fn love.load []
  ; (love.mouse.setGrabbed true)
  (if fennel
    ;; start a thread listening on stdin
    (: (love.thread.newThread "require('love.event')
        while 1 do love.event.push('stdin', io.read('*line')) end") :start))
      
  (require :assets)

  (G.registerEvents)
  (G.switch GS.main))

(if fennel
  (fn love.handlers.stdin [line]
    ;; evaluate lines read from stdin as fennel code
    (let [(ok val) (pcall fennel.eval line)]
      (print (if ok (fennel.view val) val)))))

