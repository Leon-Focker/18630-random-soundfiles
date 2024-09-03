;; * structure

(in-package :ly)

;; ** make a struct

(defparameter *struct* (make-struct 'struct))

(add-hits *struct* 0    '(4))
(add-hits *struct* 240  '(2))
(add-hits *struct* 120  '(5 3 6))

(add-rthm *struct* 130  '(2/9))
(add-rthm *struct* 120  '(3/9))
(add-rthm *struct* 10  '(4/9))

(add-hits *struct* 130  '(3))

(add-start-time *struct* 10)
(add-start-time *struct* 20)

;; Ende
(add-start-time *struct* 600)

;; EOF structure.lsp
