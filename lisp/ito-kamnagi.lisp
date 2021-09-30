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
  (defun fff (ts x y) (values (list x y)(list y x)))
  
  (defcompo co1 #'fff (xxx yyy) (zzz www) )

  (step-model 1 '(co1))
  
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

  (defun plus2 (ts x y) (values (+ x y)))
  
  (defcompo counter #'plus2 (a1 aux) (a1))

  (step-model 1 '(counter))
  (intend-equal "1st step a1" 1 a1)
  (intend-equal "1st step aux" 1 aux)

  (step-model 2 '(counter))
  (intend-equal "2nd step a1" 2 a1)
  (intend-equal "2nd step aux" 1 aux)

  (step-model 3 '(counter))
  (intend-equal "3rd step a1" 3 a1)
  (intend-equal "3rd step aux" 1 aux)

)

(defito ito-nsteps ()
  "n steps model"
  (defport p1 1)
  (defport p2 0)
  (defport p3 0)
  (defport p4 0)

  (defun c1(ts x) (values (* x 2)))
  (defun c2(ts x) (values (* x 3)))
  (defun c3(ts x) (values (* x 5)))
  
  (defcompo m1 #'c1(p1) (p2))
  (defcompo m2 #'c2(p2) (p3))
  (defcompo m3 #'c3(p3) (p4))

;; can define same function different compo?
  (defparameter mod1 '(m1 m2 m3))

  (step-model 1 mod1)
  (intend-equal "1st step p1" 1 p1)
  (intend-equal "1st step p2" 2 p2)
  (intend-equal "1st step p3" 0 p3)
  (intend-equal "1st step p4" 0 p4)

  (step-model 2 mod1)
  (intend-equal "2nd step p1" 1 p1)
  (intend-equal "2nd step p2" 2 p2)
  (intend-equal "2nd step p3" 6 p3)
  (intend-equal "2nd step p4" 0 p4)

  (step-model 3 mod1)
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

  (defun c1r(ts x) (values (* x 2)))
  (defun c2r(ts x) (values (* x 3)))
  (defun c3r(ts x) (values (* x 5)))
  
  (defcompo m1r #'c1r(p1r) (p2r))
  (defcompo m2r #'c2r(p2r) (p3r))
  (defcompo m3r #'c3r(p3r) (p4r))

;; can define same function different compo?
  (defparameter mod1r '(m3r m2r m1r))

  (step-model 1 mod1r)
  (intend-equal "1st step p1r" 1 p1r)
  (intend-equal "1st step p2r" 2 p2r)
  (intend-equal "1st step p3r" 0 p3r)
  (intend-equal "1st step p4r" 0 p4r)

  (step-model 2 mod1r)
  (intend-equal "2nd step p1r" 1 p1r)
  (intend-equal "2nd step p2r" 2 p2r)
  (intend-equal "2nd step p3r" 6 p3r)
  (intend-equal "2nd step p4r" 0 p4r)

  (step-model 3 mod1r)
  (intend-equal "3rd step p1r" 1 p1r)
  (intend-equal "3rd step p2r" 2 p2r)
  (intend-equal "3rd step p3r" 6 p3r)
  (intend-equal "3rd step p4r" 30 p4r)

)

(defito ito-branch ()
  "branch structure"
  (defport p21 10)
  (defport p22 0)
  (defport p23 0)
  (defport p24 0)

  (defun c21(ts x) (values (* x 2)))
  (defun c22(ts x) (values (* x 3)))
  (defun c23(ts x y) (values (* y x 5)))
  
  (defcompo m21 #'c21(p21) (p22))
  (defcompo m22 #'c22(p22) (p23))
  (defcompo m23 #'c23(p23 p22) (p24))

;; can define same function different compo?
  (defparameter mod21 '(m21 m22 m23))

  (step-model 1 mod21)
  (intend-equal "1st step p21" 10 p21)
  (intend-equal "1st step p22" 20 p22)
  (intend-equal "1st step p23" 0 p23)
  (intend-equal "1st step p24" 0 p24)

  (step-model 2 mod21)
  (intend-equal "2nd step p21" 10 p21)
  (intend-equal "2nd step p22" 20 p22)
  (intend-equal "2nd step p23" 60 p23)
  (intend-equal "2nd step p24" 0 p24)

  (step-model 3 mod21)
  (intend-equal "3rd step p21" 10 p21)
  (intend-equal "3rd step p22" 20 p22)
  (intend-equal "3rd step p23" 60 p23)
  (intend-equal "3rd step p24" 6000 p24)
)

(defito ito-loop1()
  "loop with ts"
  (defport ts  1)
  (defport p31 10)
  (defport p32 0)
  (defport p33 0)
  (defport p34 0)
  (defport p35 0)

  (defun c31(ts x) (values (* ts x 2)))
  (defun c32(ts x) (values (* ts x 3)))
  (defun c33(ts x y) (values (* ts y) (* ts y x 5)))

;; p32 and p33's refered previous value
  (defcompo m31 #'c31(p31) (p32))
  (defcompo m32 #'c32(p32) (p33))
  (defcompo m33 #'c33(p33 p32) (p35 p34))

;; can define same function different compo?
  (defparameter mod31 '(m31 m32 m33))

  (intend-equal "0th step p31" 10 p31)
  (intend-equal "0th step p32" 0 p32)
  (intend-equal "0th step p33" 0 p33)
  (intend-equal "0th step p34" 0 p34)
  (intend-equal "0th step p35" 0 p35)
;
  (step-model 1 mod31)
  (intend-equal "1st step p31" 10 p31)
  (intend-equal "1st step p32" 20 p32)
  (intend-equal "1st step p33" 0 p33)
  (intend-equal "1st step p34" 0 p34)
  (intend-equal "1st step p35" 0 p35)
;
  (step-model 2 mod31)
  (intend-equal "2nd step p31" 10 p31)
  (intend-equal "2nd step p32" 40 p32)
  (intend-equal "2nd step p33" 120 p33)
  (intend-equal "2nd step p34" 0  p34)
  (intend-equal "2nd step p35" 40 p35)
;
  (step-model 3 mod31)
  (intend-equal "3rd step p31" 10 p31)
  (intend-equal "3rd step p32" 60 p32)
  (intend-equal "3rd step p33" 360 p33)
  (intend-equal "3rd step p34" 72000 p34)
  (intend-equal "3rd step p35" 120 p35)
;
;  (intend-equal "4th step p30" 4 ts)
  (step-model 4 mod31)
  (intend-equal "4th step p31" 10 p31)
  (intend-equal "4th step p32" 80 p32)
  (intend-equal "4th step p33" 720 p33)
  (intend-equal "4th step p34" 432000 p34)
  (intend-equal "4th step p35" 240 p35)
)

(ito-usage)
(ito-countup)
(ito-nsteps)
(ito-nsteps-rev)
(ito-branch)
(ito-loop1)

