;; * pads

(in-package :ly)

;; ** fplay

;;; a simple groove with bass samples
(wsound "pads/groove"
  (let* ((start-time 0) ; (first (nth 4 (data *struct*)))
	 (end-time (+ start-time 10)) ; (second (nth 4 (data *struct*)))
	 (sounds (data (gethash :percussive *soundfiles*))))
    (fplay start-time end-time
;;;;  rhythm 
      (duration .5)
      (rhythm 1/12 1/6)
      (hits (section-val (- time start-time) 0 8 4 7 8 5)
	    (section-val (- time2 start-time) 0 8 3 7 8 5))
;;;;  blackbox
      (accent (/ (get-beat-prox (/ (- time start-time) hits rhythm) 4) 4)
	      (/ (get-beat-prox (/ (- time2 start-time) hits2 rhythm2) 4) 4))
      (sound (cond ((> accent .7) (nth-mod 19 sounds))
		   ((> accent2 .5) (nth-mod 17 sounds))
		   (t (nth-mod 15 sounds)))
	     (cond ((> accent2 .7) (nth-mod 18 sounds))
		   ((> accent2 .5) (nth-mod 16 sounds))
		   (t (nth-mod 15 sounds))))
      (amp (- 1 accent) (- 1 accent2))
      (degree 0 90))))

;; ** exploring other samples:

