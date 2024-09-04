;; * helpers

;; ** utilities

;; *** sections
;;; get pairs of times and values, returns a function that receives a time
;;; argument. That function will return the value which time is smaller than
;;; the functions time argument, when there is no later time for which this is
;;; true.
#|
(loop for i from 0 to 10 collect
	  (funcall (sections 0 1 5 ":)" 6.5 7) i))
=> '(1 1 1 1 1 ":)" ":)" 7 7 7 7)
|#
(defun sections (&rest times-and-values)
  (unless (= 0 (mod (length times-and-values) 2))
    (error "uneven number of arguments in #'sections: ~a" times-and-values))
  (lambda (time)
    (loop for x in times-and-values by #'cddr
	  and y in (cdr times-and-values) by #'cddr
	  with result = nil
	  do (if (>= time x) (setf result y) (return result))
	  finally (return result))))

;; *** section-val
#|
(loop for i from 0 to 10 collect
	  (section-val i 0 1 5 ":)" 6.5 7))
=> '(1 1 1 1 1 ":)" ":)" 7 7 7 7)
|#
(defun section-val (time &rest times-and-values)
  (funcall (apply #'sections times-and-values) time))

;; *** special-interleave
;;; (special-interleave '(a b c) '((0 x) (1 y) (2 z)))
;;; => '(a 0 b 1 c 2)
;;; (special-interleave '(a b c) '((0 x) (1 y) (2 z)) 1)
;;; => '(a x b y c z)
(defun special-interleave (normal-list nested-list &optional (n 0))
  (interleave normal-list
	      (mapcar #'(lambda (x) (nth-mod n x)) nested-list)))

;; *** wsound
(defmacro wsound (name &body body)
  (let* ((body-string (write-to-string body))
	 (index1 (search "OUT-CHANNELS" body-string))
	 (index2 (when index1 (search ")" body-string :start2 index1)))
	 (out-channels 2))
    (when (and index1 index2)
      (setf out-channels
	    (parse-integer (subseq body-string (+ index1 13) index2)))
      (format t "~&set number of channels for ~a to ~a" name out-channels))
    `(with-sound (:header-type clm::mus-riff :sampling-rate 48000
		  :output (format nil "~a~a~a" *bleeps-src-dir* ,name ".wav")
		  :channels ,out-channels :play nil :scaled-to 0.98
		  :force-recomputation nil)
       ,@body)))

;; *** unpack
(defmacro unpack_multichan_file (input output channels-from channels-to)
  `(loop for channel from ,channels-from to ,channels-to
	 do (with-sound (:header-type clm::mus-riff :sampling-rate 48000
			 :output (format nil "~a~a-channel_~a~a"
					 *bleeps-src-dir* ,output channel ".wav")
			 :channels 1 :play nil
			 :force-recomputation nil)
	      (samp0 (format nil "~a~a~a" *bleeps-src-dir* ,input ".wav") 0
		     :out-channels 1 :channel channel))))

;; *** mashup
;;; amp-list is bound to input-list (could be made more clear i guess)
(defmacro mashup (start end input-list duration-list order
		  &optional (pan-list '(45)) (amp-list '(1)))
  `(fplay ,start ,end
     (file (nth-mod (nth-mod i ,order) ,input-list))
     (duration (nth-mod i ,duration-list))
     (rhythm duration)
     (start time)
     (amp (nth-mod (nth-mod i ,order) ,amp-list))
     (degree (nth-mod i ,pan-list))))

;; *** generate-section
;;; depth is the n for (nth n (data *struct*))
;;; duration-var is the name for the duration-list to be used in body
;;; start-time-var is the name for rhe start-times-list to be used in body
#+nil(defmacro generate-section (name depth start-time end-time
			    duration-var start-time-var &body body)
  `(wsound ,name
     (let* ((old-durations (nth ,depth (data *struct*)))
	    (old-start-times (get-start-times old-durations))
	    (,duration-var '())
	    (,start-time-var '()))
       ;; collect only relevant start-times and durations
       (loop for x in old-durations and y in old-start-times
	     do (when (<= ,start-time y ,end-time)
		  (push x ,duration-var)
		  (push y ,start-time-var))
	     finally (setf ,duration-var (reverse ,duration-var)
			   ,start-time-var (reverse ,start-time-var)))
       ,@body)))

;; *** name-with-var
(defun name-with-var (name &rest rest)
  (format nil "~a~{_~a~}" name rest))

;; ** envelopes

;; *** env-fun1
;;; breakpoint between 0 and 100
(defun env-fun1 (breakpoint &optional (exponent 0.3))
  (let ((bp (max 0 (min 100 (round breakpoint)))))
    (append
     (if (= bp 0) '(0 1)
	 (loop for i from 0 to bp
	    collect i collect (expt (/ i bp) exponent)))
     (loop for i from (1+ bp) to 100
	collect i collect (expt (/ (- 100 i) (- 100 bp)) exponent)))))

;; EOF helper.lsp
