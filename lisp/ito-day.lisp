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

(defito ito-uruu ()
  "check uruu year"
  (intend-f "normal" (isuruu 3))
  (intend-t "0" (isuruu 0))
  (intend-t "4" (isuruu 4))

  (intend-t "mod400-1" (isuruu 400))
  (intend-t "mod400-2" (isuruu 4000))
  (intend-f "mod400-3" (isuruu 2200))

  (intend-f "mod100-1" (isuruu 100))
  (intend-f "mod100-2" (isuruu 101))
  (intend-t "mod100-3" (isuruu 2220))
  (intend-f "mod100-4" (isuruu 2200))

  (intend-f "mod4-1" (isuruu 2201))
  (intend-f "mod4-2" (isuruu 2202))
  (intend-f "mod4-3" (isuruu 2203))
  (intend-t "mod4-4" (isuruu 2204))
)

(defito ito-monmax ()
  "max of monthmax"
 (intend-equal "jan" 31 (monthmax 1 2021))
 (intend-equal "march" 31 (monthmax 3 2021))
 (intend-equal "april" 30 (monthmax 4 2021))
 (intend-equal "may" 31 (monthmax 5 2021))
 (intend-equal "june" 30 (monthmax 6 2021))
 (intend-equal "july" 31 (monthmax 7 2021))
 (intend-equal "august" 31 (monthmax 8 2021))
 (intend-equal "sept" 30 (monthmax 9 2021))
 (intend-equal "oct" 31 (monthmax 10 2021))
 (intend-equal "nov" 30 (monthmax 11 2021))
 (intend-equal "dec" 31 (monthmax 12 2021))
 (intend-equal "feb n*400" 30 (monthmax 2 2000))
 (intend-equal "feb n*4" 30 (monthmax 2 2004))
 (intend-equal "feb n*100" 29 (monthmax 2 2100))
 (intend-equal "feb other" 29 (monthmax 2 2003))
)

(ito-day)
(ito-parse-day)
(ito-plus-days)
(ito-create-ts)
(ito-year)
(ito-uruu)
(ito-monmax)


