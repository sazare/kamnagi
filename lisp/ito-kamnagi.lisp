;; ito for kamnagi

(myload "ito.lisp")
(load "load-kamnagi.lisp")

;;; sample
(defito ito-usage()
  "simple usage"
  (defport xxx 2)
  (defport yyy 10)
  (defport zzz 0)
  (defport www 0)
  (defun fff (x y) (values (list x y)(list y x)))
  
  (defcompo co1 #'fff (xxx yyy) (zzz www) )

  (step-compo #'co1)  
  
  (intend-equal "1st of computed by fff" '(2 10) zzz)
  (intend-equal "2nd of computed by fff" '(10 2) www)

  (intend-equal "input in compo" '(xxx yyy) (get 'co1 :input))
  (intend-equal "output in compo" '(zzz www) (get 'co1 :output))
  (intend-equal "func in compo" '#'fff  (get 'co1 :func))
)

(defito ito-countup ()
  "count up action"
  (defport a1 0)
  (defport aux 1)

  (defun plus2 (x y) (values (+ x y)))
  
  (defcompo counter #'plus2 (a1 aux) (a1))

  (step-compo #'counter)  
  (intend-equal "1st out" 1 a1)
  (intend-equal "2nd out" 1 aux)

  (step-compo #'counter)  
  (intend-equal "1st out" 2 a1)
  (intend-equal "2nd out" 1 aux)

  (step-compo #'counter)  
  (intend-equal "1st out" 3 a1)
  (intend-equal "2nd out" 1 aux)
)


(ito-usage)
(ito-countup)

