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

(add-rthm *struct* 240 '(1/12 1/6 2/9))
(add-hits *struct* 240 '(3))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-rthm *struct* 272 '(2/9 2/9 1/9))
(add-hits *struct* 272 '(3))

(add-hits *struct* 290 '(6 6 6 7))

(add-rthm *struct* 295 '(2/9 198/900 1/9))

(add-rthm *struct* 305 '(2/9 198/900 11/90))
(add-hits *struct* 305 '(6 6 6 11))

(add-hits *struct* 310 '(5))

(add-hits *struct* 310 '(4 4 4 11))

(add-rthm *struct* 320 '(2/90))
(add-hits *struct* 320 '(3 3 3 3))

;(add-hits *struct* 244 '(7))
;(add-hits *struct* 248 '(5))
;(add-hits *struct* 255 '(2))

;; Ende
(add-start-time *struct* 600)

;; ** a struct for drums

(defparameter *drums-struct* (make-struct 'drums))

(add-hits *drums-struct* 0   '(8))
(add-rthm *drums-struct* 0   '(0.05))

(add-rthm *drums-struct* 10  '(0.025))

(add-rthm *drums-struct* 25  '(0.01))

(add-hits *drums-struct* 40  '(11))
(add-rthm *drums-struct* 40  '(0.025))

(add-hits *drums-struct* 50  '(7))
(add-hits *drums-struct* 52  '(6))
(add-hits *drums-struct* 55  '(5))
(add-hits *drums-struct* 57  '(4))


;; EOF structure.lsp
