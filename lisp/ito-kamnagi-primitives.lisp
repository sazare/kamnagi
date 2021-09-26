;; ito for kamnagi-primitives.lisp

(myload "ito.lisp")
(load "kamnagi-primitives.lisp")

;;; property manipulation
(defito ito-putprop()
  (putprop 'n0 :seven 89)
  (intend-equal "collect set" 89 (get 'n0 :seven) )
)
