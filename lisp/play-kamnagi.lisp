(load "load-kamnagi.lisp")

  "loop with ts"
  (defport ts  1)
  (defport p31 10)
  (defport p32 0)
  (defport p33 0)
  (defport p34 0)
  (defport p35 0)

  (defun c30(x) (values (+ x 1)))
  (defun c31(ts x) (values (* ts x 2)))
  (defun c32(ts x) (values (* ts x 3)))
  (defun c33(ts x y) (values (* ts y) (* ts y x 5)))

;; p32 and p33's refered previous value
  (defcompo m30 #'c30(ts) (ts))
  (defcompo m31 #'c31(ts p31) (p32))
  (defcompo m32 #'c32(ts p32) (p33))
  (defcompo m33 #'c33(ts p33 p32) (p35 p34))

;; can define same function different compo?
  (defparameter mod31 '(m30 m31 m32 m33))

(defvar logs  (nstep-model 10  '(ts P31 P32 P33 P34 P35) mod31))

