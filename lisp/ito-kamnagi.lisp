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
  (intend-equal "1st step a1" 1 a1)
  (intend-equal "1st step aux" 1 aux)

  (step-compo #'counter)  
  (intend-equal "2nd step a1" 2 a1)
  (intend-equal "2nd step aux" 1 aux)

  (step-compo #'counter)  
  (intend-equal "3rd step a1" 3 a1)
  (intend-equal "3rd step aux" 1 aux)

)

(defito ito-nsteps ()
  "n steps model"
  (defport p1 1)
  (defport p2 0)
  (defport p3 0)
  (defport p4 0)

  (defun c1(x) (values (* x 2)))
  (defun c2(x) (values (* x 3)))
  (defun c3(x) (values (* x 5)))
  
  (defcompo m1 #'c1(p1) (p2))
  (defcompo m2 #'c2(p2) (p3))
  (defcompo m3 #'c3(p3) (p4))

;; can define same function different compo?
  (defparameter mod1 '(m1 m2 m3))

  (step-model mod1)
  (intend-equal "1st step p1" 1 p1)
  (intend-equal "1st step p2" 2 p2)
  (intend-equal "1st step p3" 0 p3)
  (intend-equal "1st step p4" 0 p4)

  (step-model mod1)
  (intend-equal "2nd step p1" 1 p1)
  (intend-equal "2nd step p2" 2 p2)
  (intend-equal "2nd step p3" 6 p3)
  (intend-equal "2nd step p4" 0 p4)

  (step-model mod1)
  (intend-equal "3rd step p1" 1 p1)
  (intend-equal "3rd step p2" 2 p2)
  (intend-equal "3rd step p3" 6 p3)
  (intend-equal "3rd step p4" 30 p4)

)

(defito ito-nsteps-rev ()
  "n steps model reverse"
  (defport p1r 1)
  (defport p2r 0)
  (defport p3r 0)
  (defport p4r 0)

  (defun c1r(x) (values (* x 2)))
  (defun c2r(x) (values (* x 3)))
  (defun c3r(x) (values (* x 5)))
  
  (defcompo m1r #'c1r(p1r) (p2r))
  (defcompo m2r #'c2r(p2r) (p3r))
  (defcompo m3r #'c3r(p3r) (p4r))

;; can define same function different compo?
  (defparameter mod1r '(m3r m2r m1r))

  (step-model mod1r)
  (intend-equal "1st step p1r" 1 p1r)
  (intend-equal "1st step p2r" 2 p2r)
  (intend-equal "1st step p3r" 0 p3r)
  (intend-equal "1st step p4r" 0 p4r)

  (step-model mod1r)
  (intend-equal "2nd step p1r" 1 p1r)
  (intend-equal "2nd step p2r" 2 p2r)
  (intend-equal "2nd step p3r" 6 p3r)
  (intend-equal "2nd step p4r" 0 p4r)

  (step-model mod1r)
  (intend-equal "3rd step p1r" 1 p1r)
  (intend-equal "3rd step p2r" 2 p2r)
  (intend-equal "3rd step p3r" 6 p3r)
  (intend-equal "3rd step p4r" 30 p4r)

)


(ito-usage)
(ito-countup)
(ito-nsteps)
(ito-nsteps-rev)

