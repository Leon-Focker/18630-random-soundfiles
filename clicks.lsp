;; * clicks

(in-package :ly)

;; ** globals

(defparameter *all-patterns* '())
(defparameter *pattern-map* '(0 0 0 1 0 0 1 1 1 0 0 1 0))
(defparameter *final-rhythms* '())

;; ** rhythm

(push 
 (morph-patterns '((1 1 1) (2)) 10)
 *all-patterns*)

(push
 (interpolate-patterns '((.5) (2.5)) 10)
 *all-patterns*)

(setf *final-rhythms*
      (morph-patterns *all-patterns* 100 nil t nil nil *pattern-map*))

;; ** fplay

;;; using generate-section but for no good reason
#+nil(generate-section "clicks/test_gen_secs_1" 0 10 20 durations times
  (let* ((indisp-amps (apply-indispensability durations (ml .1 500)
					      (rqq-to-indispensability-function
					       '(4 (1 1 2)) t)))
	 (max-amp (loop for i in indisp-amps maximize i)))
    (fplay 0 20
      (sound (first (data (gethash :distorted *soundfiles*))))
      (rhythm .1)
      (duration .02)
      (amp (- max-amp (nth-mod i indisp-amps)))
      (degree 45))))

;; using *final-rhythms* with bass samples
(loop for name in '(short long)
      and key in '(:percussive :distorted)
      and dur-var in '(2 5)
      do
	 (wsound (name-with-var "clicks/test_bass" name)
	   (let* ((sound-list (reverse (data (gethash key *soundfiles*)))))
	     (fplay 0 10
	       (sound (nth-mod 19 sound-list)  
		      (nth-mod 13 sound-list) 
		      (nth-mod 15 sound-list)
		      (nth-mod 12 sound-list) 
		      (nth-mod 17 sound-list)
		      (nth-mod 18 sound-list)
		      (nth-mod 14 sound-list) 
		      (nth-mod 20 sound-list))
	       (rhythm (* (nth-mod i *final-rhythms*) .1))
	       (srt (dry-wet 1 .5 (expt line 2)))
	       (duration (* rhythm (dry-wet dur-var .01 line)))
	       (amp (* (dry-wet .03 .15 (expt line 1.2))))
	       (start "1 then (mirrors (+ start duration) 0 .5)"
		      "2 then (mirrors (+ start duration) 0 .5)"
		      "3 then (mirrors (+ start duration) 0 .5)"
		      "4 then (mirrors (+ start duration) 0 .5)"
		      "1 then (mirrors (+ start duration) 0 .5)"
		      "2 then (mirrors (+ start duration) 0 .5)"
		      "3 then (mirrors (+ start duration) 0 .5)"
		      "4 then (mirrors (+ start duration) 0 .5)")
	       (amp-env (env-fun1 10 2))
	       (degree 0 10 30 40 50 60 80 90)))))

;; ** using indispensability:

;; make a structure:
;; (defparameter *indisp*
;;   (data (make-fractal-structure '(2 3 2)
;; 				'((1 ((3 3)))
;; 				  (2 ((3 1)))
;; 				  (3 ((2 1 2))))
;; 				'((2 2)
;; 				  (3 3)
;; 				  (1 2))
;; 				:duration 20
;; 				:type 'compartmentalise
;; 				:smallest .1)))

;; (defparameter *indisp-amp*
;;   (loop for i from 0 to 2 collect
;;        (apply-indispensability (nth 3 *indisp*) (nth i *indisp*)
;; 			       (rqq-to-indispensability-function
;; 				'(1 ((2 (1 1)) (3 (1 1 1)) (2 (1 1))))))))

;; (defparameter *indisp-amp*
;;   (loop for i from 0 to 2 collect
;;        (apply-indispensability (nth 3 *indisp*) (nth i *indisp*)
;; 			       (rqq-to-indispensability-function
;; 				'(3 ((1 (1 1 1)) (1 (1 1 1)) (1 (1 1 1))))))))

;; ;; without indisp amps:
;; (wsound "clicks/indisp_test"
;;   (let* ((sound-list (reverse (data (gethash :percussive *soundfiles*)))))
;;     (fplay 0 20
;; 	   (sound (nth 6 sound-list))
;; 	   (rhythm (nth-mod i (nth 3 *indisp*))
;; 		   (nth-mod i (nth 2 *indisp*))
;; 		   (nth-mod i (nth 1 *indisp*)))
;; 	   (srt .5 1 2)
;; 	   (duration .005 .01 .005)
;; 	   (amp .8 .3 .2)
;; 	   (degree 45 0 90))))

;; ;; with indisp-amps:
;; (wsound "clicks/indisp_test!2"
;;   (let* ((sound-list (reverse (data (gethash :percussive *soundfiles*)))))
;;     (fplay 0 20
;; 	   (sound (nth 6 sound-list))
;; 	   (rhythm (nth-mod i (nth 3 *indisp*))
;; 		   (nth-mod i (nth 2 *indisp*))
;; 		   (nth-mod i (nth 1 *indisp*))
;; 		   (nth-mod i (nth 0 *indisp*)))
;; 	   (srt .5 1 2 4)
;; 	   (duration .01 .02 .01 .0025)
;; 	   (amp 1
;; 		(/ 1 (1+ (nth-mod i (nth 2 *indisp-amp*))))
;; 		(/ 1 (1+ (nth-mod i (nth 1 *indisp-amp*))))
;; 		(/ 1 (1+ (nth-mod i (nth 0 *indisp-amp*)))))
;; 	   (degree 45 0 90 45))))

(wsound "clicks/pulse_train_mono2"
  (fplay 0 20
    (file '"/E/Keks_Feedback/samples/noise/noise_07.wav")
    (rthm .1)
    (rhythm rthm
	    (/ rthm 2))
    (indisp-fun (rqq-to-indispensability-function
		 '(1 ((2 (1 1)) (3 (1 2)) (2 (1 1 1 1))))))
    (srt .5 .5)
    (duration .01 .01)
    (tim-mult (+ 1 (* line 5))
	      (+ 1 (* line2 4)))
    (amp (funcall indisp-fun (mod (* time tim-mult) 1))
	 (funcall indisp-fun (mod (* time2 tim-mult2) 1)))
    (degree 45)))

;; EOF clicks.lsp

