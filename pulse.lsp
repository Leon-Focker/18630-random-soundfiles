;; * pulse

(in-package :ly)

;; ** bass samples

#+nil(wsound "pulse/pulse1"
  (let* ((start-time 0)
	 (end-time 30)
	 (sounds (data (gethash :percussive *soundfiles*))))
    (fplay start-time end-time
;;;;  rhythm
      (curve line)
      (duration (dry-wet 0.5 0.01 curve))
      (rhythm 2/9)
      (hits (section-val (- time start-time) 0 8 4 7 8 5)) 
;;;;  blackbox
      (accent (/ (get-beat-prox (/ (- time start-time) hits rhythm) 4) 4))
      (sound (cond ((> accent .7) (nth-mod 19 sounds))
		   ((> accent .5) (nth-mod 17 sounds))
		   (t (nth-mod (+ 10 (random (round (dry-wet 8 1 curve)))) sounds))))
      (amp (- 1 accent))
      (amp-env '(0 1  .99 1  1 0))
      (degree 0 90))))

;; ** exploring other samples (meh!)

#+nil(loop for k from 0 to 50 by 10 do
  (wsound (name-with-var "pulse/pulse_recov" k)
    (let* ((start-time 0)
	   (end-time 30)
	   (sounds (data (gethash :recov *soundfiles*))))
      (fplay start-time end-time
;;;;  rhythm
	(curve line)
	(duration 0.003)
	(rhythm 2/9)
	(hits (section-val (- time start-time) 0 8 4 7 8 5)) 
;;;;  blackbox
	(accent (/ (get-beat-prox (/ (- time start-time) hits rhythm) 4) 4))
	(sound (cond ((> accent .7) (nth-mod (+ k 19) sounds))
		     ((> accent .5) (nth-mod (+ k 17) sounds))
		     (t (nth-mod (+ k 10 (random (round (dry-wet 8 1 curve)))) sounds))))
	(amp (- 1 accent))
	(amp-env '(0 1  .99 1  1 0))
	(degree 0 90)))))

;; ** digital pulse

