;;;; Utility Macros

;; https://gitlab.com/alexjgriffith/min-love2d-fennel
(fn incf [value ?by]
  `(set ,value (+ ,value ,(or ?by 1))))


;; https://gitlab.com/alexjgriffith/min-love2d-fennel
(fn decf [value ?by]
  `(set ,value (- ,value ,(or ?by 1))))


;; https://gitlab.com/alexjgriffith/min-love2d-fennel
(fn with [t keys ?body]
  `(let [,keys ,t]
     (if ,?body
         ,?body
         ,keys)))


(fn unless [cond & body]
  `(when (not ,cond) ,body))


(fn module [modname & names]                                  ;; Name of the module and names of files
  (let [npairs {}]                                            ;; Essentially doing a reduce here
    (each [_ name (ipairs names)]
      (if (= :table (type name))                              ;; if the module name is different than the file name
          (let [(mname pname) (unpack name)]
            (tset npairs mname pname))                        ;; set them both
          (tset npairs name name)))                           ;; otherwise set both the same

    `(let [mod# {:__NAME ,modname}]                           ;;this is the table we're going to return
        (each [mname# pname# (pairs ,npairs)]
          (tset mod# mname# (require (.. ... :. pname#))))    ;; I sure hope this works
        mod#)))                                               ;; it worked!!!


{: incf : decf : with : unless : module}