(loop for k from 0 to 50 by 10 do
  (wsound (name-with-var "pads/groove_recov" k)
    (let* ((start-time 0)
	   (end-time 20)
	   (sounds (data (gethash :recov *soundfiles*))))
      (fplay start-time end-time
;;;;  rhythm 
	(duration .5)
	(rhythm 1/12 1/6)
	(hits (section-val (- time start-time) 0 8 4 7 8 5 15 2)
	      (section-val (- time2 start-time) 0 8 3 7 8 5 15 2))
;;;;  blackbox
	(accent (/ (get-beat-prox (/ (- time start-time) hits rhythm) 4) 4)
		(/ (get-beat-prox (/ (- time2 start-time) hits2 rhythm2) 4) 4))
	(sound (cond ((> accent .7) (nth-mod (+ k 19) sounds))
		     ((> accent2 .5) (nth-mod (+ k 17) sounds))
		     (t (nth-mod (+ k 15) sounds)))
	       (cond ((> accent2 .7) (nth-mod (+ k 18) sounds))
		     ((> accent2 .5) (nth-mod (+ k 16) sounds))
		     (t (nth-mod (+ k 15) sounds))))
	(amp (- 1 accent) (- 1 accent2))
	(amp-env '(0 0  1 1  99 1  100 0))
	(degree 0 90)))))

;;; using recov2...10
(loop for lib in '(:recov2 :recov3 :recov4 :recov5 :recov6 :recov7 :recov8
		   :recov9 :recov10)
      do 
	 (loop for k from 0 to 50 by 10 do
	   (wsound (name-with-var "pads/groove_" lib k)
	     (let* ((start-time 0)
		    (end-time 20)
		    (sounds (data (gethash lib *soundfiles*))))
	       (fplay start-time end-time
;;;;  rhythm 
		 (duration .5)
		 (rhythm 1/12 1/6)
		 (hits (section-val (- time start-time) 0 8 4 7 8 5 15 2)
		       (section-val (- time2 start-time) 0 8 3 7 8 5 15 2))
;;;;  blackbox
		 (accent (/ (get-beat-prox (/ (- time start-time) hits rhythm) 4) 4)
			 (/ (get-beat-prox (/ (- time2 start-time) hits2 rhythm2) 4) 4))
		 (sound (cond ((> accent .7) (nth-mod (+ k 19) sounds))
			      ((> accent2 .5) (nth-mod (+ k 17) sounds))
			      (t (nth-mod (+ k 15) sounds)))
			(cond ((> accent2 .7) (nth-mod (+ k 18) sounds))
			      ((> accent2 .5) (nth-mod (+ k 16) sounds))
			      (t (nth-mod (+ k 15) sounds))))
		 (amp (- 1 accent) (- 1 accent2))
		 (amp-env '(0 0  1 1  99 1  100 0))
		 (degree 0 90))))))

;;; isolating sounds
;;; exploring other samples:
(loop for k from 20 to 20 do
  (loop for snd from 1 to 6 do
    (wsound (name-with-var "pads/stems/groove_recov" k snd)
      (let* ((start-time 0)
	     (end-time 20)
	     (sounds (data (gethash :recov *soundfiles*))))
	(fplay start-time end-time
;;;;  rhythm 
	  (duration .5)
	  (rhythm 1/12 1/6)
	  (hits (section-val (- time start-time) 0 8 4 7 8 5 15 2)
		(section-val (- time2 start-time) 0 8 3 7 8 5 15 2))
;;;;  blackbox
	  (on 0 0)
	  (accent (/ (get-beat-prox (/ (- time start-time) hits rhythm) 4) 4)
		  (/ (get-beat-prox (/ (- time2 start-time) hits2 rhythm2) 4) 4))
	  (sound (cond ((> accent .7) (setf on (if (= snd 1) 1 nil)) (nth-mod (+ k 19) sounds))
		       ((> accent2 .5) (setf on (if (= snd 2) 1 nil)) (nth-mod (+ k 17) sounds))
		       (t (setf on (if (= snd 3) 1 nil)) (nth-mod (+ k 15) sounds)))
		 (cond ((> accent2 .7) (setf on2 (if (= snd 4) 1 nil)) (nth-mod (+ k 18) sounds))
		       ((> accent2 .5) (setf on2 (if (= snd 5) 1 nil)) (nth-mod (+ k 16) sounds))
		       (t (setf on2 (if (= snd 6) 1 nil)) (nth-mod (+ k 15) sounds))))
	  (amp (if on (- 1 accent) 0) (if on2 (- 1 accent2) 0))
	  (amp-env '(0 0  1 1  99 1  100 0))
	  (degree 0 90))))))


;; ** automation

;; *** dreamy 1

(let* ((start-time 240)
       (end-time 272)		    
       (sounds (data (gethash :recov *soundfiles*))))
  (multiple-value-bind (starts durs hit-list rthm-list)
      (struct-section *struct* start-time end-time)
    (declare (ignore durs))
    
    (wsound (name-with-var "pads/dreamy_1" 20)
      (fplay start-time end-time
;;;;  rhythm 
	(duration .5)
	(rhythm (apply #'section-val time
		       (special-interleave starts rthm-list))
		(apply #'section-val time2
		       (special-interleave starts rthm-list 1)))
	(hits (apply #'section-val time
		     (special-interleave starts hit-list))
	      (apply #'section-val time2
		     (special-interleave starts hit-list 1)))
;;;;  blackbox
	(accent (/ (get-beat-prox (/ (- time start-time) hits rhythm) 4) 4)
		(/ (get-beat-prox (/ (- time2 start-time) hits2 rhythm2) 4) 4))
	(degree 0 0)
	(out-channels 6)
	(sound nil nil)
	(stub (cond ((> accent .7) (setf degree (* 0 60)
					 sound (nth-mod 39 sounds)))
		    ((> accent2 .5) (setf degree (* 2 60)
					  sound (nth-mod 37 sounds)))
		    (t (setf degree (* 4 60) sound (nth-mod 35 sounds))))
	      (cond ((> accent2 .7) (setf degree2 (* 1 60)
					  sound2 (nth-mod 38 sounds)))
		    ((> accent2 .2) (setf degree2 (* 3 60)
					  sound2 (nth-mod 36 sounds)))
		    (t (setf degree2 (* 5 60) sound2 (nth-mod 35 sounds)))))
	(amp (- 1 accent) (- 1 accent2))
	(amp-env '(0 0  1 1  99 1  100 0))))))

;;; unpack 6chan file into 6 mono files:
(unpack_multichan_file (name-with-var "pads/dreamy_1" 20)
		       (name-with-var "pads/stems/dreamy_1" 20)
		       0 5)

;; ** games

;; *** game_1
(let ((k 0))
  (wsound (name-with-var "pads/game_1" k)
    (let* ((start-time 0)
	   (end-time 25)
	   (sounds (append (data (gethash :recov5 *soundfiles*))
			   (list (gethash :stille *soundfiles*)))))
      (fplay start-time end-time
;;;;  rhythm 
	(duration .5)
	(rhythm (section-val time
			     0 1/12
			     14 3/12
			     18.5 4/9)
		(section-val time2
			     0 1/6
			     14 3/12
			     18.5 4/9))
        (hits (section-val time
			   0 8
			   7 11
			   13.5 5
			   18.5 11)
	      (section-val time2
			   0 11
			   8 7
			   13.5 13
			   18.5 11))
;;;;  blackbox
	(accent (/ (get-beat-prox (/ (- time start-time) hits rhythm) 4) 4)
		(/ (get-beat-prox (/ (- time2 start-time) hits2 rhythm2) 4) 4))
	(sound-n (section-val time
			      0    (if (< accent .7) 15 19)
			      1.7  (cond ((< accent .7) 17) ((< accent .9) 15) (t 19))
			      4    (cond ((< accent .7) 19) ((< accent .9) 18) (t 15))
			      5    (if (< accent .5) 21 18)
			      9    (if (< accent .7) 24 25)
			      12   (if (< accent .5) 26 25)
			      14   (if (< accent .3) 26 27)
			      22.5 (if (< accent .3) 34 26))
		 (section-val time2
			      0    (if (< accent2 .7) 15 19)
			      1.7  (cond ((< accent2 .7) 18) ((< accent2 .9) 19) (t 18))
			      3    (cond ((< accent2 .7) 17) ((< accent2 .9) 15) (t 19))
			      4.5  (if (< accent2 .7) 33 19)
			      7    23
			      9    (if (< accent2 .7) 26 24)
			      14   (if (< accent2 .3) (1- (length sounds)) 26)
			      22   (if (< accent2 .3) 26 18)))
	(sound (nth-mod sound-n sounds)
	       (nth-mod sound-n2 sounds))
	(amp (- 1 accent) (- 1 accent2))
	(amp-env '(0 0  1 1  99 1  100 0))
	(degree 0 90)))))


;; *** game_2
(let ((k 0))
  (wsound (name-with-var "pads/game_2" k)
    (let* ((start-time 0)
	   (end-time 40)
	   (sounds (append (data (gethash :recov5 *soundfiles*))
			   (list (gethash :stille *soundfiles*)))))
      (fplay start-time end-time
;;;;  rhythm 
	(duration .5)
	(rhythm (section-val time
			     0 1/12
			     21 2/12
			     31 4/9)
		(section-val time2
			     0 1/6
			     29 3/12
			     31 4/9))
        (hits (section-val time
			   0 8
			   8 11
			   19 5
			   31 11)
	      (section-val time2
			   0 11
			   13 7
			   22.5 13
			   31 11))
;;;;  blackbox
	(accent (/ (get-beat-prox (/ (- time start-time) hits rhythm) 4) 4)
		(/ (get-beat-prox (/ (- time2 start-time) hits2 rhythm2) 4) 4))
	(sound-n (section-val time
			      0    (if (< accent .7) 15 19)
			      2.7  (cond ((< accent .7) 17) ((< accent .9) 15) (t 19))
			      5    (cond ((< accent .7) 19) ((< accent .9) 18) (t 15))
			      6    (if (< accent .5) 12 18)			      
			      14   (if (< accent .7) 24 25)
			      18   (if (< accent .5) 26 25)
			      25   (if (< accent .3) 26 27)
			      36   (if (< accent .3) 13 26))
		 (section-val time2
			      0    (if (< accent2 .7) 15 19)
			      2.7  (cond ((< accent2 .7) 18) ((< accent2 .9) 19) (t 18))
			      4    (cond ((< accent2 .7) 17) ((< accent2 .9) 15) (t 19))
			      5.5  (if (< accent2 .7) 33 19)
			      6    23
			      14   (if (< accent2 .7) 26 24)
			      29   (if (< accent2 .3) (1- (length sounds)) 26)
			      34   (if (< accent2 .3) 26 18)))
	(sound (nth-mod sound-n sounds)
	       (nth-mod sound-n2 sounds))
	(amp (- 1 accent) (- 1 accent2))
	(amp-env '(0 0  1 1  99 1  100 0))
	(degree 0 90)))))

;; *** thicken game 2

(let ((k 0))
  (wsound (name-with-var "pads/game_2.5" k)
    (let* ((start-time 0)
	   (end-time 40)
	   (sounds (append (data (gethash :recov5 *soundfiles*))
			   (list (gethash :stille *soundfiles*)))))
      (fplay start-time end-time
;;;;  rhythm 
	(duration .5)
	(rhythm (section-val time
			     0 1/9
			     21 2/12
			     31 4/9)
		(section-val time2
			     0 1/6
			     29 3/12
			     31 4/9))
        (hits (section-val time
			   0 7;8
			   8 10;11
			   19 4;5
			   31 10) ;11
	      (section-val time2
			   0 12;11
			   13 6;7
			   22.5 12;13
			   31 12)) ;11
;;;;  blackbox
	(accent (/ (get-beat-prox (/ (- time start-time) hits rhythm) 4) 4)
		(/ (get-beat-prox (/ (- time2 start-time) hits2 rhythm2) 4) 4))
	(sound-n (section-val time
			      0    (if (< accent .7) 15 19)
			      2.7  (cond ((< accent .7) 17) ((< accent .9) 15) (t 19))
			      5    (cond ((< accent .7) 19) ((< accent .9) 18) (t 15))
			      6    (if (< accent .5) 12 18)			      
			      14   (if (< accent .7) 24 25)
			      18   (if (< accent .5) 26 25)
			      25   (if (< accent .3) 26 27)
			      36   (if (< accent .3) 13 26))
		 (section-val time2
			      0    (if (< accent2 .7) 15 19)
			      2.7  (cond ((< accent2 .7) 18) ((< accent2 .9) 19) (t 18))
			      4    (cond ((< accent2 .7) 17) ((< accent2 .9) 15) (t 19))
			      5.5  (if (< accent2 .7) 33 19)
			      6    23
			      14   (if (< accent2 .7) 26 24)
			      29   (if (< accent2 .3) (1- (length sounds)) 26)
			      34   (if (< accent2 .3) 26 18)))
	(sound (nth-mod sound-n sounds)
	       (nth-mod sound-n2 sounds))
	(amp (- 1 accent) (- 1 accent2))
	(amp-env '(0 0  1 1  99 1  100 0))
	(degree 0 90)))))


;; *** game pulse

(wsound "pads/game_2_pulse"
  (let* ((start-time 0)
	 (end-time 40)
	 (sounds (data (gethash :recov *soundfiles*))))
    (fplay start-time end-time
;;;;  rhythm 
      (duration .001)
      (rhythm (section-val time
			   0 1/12
			   21 2/12
			   31 4/9)
	      (section-val time2
			   0 1/6
			   29 3/12
			   31 4/9))
      (hits (section-val time
			 0 8
			 8 11
			 19 5
			 31 11)
	    (section-val time2
			 0 11
			 13 7
			 22.5 13
			 31 11))
;;;;  blackbox
      (accent (/ (get-beat-prox (/ (- time start-time) hits rhythm) 4) 4)
	      (/ (get-beat-prox (/ (- time2 start-time) hits2 rhythm2) 4) 4))
      (sound (nth-mod 11 sounds))
      (amp (- 1 accent) (- 1 accent2))
      (amp-env '(0 0  1 1  99 1  100 0))
      (degree 0 90))))

;; *** game sub

(wsound "pads/game_2_sub"
  (let* ((start-time 0)
	 (end-time 40)
	 (sounds (data (gethash :recov *soundfiles*))))
    (fplay start-time end-time
;;;;  rhythm 
      (duration .5)
      (rhythm (section-val time
			   0 1/12
			   21 2/12
			   31 4/9)
	      (section-val time2
			   0 1/6
			   29 3/12
			   31 4/9))
      (hits (section-val time
			 0 8
			 8 11
			 19 5
			 31 11)
	    (section-val time2
			 0 11
			 13 7
			 22.5 13
			 31 11))
;;;;  blackbox
      (accent (/ (get-beat-prox (/ (- time start-time) hits rhythm) 4) 4)
	      (/ (get-beat-prox (/ (- time2 start-time) hits2 rhythm2) 4) 4))
      (sound (nth-mod 38 sounds))
      (amp (- 1 accent) (- 1 accent2))
      (amp-env '(0 0  1 1  99 1  100 0))
      (degree 0 90))))

;; gamey  28 30 31 32 33


;; ** sound hierarchy

;;; generating some....stuff. fast paced, change soundfiles
(wsound "sounds_test_trans_7"
  (let* ((sounds1 (data (gethash :recov7 *soundfiles*)))
	 (sounds2 (data (gethash :recov5 *soundfiles*)))
	 (sorted1 '())
	 (sorted2 '()))
    (setf sorted1 (subseq (sort (copy-list sounds1) #'(lambda (x y) (> (transient x) (transient y))))
			  0 50))
    (setf sorted2 (subseq (sort (copy-list sounds2) #'(lambda (x y) (< (flatness x) (flatness y))))
			  0 35))
    (fplay 0 5
      (rhythm 0.01)
      (sound (nth-mod i sorted1))
      (duration (* rhythm 3))
      (degree (random 90)))))

;; ** alternative dreams

(let ((start-time 0)
      (end-time 120))
  (loop for k in '(23 26 31 33)
	and l in '(70 19.5 35.5 27.5)
	and m in '(3 8 9 12)
	and n in '(67.5 75.5 83.5 91.5) do
    (wsound (name-with-var "pads/alt_dreamy" k)
      (fplay start-time end-time
;;;;  rhythm 
	(duration .5)
	(rhythm (if (< time n) 1/24 1/36))
	;(hits (if (< time 43.5) (if (< time l) 5 m) 4))
	(hits (if (< time l) 5 (if (< time 43.5) m 3)))
;;;;  blackbox
	(accent (/ (get-beat-prox (/ (- time start-time) hits rhythm) 4) 4))
	(sound (nth-mod k (data (gethash :recov5 *soundfiles*))))
	(amp (- 1 accent))
	(amp-env '(0 0  1 1  99 1  100 0))))))

;; EOF pads.lsp