(wsound (name-with-var "pulse/pulse_recov" 11 "0.005-0.001")
  (let* ((start-time 0)
	 (end-time 60)
	 (sounds (data (gethash :recov *soundfiles*))))
    (fplay start-time end-time
;;;;  rhythm
      (curve line)
      (duration (dry-wet 0.005 0.001 curve))
      (rhythm 2/9)
      (hits (section-val (- time start-time) 0 8 4 7 8 5)) 
;;;;  blackbox
      (accent (/ (get-beat-prox (/ (- time start-time) hits rhythm) 4) 4))
      (sound (nth-mod 11 sounds))
      (amp (+ 0.5 (* 0.5 (- 1 accent))))
      (amp-env '(0 1  .99 1  1 0))
      (degree 0 90))))

;;; *** pulse 1 
(let* ((start-time 0)
       (end-time 240)		    
       (sounds (data (gethash :recov *soundfiles*))))
  (multiple-value-bind (starts durs hit-list rthm-list)
      (struct-section *struct* start-time end-time)
    (declare (ignore durs))
    
    (wsound "pulse/digital_pulse"
      (fplay start-time end-time
;;;;  now also a blackbox
	(curve line line2)
	(duration (dry-wet 0.005 0.001 curve))
	(rhythm (apply #'section-val time
		       (special-interleave starts rthm-list))
		(apply #'section-val time2
		       (special-interleave starts rthm-list 1)))
	(hits (apply #'section-val time
		     (special-interleave starts hit-list))
	      (apply #'section-val time2
		     (special-interleave starts hit-list 1)))
;;;;  blackbox
	(accent (/ (get-beat-prox (/ (- time start-time)  hits  rhythm) 4) 4)
		(/ (get-beat-prox (/ (- time2 start-time) hits2 rhythm) 4) 4))
	(sound (nth-mod 11 sounds))
	(amp (+ (dry-wet 0.5 0.2 curve)  (* (dry-wet 0.5 0.8 curve)  (- 1 accent)))
	     (+ (dry-wet 0.5 0.2 curve2) (* (dry-wet 0.5 0.8 curve2) (- 1 accent2))))
	(amp-env '(0 1  .99 1  1 0))
	(degree 0 90)))))

;; *** pulse 1 additional
(let* ((start-time 0)
       (end-time 240)		    
       (sounds (data (gethash :recov5 *soundfiles*))))
  (multiple-value-bind (starts durs hit-list rthm-list)
      (struct-section *struct* start-time end-time)
    (declare (ignore durs))
    
    (wsound "pulse/digital_pulse_add"
      (fplay start-time end-time
;;;;  now also a blackbox
	(curve line line2)
	(duration 0.005)
	(rhythm (apply #'section-val time
		       (special-interleave starts rthm-list))
		(apply #'section-val time2
		       (special-interleave starts rthm-list 1)))
	(hits (apply #'section-val time
		     (special-interleave starts hit-list))
	      (apply #'section-val time2
		     (special-interleave starts hit-list 1)))
;;;;  blackbox
	(accent (/ (get-beat-prox (/ (- time start-time)  hits  rhythm) 4) 4)
		(/ (get-beat-prox (/ (- time2 start-time) hits2 rhythm) 4) 4))
	(sound (nth-mod 30 sounds))
	(amp (if (< accent .6) (- 1 accent)  0)
	     (if (< accent2 .6) (- 1 accent2) 0))
	(amp-env '(0 1  .99 1  1 0))
	(degree 0 90)))))

;; *** pulse 2
(let* ((start-time 272)
       (end-time 320)		    
       (sounds (data (gethash :recov *soundfiles*))))
  (multiple-value-bind (starts durs hit-list rthm-list)
      (struct-section *struct* start-time end-time)
    (declare (ignore durs))
    
    (wsound "pulse/digital_pulse_2"
      (fplay start-time end-time
;;;;  now also a blackbox
	(time start-time (+ start-time .1212) start-time)
	(curve line line2 line3)
	(duration 0.001)
	(srt 1 1 2)
	(rhythm (apply #'section-val time
		       (special-interleave starts rthm-list))
		(apply #'section-val time2
		       (special-interleave starts rthm-list 1))
		(apply #'section-val time3
		       (special-interleave starts rthm-list 2)))
	(hits (apply #'section-val time
		     (special-interleave starts hit-list))
	      (apply #'section-val time2
		     (special-interleave starts hit-list 1))
	      (apply #'section-val time3
		     (special-interleave starts hit-list 2)))
;;;;  blackbox
	(accent (/ (get-beat-prox (/ (- time start-time)  hits  rhythm) 4) 4)
		(/ (get-beat-prox (/ (- time2 start-time) hits2 rhythm) 4) 4)
		(/ (get-beat-prox (/ (- time3 start-time) hits3 rhythm) 4) 4))
	(sound (nth-mod 11 sounds))
	(amp (+ .1 (* .9 (- 1 accent)))
	     (+ .1 (* .9 (- 1 accent2)))
	     (+ .1 (* .9 (- 1 accent3))))
	(amp-env '(0 1  .99 1  1 0))
	(degree 0 90 45)))))

;; *** pulse 2 additional
(let* ((start-time 272)
       (end-time 320)		    
       (sounds (data (gethash :recov5 *soundfiles*))))
  (multiple-value-bind (starts durs hit-list rthm-list)
      (struct-section *struct* start-time end-time)
    (declare (ignore durs))
    
    (wsound "pulse/digital_pulse_2_add"
      (fplay start-time end-time
;;;;  now also a blackbox
	(time start-time (+ start-time .1212) start-time)
	(curve line line2 line3)
	(duration 0.001)
	(srt .25 .25 .5)
	(rhythm (apply #'section-val time
		       (special-interleave starts rthm-list))
		(apply #'section-val time2
		       (special-interleave starts rthm-list 1))
		(apply #'section-val time3
		       (special-interleave starts rthm-list 2)))
	(hits (apply #'section-val time
		     (special-interleave starts hit-list))
	      (apply #'section-val time2
		     (special-interleave starts hit-list 1))
	      (apply #'section-val time3
		     (special-interleave starts hit-list 2)))
;;;;  blackbox
	(accent (/ (get-beat-prox (/ (- time start-time)  hits  rhythm) 4) 4)
		(/ (get-beat-prox (/ (- time2 start-time) hits2 rhythm) 4) 4)
		(/ (get-beat-prox (/ (- time3 start-time) hits3 rhythm) 4) 4))
	(sound (nth-mod 30 sounds))
	(amp (+ .1 (* .9 (- 1 accent)))
	     (+ .1 (* .9 (- 1 accent2)))
	     (+ .1 (* .9 (- 1 accent3))))
	(amp-env '(0 1  .99 1  1 0))
	(degree 0 90 45)))))

;; EOF pulse.lsp
