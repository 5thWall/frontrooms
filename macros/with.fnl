(fn camera [camera & body]
 `(do (: ,camera :attach)
      ,body
      (: ,camera :detach)))


(fn canvas [canvas & body]
 `(do (love.graphics.setCanvas canvas)
      ,body
      (love.graphics.setCanvas)))


(fn color [r g b a & body]
  `(let [(r# g# b# a#) (love.graphics.getColor)]
     (love.graphics.setColor ,r ,g ,b ,a)
     ,body
     (love.graphics.setColor r# g# b# a#)))


(fn shader [g shader & body]
  `(do (love.graphics.setShader ,shader)
       ,body
       (love.graphics.setShader)))


;; Exports
{: camera : canvas : color : shader}
