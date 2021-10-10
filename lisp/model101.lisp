;; model101-kamnagi.lisp

(load "load-kamnagi.lisp")

  "loop with tix"
  (defport tix  1)
  (defport p31 10)
  (defport p32 0)
  (defport p33 0)
  (defport p34 0)
  (defport p35 0)

  (defun c31(tix x) (values (* tix x 2)))
  (defun c32(tix x) (values (* tix x 3)))
  (defun c33(tix x y) (values (* tix y) (* tix y x 5)))

  (defcompo m31 #'c31 (p31) (p32))
  (defcompo m32 #'c32 (p32) (p33))
  (defcompo m33 #'c33 (p33 p32) (p35 p34))

  (defparameter mod31 '(m31 m32 m33))

(defvar logs  (nstep-model 3000  '(P31 P32 P33 P34 P35) mod31))
(defvar clogs (replace-cal logs '(2020 1 20 0 0 0) '(0 0 0 0 30 0) ))

(write-logs "aaa.csv" '(tix one two three four five) logs)
(write-logs "bbb.csv" '(ts one two three four five) clogs)

