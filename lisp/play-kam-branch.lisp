;; play for kamnagi branch model

(load "load-kamnagi.lisp")

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



