;; kamnagi generates test data 

;; my variable
(defparameter *portlist*  ())
(defparameter *compolist* ())

;; ports
(defmacro defport (name init)
  `(progn
     (defvar ,name ,init)
     (pushnew ',name *portlist*)
   )
)

;; compos
(defun get-befores (polist)
  (loop for po in polist collect
    (get po :before)
  )
)

(defmacro defcompo (name compof inputs outputs)
  `(progn 
    (defun ,name (ts)
      (let ((args (get-befores ',inputs)))
        (multiple-value-setq ,outputs (apply ,compof (cons ts args)))
      )
    )
    (pushnew ',name *compolist*)
;; set inputs, outputs, compof in plist
    (putprop ',name :input  ',inputs)
    (putprop ',name :output ',outputs)
    (putprop ',name :func   ',compof)
  )
)

(defun step-compo (ts name)
  (apply name (list ts)); how to write compo about value from before
)

(defun set-before-compo (co)
  (loop for v in (get co :input) do
    (putprop v :before (eval v))
  )
)

(defun set-before-model (mo)
  (loop for co in mo do
    (set-before-compo co)
  )
)

;; step-model 
(defun step-model (ts model)
  (progn
    (set-before-model model)
    (loop for compo in model do
      (step-compo ts compo)  
    )
  )
)

;; ntime-model
(defun collect-value (ports)
  (loop for p in ports collect (eval p))
)

(defun nstep-model (maxtime ports model)
  (let ((logs ()))
    (loop for ts from 1 to maxtime do
      (step-model ts model)
      (push (cons ts (collect-value ports))  logs)
    )
    (reverse logs)
  )
)

;; write csv
(defun stringify-alog (log)
  (format nil "~d~{,~d~}" (car log)(cdr log))
)

(defun stringify-logs (logs csvfile)
  (loop for log in logs collect
    (stringify-alog log)
  )
)

(defun write-logs (fname names logs)
  (with-open-file (out fname
      :direction :output
      :if-exists :supersede)
     (format out (stringify-alog names))
     (format out "~%")
 
     (loop for log in logs do 
       (format out (stringify-alog log) )
       (format out "~%")
     )
  )
)


;;; check graph
; all different compos have no same port with others.

