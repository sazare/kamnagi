;; day

(myload "ito.lisp")
(load "day.lisp")

(defito ito-day ()
  "day"
  (setf maxes '(60 60 24 0))
  (intend-equal "no op" '(0 0 0 0) (norm-day '(0 0 0 0)))
  (intend-equal "no co" '(5 6 20 30) (norm-day '(5 6 20 30)))

  (intend-equal "to day" '(1 0 0 0) (norm-day '(0 24 0 0)))
  (intend-equal "to hour" '(0 1 0 0) (norm-day '(0 0 60 0)))
  (intend-equal "to min" '(0 0 1 0) (norm-day '(0 0 0 60)))

  (intend-equal "co up" '(1 0 0 0) (norm-day '(0 23 59 60)))

  (intend-equal "to min" '(24 1 1 1) (norm-day '(23 24 60 61)))
  (intend-equal "to min" '(25 2 2 1) (norm-day '(23 48 120 121)))
)

(defito ito-parse-day ()
  "string to day"
  (setf maxes '(60 60 24 0))
;; true format should be "25 2:3:4"
  (intend-equal "to" '(25 2 3 4) (parse-day "25:2:3:4"))
  (intend-equal "to" '(25 2 2 1) (parse-day "23:48:120:121"))
)

(defito ito-plus-days ()
  "(+ day1 day2) => day"
  (setf maxes '(60 60 24 0))
  (intend-equal "+noc" '(1 1 2 1) (plus-day '(1 1 1 1) '(0 0 1 0)))
  (intend-equal "+co" '(11 0 0 59) (plus-day '(10 23 59 59) '(0 0 1 0)))
  (intend-equal "+co2" '(11 2 0 12) (plus-day '(10 24 119 12) '(0 0 1 0)))
  (intend-equal "+15m1" '(10 2 17 12) (plus-day '(10 2 2 12) '(0 0 15 0)))
  (intend-equal "+15m2" '(10 2 32 12) (plus-day '(10 2 17 12) '(0 0 15 0)))
  (intend-equal "+15m3" '(10 2 47 12) (plus-day '(10 2 32 12) '(0 0 15 0)))
  (intend-equal "+15m3" '(10 3 2 12) (plus-day '(10 2 47 12) '(0 0 15 0)))
)

(defito ito-create-ts ()
  "create-ts make a series from start by delta"
  (setf maxes '(60 60 24 0))
  (intend-equal "zero" '((1 0 0 0)) (create-ts 0 '(1 0 0 0) '(0 0 15 0)))
  (intend-equal "one" '((1 0 0 0)(1 0 15 0)) (create-ts 1 '(1 0 0 0) '(0 0 15 0)))
  (intend-equal "two" '((1 0 0 0)(1 0 15 0)(1 0 30 0)) (create-ts 2 '(1 0 0 0) '(0 0 15 0)))
  (intend-equal "six" '((1 0 0 0)(1 0 31 0)(1 1 2 0)(1 1 33 0)(1 2 4 0)(1 2 35 0)(1 3 6 0)) 
                      (create-ts 6 '(1 0 0 0) '(0 0 31 0)))
)

(defito ito-year ()
  "YMD hms"
  (setf  maxes '(60 60 24 0 0 0))

  (intend-equal "noco" '(1982 2 25 0 0 2) (norm-day '(1982 2 25 0 0 2)))
  (intend-equal "noco" '(1982 2 25 0 1 2) (norm-day '(1982 2 25 0 0 62)))
  (intend-equal "noco" '(1982 2 25 10 3 2) (plus-day '(1982 2 25 0 0 62) '(0 0 0 10 2 0)))
  (intend-equal "noco" '(1982 2 26 1 2 2) (plus-day '(1982 2 25 0 0 62) '(0 0 0 24 60 60)))

  (defparameter sss (create-ts  20 '(1982 2 25 22 20 0) '(0 0 0 0 20 0)))
  (intend-equal "create-20years" '((1982 2 25 22 20 0) (1982 2 25 22 40 0) (1982 2 25 23 0 0) (1982 2 25 23 20 0) (1982 2 25 23 40 0) (1982 2 26 0 0 0) (1982 2 26 0 20 0) (1982 2 26 0 40 0) (1982 2 26 1 0 0) (1982 2 26 1 20 0) (1982 2 26 1 40 0) (1982 2 26 2 0 0) (1982 2 26 2 20 0) (1982 2 26 2 40 0) (1982 2 26 3 0 0) (1982 2 26 3 20 0) (1982 2 26 3 40 0) (1982 2 26 4 0 0) (1982 2 26 4 20 0) (1982 2 26 4 40 0) (1982 2 26 5 0 0)) sss)

  (intend-equal "format year" "1982-02-26 01:00:0" (format-year  '(1982 2 26 1 0 0)))
)

(ito-day)
(ito-parse-day)
(ito-plus-days)
(ito-create-ts)
(ito-year)

