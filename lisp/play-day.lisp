(load "day.lisp")

(defparameter maxes '(60 60 24 0 0 0))

(norm-day '(1982 2 25 0 0 2))
(norm-day '(1982 2 25 0 0 62))
(plus-day '(1982 2 25 0 0 62) '(0 0 0 10 2 0))
(plus-day '(1982 2 25 0 0 62) '(0 0 0 24 60 60))

(defparameter sss (create-ts  20 '(1982 2 25 22 20 0) '(0 0 0 0 20 0)))
(defparameter ddd (loop for d in sss collect (format-year d)))


