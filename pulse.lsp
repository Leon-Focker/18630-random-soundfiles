;; * pulse

(in-package :ly)

;; ** bass samples

(wsound "pulse/pulse1"
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

(loop for k from 0 to 50 by 10 do
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


;;; automated hits and rthms from *struct*
(let* ((start-time 0)
       (end-time 240)		    
       (sounds (data (gethash :recov *soundfiles*))))
  (multiple-value-bind (starts durs hit-list rthm-list)
      (struct-section *struct* 0 240)
    (declare (ignore durs))
    (wsound "pulse/digital_pulse"
      (fplay start-time end-time
;;;;  rhythm
	(curve line)
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
	(accent (/ (get-beat-prox (/ (- time start-time) hits rhythm) 4) 4)
		(/ (get-beat-prox (/ (- time start-time) hits2 rhythm) 4) 4))
	(sound (nth-mod 11 sounds))
	(amp (+ 0.5 (* 0.5 (- 1 accent)))
	     (+ 0.5 (* 0.5 (- 1 accent2))))
	(amp-env '(0 1  .99 1  1 0))
	(degree 0 90)))))

;; EOF pulse.lsp
