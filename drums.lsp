;; * drums

(in-package :ly)

;; ** evolving

;; *** simple drums evolving
(wsound "drums/drums_8_evolving"
  (let ((sounds (data (gethash :loops *soundfiles*))))
    (fplay 0 48
      (rhythm .05)
      (hits 8)
      (metrum (* rhythm 3))
      (accent (- 1 (/ (get-beat-prox (/ time hits metrum) 6) 6)))
      (sound (nth-mod (nth-mod i (procession 20 (round (dry-wet 4 17 line)))) sounds)
	     (nth-mod (nth-mod i (procession 19 (round (dry-wet 4 17 line)))) sounds)
	     ;;(nth-mod (nth-mod i (procession 18 (round (dry-wet 4 17 line)))) sounds)
	     ;;(nth-mod (nth-mod i (procession 17 (round (dry-wet 4 17 line)))) sounds)
	     )
      (on (cond ((>= accent 5/6) 1)
		((>= accent 3/6) (if (>= (mod time .3) .1) 1 0))
		(t (if (>= (mod time .5) .25) 1 0))))
      (start (mod (cond ((>= accent 5/6) 0)
			((>= accent 3/6) 2)
			(t 5))
		  (soundfile-duration (path sound))))
      (duration (* rhythm 3))
      (amp (* (expt accent 2) on))
      (amp-env '(0 0  1 1  33 1  100 0))
      ;;(out-channels 4)
      (degree 0 90))))

;; *** simple pulse
(loop for stuff in '(t nil) do
  (wsound (name-with-var "drums/pulse_evolving" stuff)
    (fplay 0 48
      (rhythm .05)
      (hits 8)
      (metrum (* rhythm 3))
      (accent (- 1 (/ (get-beat-prox (/ time hits metrum) 6) 6)))
      (sound (nth-mod 30 (data (gethash :recov5 *soundfiles*))))
      (on (cond ((>= accent 5/6) 1)
		((>= accent 3/6) (if (>= (mod time .3) .1) 1 0))
		(t (if (>= (mod time .5) .25) 1 0))))
      (start (if stuff
		 (mod (cond ((>= accent 5/6) 0)
			    ((>= accent 3/6) 2)
			    (t 5))
		      (soundfile-duration (path sound)))
		 0))
      (duration 0.001)
      (srt .25 .25 .5)
      (amp (* (expt accent 2) on))
      (amp-env '(0 0  1 1  33 1  100 0))
      ;;(out-channels 4)
      (degree 0 90 45))))

;; *** simple pulse original
(wsound "drums/pulse_evolving_original"
  (fplay 0 48
    (rhythm .025)
    (hits 8)
    (metrum (* rhythm 6))
    (accent (- 1 (/ (get-beat-prox (/ time hits metrum) 6) 6)))
    (sound (nth-mod 11 (data (gethash :recov *soundfiles*))))
    (on (cond ((>= accent 5/6) 1)
	      ((>= accent 3/6) (if (>= (mod time .3) .1) 1 0))
	      (t (if (>= (mod time .5) .25) 1 0))))
    (start (mod (cond ((>= accent 5/6) 0)
		      ((>= accent 3/6) 2)
		      (t 5))
		(soundfile-duration (path sound)))
	   0)
    (duration 0.001)
    (amp (* (expt accent 2) on))
    (amp-env '(0 0  1 1  33 1  100 0))
    ;;(out-channels 4)
    (degree 0 90)))

;; ** slowdown

;; *** pulse slowdown
(loop for stuff in '(t nil) do
  (wsound (name-with-var "drums/pulse_slowdown" stuff)
    (fplay 0 33
      (rhythm (dry-wet .007 .05 (expt line 2)))
      (hits 8)
      (metrum (* rhythm 3))
      (accent (- 1 (/ (get-beat-prox (/ time hits metrum) 6) 6)))
      (sound (nth-mod 30 (data (gethash :recov5 *soundfiles*))))
      (on (cond ((>= accent 5/6) 1)
		((>= accent 3/6) (if (>= (mod time .3) .1) 1 0))
		(t (if (>= (mod time .5) .25) 1 0))))
      (start (if stuff
		 (mod (cond ((>= accent 5/6) 0)
			    ((>= accent 3/6) 2)
			    (t 5))
		      (soundfile-duration (path sound)))
		 0))
      (duration 0.001)
      (srt .25 .25 .5)
      (amp (* (expt accent 2) on))
      (amp-env '(0 0  1 1  33 1  100 0))
      ;;(out-channels 4)
      (degree 0 90 45))))

;; *** pulse slowdown original
(wsound "drums/pulse_slowdown_original"
  (fplay 0 33
    (rhythm (* (dry-wet .007 .05 (expt line 2)) 0.5))
    (hits 8)
    (metrum (* rhythm 6))
    (accent (- 1 (/ (get-beat-prox (/ time hits metrum) 6) 6)))
    (sound (nth-mod 11 (data (gethash :recov *soundfiles*))))
    (on (cond ((>= accent 5/6) 1)
	      ((>= accent 3/6) (if (>= (mod time .3) .1) 1 0))
	      (t (if (>= (mod time .5) .25) 1 0))))
    (start (mod (cond ((>= accent 5/6) 0)
		      ((>= accent 3/6) 2)
		      (t 5))
		(soundfile-duration (path sound)))
	   0)
    (duration 0.001)
    (amp (* (expt accent 2) on))
    (amp-env '(0 0  1 1  33 1  100 0))
    ;;(out-channels 4)
    (degree 0 905)))

;; *** drums slowdown
(wsound "drums/drums_slowdown"
  (let ((sounds (data (gethash :loops *soundfiles*))))
    (fplay 0 33
      (rhythm (dry-wet .007 .05 (expt line 2)))
      (hits 8)
      (metrum (* rhythm 3))
      (accent (- 1 (/ (get-beat-prox (/ time hits metrum) 6) 6)))
      (sound (nth-mod (nth-mod i (procession 20 (round (dry-wet 8 4 line)))) sounds)
	     (nth-mod (nth-mod i (procession 19 (round (dry-wet 8 4 line)))) sounds)
	     ;;(nth-mod (nth-mod i (procession 18 (round (dry-wet 4 17 line)))) sounds)
	     ;;(nth-mod (nth-mod i (procession 17 (round (dry-wet 4 17 line)))) sounds)
	     )
      (on (cond ((>= accent 5/6) 1)
		((>= accent 3/6) (if (>= (mod time .3) .1) 1 0))
		(t (if (>= (mod time .5) .25) 1 0))))
      (start (mod (cond ((>= accent 5/6) 0)
			((>= accent 3/6) 2)
			(t 5))
		  (soundfile-duration (path sound))))
      (duration (* rhythm 3))
      (amp (* (expt accent 2) on))
      (amp-env '(0 0  1 1  33 1  100 0))
      ;;(out-channels 4)
      (degree 0 90))))

;; ** odd metres

;; *** simple drums evolving
(wsound "drums/drums_odd"
  (let ((sounds (data (gethash :loops *soundfiles*))))
    (fplay 0 50
      (rhythm (dry-wet .05 .15 (expt line 10)))
      (hits (section-val time 0 11 15 7))
      (metrum (* rhythm 3))
      (accent (- 1 (/ (get-beat-prox (/ time hits metrum) 6) 6)))
      (sound (nth-mod (nth-mod i (procession 20 (round (dry-wet 4 17 line)))) sounds)
	     (nth-mod (nth-mod i (procession 19 (round (dry-wet 4 17 line)))) sounds)
	     ;;(nth-mod (nth-mod i (procession 18 (round (dry-wet 4 17 line)))) sounds)
	     ;;(nth-mod (nth-mod i (procession 17 (round (dry-wet 4 17 line)))) sounds)
	     )
      (on (cond ((>= accent 5/6) 1)
		((>= accent 3/6) (if (>= (mod time .3) .1) 1 0))
		(t (if (>= (mod time .5) .25) 1 0))))
      (start (mod (cond ((>= accent 5/6) 0)
			((>= accent 3/6) 2)
			(t 5))
		  (soundfile-duration (path sound))))
      (duration (* rhythm 3))
      (amp (* (expt accent 2) on))
      (amp-env '(0 0  1 1  33 1  100 0))
      ;;(out-channels 4)
      (degree 0 90))))

;; ** other stuff

(let ((start-time 0)
      (end-time 60))
  (multiple-value-bind (starts durs hit-list rthm-list)
      (struct-section *drums-struct* start-time end-time)
    (declare (ignore durs))

    ;; *** drum loop 1
    (wsound "drums/drums_1"
      (let ((sounds (data (gethash :loops *soundfiles*))))
	(fplay start-time end-time
	  (rhythm (apply #'section-val time
			 (special-interleave starts rthm-list)))
	  (hits (apply #'section-val time
		       (special-interleave starts hit-list)))
	  (metrum (* rhythm 3))
	  (accent (- 1 (/ (get-beat-prox (/ time hits metrum) 6) 6)))
	  (sound (nth-mod (nth-mod i (procession 20 (round (dry-wet 4 10 line)))) sounds)
		 (nth-mod (nth-mod i (procession 19 (round (dry-wet 4 10 line)))) sounds)
		 ;;(nth-mod (nth-mod i (procession 18 (round (dry-wet 4 17 line)))) sounds)
		 ;;(nth-mod (nth-mod i (procession 17 (round (dry-wet 4 17 line)))) sounds)
		 )
	  (on (cond ((>= accent 5/6) 1)
		    ((>= accent 3/6) (if (>= (mod time .3) .1) 1 0))
		    (t (if (>= (mod time .5) .25) 1 0))))
	  (start (mod (cond ((>= accent 5/6) 0)
			    ((>= accent 3/6) 2)
			    (t 5))
		      (soundfile-duration (path sound))))
	  (duration (* rhythm 3))
	  (amp (* (expt accent 2) on))
	  (amp-env '(0 0  1 1  33 1  100 0))
	  ;;(out-channels 4)
	  (degree 0 90))))

    ;; *** game loops
    (wsound "drums/game_loops"
      (fplay start-time end-time
	(rhythm (apply #'section-val time
		       (special-interleave starts rthm-list)))
	(hits (apply #'section-val time
		     (special-interleave starts hit-list)))
	(metrum (* rhythm 3))
	(accent (- 1 (/ (get-beat-prox (/ time hits metrum) 6) 6)))
	(file (format nil "~a~a" *bleeps-src-dir* "pads/game_2_0.wav"))
	(on (cond ((>= accent 5/6) 1)
		  ((>= accent 3/6) (if (>= (mod time .3) .1) 1 0))
		  (t (if (>= (mod time .5) .25) 1 0))))
	(start (mod (cond ((>= accent 5/6) 0)
			  ((>= accent 3/6) 2)
			  (t 5))
		    (soundfile-duration file)))
	(duration (* rhythm 3))
	(amp (* (expt accent 2) on))
	(amp-env '(0 0  1 1  33 1  100 0))
	;;(out-channels 4)
	(degree 0 90)))

    (wsound "drums/game_loops_2"
      (fplay start-time end-time
	(rhythm (apply #'section-val time
		       (special-interleave starts rthm-list)))
	(hits (apply #'section-val time
		     (special-interleave starts hit-list)))
	(metrum (* rhythm 3))
	(accent (- 1 (/ (get-beat-prox (/ time hits metrum) 6) 6)))
	(sound (nth-mod 26 (data (gethash :recov5 *soundfiles*))))
	(on (cond ((>= accent 5/6) 1)
		  ((>= accent 3/6) (if (>= (mod time .3) .1) 1 0))
		  (t (if (>= (mod time .5) .25) 1 0))))
	(duration (dry-wet (* rhythm 5) rhythm line))
	(srt .25 .25 1)
	(amp (* (expt accent 2) on))
	(amp-env '(0 0  1 1  33 1  100 0))
	;;(out-channels 4)
	(degree 0 90 45)))
    
    ;; *** pulse loops
    (loop for stuff in '(t nil) do
      (wsound (name-with-var "drums/pulse_loops" stuff)
	(fplay start-time end-time
	  (rhythm (apply #'section-val time
			 (special-interleave starts rthm-list)))
	  (hits (apply #'section-val time
		       (special-interleave starts hit-list)))
	  (metrum (* rhythm 3))
	  (accent (- 1 (/ (get-beat-prox (/ time hits metrum) 6) 6)))
	  (sound (nth-mod 30 (data (gethash :recov5 *soundfiles*))))
	  (on (cond ((>= accent 5/6) 1)
		    ((>= accent 3/6) (if (>= (mod time .3) .1) 1 0))
		    (t (if (>= (mod time .5) .25) 1 0))))
	  (start (if stuff
		     (mod (cond ((>= accent 5/6) 0)
				((>= accent 3/6) 2)
				(t 5))
			  (soundfile-duration (path sound)))
		     0))
	  (duration 0.001)
	  (srt .25 .25 .5)
	  (amp (* (expt accent 2) on))
	  (amp-env '(0 0  1 1  33 1  100 0))
	  ;;(out-channels 4)
	  (degree 0 90 45))))
    
    ))

;; ** pads
;;; sounds meh
#+nil(wsound "drums/loops_pads"
  (let ((sounds (data (gethash :pads *soundfiles*))))
    (fplay 0 40
      (rhythm (/ .1 2))
      (metrum 0.15)
      (hits (section-val time 0 8  20 7))
      (accent (- 1 (/ (get-beat-prox (/ time hits metrum) 6) 6)))
      (sound (nth-mod (nth-mod i (procession 20 (round (dry-wet 4 10 line)))) sounds)
		  (nth-mod (nth-mod i (procession 19 (round (dry-wet 4 10 line)))) sounds))
      (on (cond ((>= accent 5/6) 1)
		((>= accent 3/6) (if (>= (mod time .3) .1) 1 0))
		(t (if (>= (mod time .5) .25) 1 0))))
      #+nil(start (mod (cond ((>= accent 5/6) 0)
			((>= accent 3/6) 2)
			(t 5))
		       (soundfile-duration (path sound))))
      (start (mod time (soundfile-duration (path sound))))
      (duration (* rhythm 3))
      (amp (* (expt accent 2) on))
      (amp-env '(0 0  1 1  33 1  100 0))
      (degree 0 90))))

;; ** drum samples
;;; meh
#+nil(wsound "drums_test"
  (let ((kicks (data (gethash :kicks *soundfiles*)))
	(snares (data (gethash :snares *soundfiles*)))
	(hats (data (gethash :hats *soundfiles*))))
    (fplay 0 20
      (rhythm (/ .1 2))
      (metrum 0.15)
      (hits (section-val time 0 8  10 7  15 11))
      (accent (- 1 (/ (get-beat-prox (/ time hits metrum) 6) 6)))
      (pallette (cond ((>= accent 5/6) kicks)
		      ((>= accent 3/6) snares)
		      (t hats)))
      (on (cond ((>= accent 5/6) 1)
		((>= accent 3/6) (if (>= (random 10) 3) 1 0))
		(t (if (>= (random 10) 5) 1 0))))
      ;;(humanize (setf rhythm (+ rhythm (- (random 0.002) .001))))
      (duration (* rhythm 3))
      (sound (nth (random 2) pallette))
      (amp (* (expt accent 2) on))
      (amp-env '(0 0  1 1  99 1  100 0))
      (degree (random 90)))))

;; EOF drums.lsp
