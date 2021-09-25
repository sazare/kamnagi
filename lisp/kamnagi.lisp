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
(defun collectvalue (plist)
  (loop for p in plist collect
    (eval p)
  )
)

(defmacro defcompo (name compof inputs outputs)
  `(progn 
    (defun ,name ()
      (let ((args (collectvalue ',inputs)))
;        (format t "args=~a~%" args)
        (multiple-value-setq ,outputs (apply ,compof args))
      )
    )
    (pushnew ',name *compolist*)
;; set inputs, outputs, compof in plist
    (setf (get ',name :input) ',inputs)
    (setf (get ',name :output) ',outputs)
    (setf (get ',name :func) ',compof)
  )
)

(defun step-compo (name)
  (apply name ())
)

;;; check graph