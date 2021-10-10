;;;; day manipulation
;; sazare 20211005

(defun norm-day0 (da maxes)
  (loop for c in da
    with v = 0 and o = 0
      as m in maxes
      collect
      (progn 
        (if (= m 0) 
          (multiple-value-setq (o v) (values 0 (+ c o)))
          (multiple-value-setq (o v) (floor (+ c o) m))
        )
      v
      )
  )
)

(defun norm-day (da maxes) (reverse (norm-day0 (reverse da)(reverse  maxes))))

;;; (f day1 day2) map f on (d1 d2) in (day1 day2)
(defun plus-day (day1 day2 maxes)
  (norm-day 
    (loop for d1 in day1 as d2 in day2 collect
      (+ d1 d2)
    )
    maxes
  )
)

;; create n timestamp from startday countup delta day
;;

(defun create-ts (n start delta) 
  (loop 
    with sday = start and tslist = (list start)
    for i from 1 to n do
      (setf sday (plus-day sday delta (month-maxtable sday)))
      (push sday tslist)
    finally 
      (return (reverse tslist))
  )
)

;;; string to day
;;; "3 12:22:33" => (3 12 12 33)

;(defun split-day (x str)
;  (let ((pos (search x str))
;        (size (length x)))
;    (if pos
;      (cons (read-from-string (subseq str 0 pos))
;            (split-day x (subseq str (+ pos size))))
;      (list (read-from-string str))))
;)
;
;(defun parse-day (str)
;  (norm-day (split-day ":" str))
;)
;

;;; day -> string
(defun format-day (day)
  (format nil "~d ~2,'0d:~2,'0d:~2,'0d" (nth 0 day)(nth 1 day)(nth 2 day)(nth 3 day))
)

(defun format-year (year)
  (format nil "~4,'0d-~2,'0d-~2,'0d ~2,'0d:~2,'0d:~0,'0d" 
    (nth 0 year)(+ (nth 1 year) 1)(+ (nth 2 year) 1) (nth 3 year)(nth 4 year)(nth 5 year))
)

;;; replace-cal

(defun replace-cal (log start delta )
  (let (n cal clog )
    (setf n (length log))
    (setf cal (create-ts n start delta)) 
    (setf clog (loop for l in log as d in cal collect (cons (format-year d) (cdr l))))
    clog)
)

;;; uruu year(leap year)
;; (isuruu year) then maxes.month[2] == 30 
;; (not (isuruu year)) then maxes.month[2] == 29

(defun isuruu (year)
  (cond 
    ((eq 0 (mod year 400)) T)
    ((eq 0 (mod year 100)) NIL)
    ((eq 0 (mod year 4)) T)
    (T NIL)
  ) 
)


;;; month maxes
(defun monthmax (month year)
  (cond
    ((member month '(0 2 4 6 7 9 11)) 31)
    ((member month '(3 5 8 10)) 30)
    (t 
     (if (isuruu year) 29 28)
    )
  )
)


;;; normalize datetime with uruu

(defun month-maxtable (dt)
  (list 0 12 (monthmax (cadr dt) (car dt)) 24 60 60)
)

(defun norm-dt (dt mtable)
  (norm-day dt mtable)
)

(defun normalize-dt (dt)
  (norm-dt dt (month-maxtable dt))
)

