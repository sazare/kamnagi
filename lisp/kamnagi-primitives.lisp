;; kamnagi-primitives.lisp

;; refer by (get n p)
;; set as
(defun putprop (n p v)
 (setf (get n p) v)
)

