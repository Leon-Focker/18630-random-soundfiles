;; * structure

(in-package :ly)

;; ** make a struct...
;;; ... and fill it as a score

(defparameter *struct* (make-struct 'struct))

(add-hits *struct* 0   '(8))
(add-rthm *struct* 0   '(2/9))

(add-hits *struct* 40  '(4))

(add-hits *struct* 60  '(7))

(add-hits *struct* 100 '(8 7))

(add-hits *struct* 110 '(5))

(add-hits *struct* 125 '(5 6))

(add-hits *struct* 135 '(1 6))

(add-rthm *struct* 140 '(6/9 2/9))

(add-hits *struct* 180 '(12))
(add-rthm *struct* 180 '(3/9 4/9))
(add-rthm *struct* 181.5 '(2/9 5/9))

(add-hits *struct* 200 '(32))
(add-rthm *struct* 200 '(2/9))

(add-hits *struct* 230 '(3))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-rthm *Struct* 240 '(1/12 1/6))
(add-hits *struct* 240 '(8))
(add-hits *struct* 244 '(7))
(add-hits *struct* 248 '(5))
(add-hits *struct* 255 '(2))


;; Ende
(add-start-time *struct* 600)

;; EOF structure.lsp
