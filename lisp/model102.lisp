;; model101-kamnagi.lisp

(load "load-kamnagi.lisp")

  "loop with tix"
  (defport p41 10)
  (defport p42 0)
  (defport p43 0)
  (defport p44 0)

  (defun c41(tix x y) (values (+ (mod (+ x y) 200) tix)))
  (defun c42(tix x z) (values (mod (+ x z) 3500) ))
  (defun c43(tix x) (values (mod (+ 1 x) 2000)))

  (defcompo m41 #'c41 (p41 p43) (p42))
  (defcompo m42 #'c42 (p42 p44) (p43))
  (defcompo m43 #'c43 (p42) (p44))

  (defparameter mod41 '(m41 m42 m43))

(defvar logs  (nstep-model 5000  '(p41 p42 p43) mod41))
(defvar clogs (replace-cal logs '(2020 1 20 0 0 0) '(0 0 0 1 0 0) ))

(write-logs "m102.csv" '(ts one two three ) clogs)

