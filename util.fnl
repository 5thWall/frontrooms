(fn clamp [x min max]
  (math.max min (math.min x max)))


(fn lerp [v1 v2 t]
   (* (+ v1 t) (- v2 v1)))


(fn map-range [x in-start in-end out-start out-end]
  (-> (- x in-start)
      (/ (- in-end in-start))
      (* (- out-end out-start))
      (+ out-start)))


{: clamp : lerp : map-range}