;; * struct

(in-package :ly)

;; ** struct class

(defclass struct (base-object)
  ;; list of pairs ((index duration))
  ((durations :accessor durations :initarg :durations :initform nil :type list)
   ;; list of pairs ((index start-time))
   (start-times :accessor start-times :initarg :start-times :initform nil
		:type list)
   ;; list of pairs ((index (nr nr ...)))
   (hits :accessor hits :initarg :hits :initform nil :type list)
   ;; list of pairs ((index (nr nr ...)))
   (rthm :accessor rthm :initarg :rthm :initform nil :type list)))

;; *** print-object
(defmethod print-object ((st struct) stream)
  (format stream "~&<Struct:  ~a>"
	  (id st)))

;; *** generate a struct-object
(defun make-struct (id &optional)
  (make-instance 'struct
		 :id id
		 :start-times '((0 0))
		 :hits '((0 (4)))
		 :rthm '((0 (1)))))

;; *** get

(defmethod get-struct-durations ((st struct))
  (loop for i in (durations st) collect (cadr i)))

(defmethod get-struct-start-times ((st struct))
  (loop for i in (start-times st) collect (cadr i)))

(defmethod get-struct-hits ((st struct))
  (loop for i in (hits st) collect (cadr i)))

(defmethod get-struct-rthm ((st struct))
  (loop for i in (rthm st) collect (cadr i)))

;; *** update slots
(defmethod update-durations ((st struct))
  (let ((start-times (mapcar #'(lambda (x) (cadr x)) (start-times st))))
    (setf (durations st)
	  (loop for i from 0 and x in (get-durations start-times)
		collect (list i x)))))

(defmethod update-start-times ((st struct))
  (let ((durations (mapcar #'(lambda (x) (cadr x)) (durations st))))
    (setf (start-times st)
	  (loop for i from 0 and x in (get-start-times durations)
		collect (list i x)))))

(defmethod update-empty ((st struct))
  (loop for (i val) in (start-times st)
	do (unless (assoc i (hits st))
	     (add-hits st val (cadr (assoc (1- i) (hits st)))))
	   (unless (assoc i (rthm st))
	     (add-rthm st val (cadr (assoc (1- i) (rthm st)))))))  

;; *** append-value
(defmethod append-value-aux ((st struct) slot-name value)
  (let* ((last-index (caar (last (slot-value st slot-name))))
	 (new-index (if last-index (1+ last-index) 0)))
    (setf (slot-value st slot-name)
	  (append (slot-value st slot-name)
		  `((,new-index ,value))))))

(defmethod append-duration ((st struct) duration)
  (append-value-aux st 'durations duration)
  (update-start-times st))

(defmethod append-hits ((st struct) hits)
  (append-value-aux st 'hits hits))

(defmethod append-rthm ((st struct) rthm)
  (append-value-aux st 'rthm rthm))

;; *** shift-entries

(defmethod shift-entries ((st struct) slot-name index &optional (shift 1))
  (setf (slot-value st slot-name)
	(loop for (i value) in (slot-value st slot-name)
	      collect (list (if (< i index) i (+ i shift)) value))))

(defmethod shift-hits ((st struct) index &optional (shift 1))
  (shift-entries st 'hits index shift))

(defmethod shift-rthm ((st struct) index &optional (shift 1))
  (shift-entries st 'rthm index shift))

;; *** add-start-time

;;; different than #'append-value-aux, because we want to add the start-time
;;; at the correct position, not necessarily the end of the list
;;; the second return value is the index at which the new start-time was placed
(defmethod add-start-time ((st struct) start-time)
  (let ((final-i 0)
	(flag t))
    (loop for pair in (start-times st)
	  with i = 0
	  with used = 0
	  when (= (cadr pair) start-time)
	    do (warn "start-time ~a not added, already present" start-time)
	       (setf final-i i)
	       (setf flag nil)
	       (incf used)
	  when (and (> (cadr pair) start-time)
		    (= used 0))
	    collect (prog1 (list i start-time)
		      (setf final-i i)
		      (incf i)
		      (incf used))
	      into new-ls
	  collect (prog1 (list i (cadr pair))
		    (incf i))
	    into new-ls
	  finally (setf (start-times st)
			(if (= used 0)
			    (progn
			      (setf final-i i)
			      (append new-ls `((,i ,start-time))))
			    new-ls)))
    ;; when new time is inserted, shift values to match the new indices
    (when flag 
      (shift-hits st final-i)
      (shift-rthm st final-i))
    ;; return values
    (values (update-durations st) final-i)))

;; *** add-entry

;;; similar to add-start-time but you add a start-time and corresponding hits
(defmethod add-entry ((st struct) start-time slot-name value)
  (multiple-value-bind (durations index)
      (add-start-time st start-time)
    (declare (ignore durations))
    ;; collect new list of entries
    (loop for (i val) in (slot-value st slot-name)
	  with used = 0
	  when (= i index)
	    collect (prog1 (list index value)
		      (incf used))
	      into new-ls
	  when (and (> i index)
		    (= used 0))
	    collect (prog1 (list index value)
		      (incf used))
	      into new-ls
	  when (not (= i index))
	    collect (list i val)
	      into new-ls
	  finally (setf (slot-value st slot-name)
			(if (= used 0)
			    (append new-ls `((,index ,value)))
			    new-ls)))))

(defmethod add-hits ((st struct) start-time hits)
  (add-entry st start-time 'hits hits))

(defmethod add-rthm ((st struct) start-time rthm)
  (add-entry st start-time 'rthm rthm))

;; *** get-nth
(defmethod get-nth-aux ((st struct) slot-name n)
  (cadr (assoc n (slot-value st slot-name))))

(defmethod get-nth-duration ((st struct) n)
  (get-nth-aux st 'durations n))

(defmethod get-nth-start-time ((st struct) n)
  (get-nth-aux st 'start-times n))

(defmethod get-nth-hits ((st struct) n)
  (get-nth-aux st 'hits n))

(defmethod get-nth-rthm ((st struct) n)
  (get-nth-aux st 'rthm n))

;; *** struct-section
(defmethod struct-section ((st struct) start-time end-time)
  (let* ((starts '())
	 (durs '())
	 (indices '())
	 (hits '())
	 (rthm '()))
    ;; get all start-times and indices for that section
    (loop for pair in (start-times st)
	  when (<= start-time (cadr pair) end-time)
	    collect (cadr pair) into start-times
	  when (<= start-time (cadr pair) end-time)
	    collect (car pair) into index-ls
	  finally (setf starts start-times
			indices index-ls))
    ;; add start-time of section and first index
    (unless (equal-within-tolerance (first starts) start-time)
      (push start-time starts)
      (push (1- (first indices)) indices))
    ;; set durations
    (setf durs (get-durations starts))
    ;; add last duration
    (unless (equal-within-tolerance (car (last starts)) end-time)
      (setf durs (append durs (list (- end-time (car (last starts)))))))
    ;; collect hits and rthm
    (setf hits (loop for i in (hits st)
		     when (find (car i) indices)
		       collect (cadr i)))
    (setf rthm (loop for i in (rthm st)
		     when (find (car i) indices)
		       collect (cadr i)))
    ;; return
    (values starts durs hits rthm)))
  

;;  ** make a structure:
;; (defparameter *struct*
;;   (make-fractal-structure '(2 3 1)
;; 			  '((1 ((3 3)))
;; 			    (2 ((3 1)))
;; 			    (3 ((2 1 2))))
;; 			  '((1 2)
;; 			    (2 4)
;; 			    (3 3))
;; 			  :duration (* 10 60)
;; 			  :smallest 1))

;; (visualize-structure *struct* (format nil "~a~a" *bleeps-src-dir* "struct.png") 1)

;; EOF struct.lsp
