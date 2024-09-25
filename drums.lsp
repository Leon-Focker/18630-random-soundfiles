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

;; *** pulse variations

(loop for k in '(6 7 8 9) do
  (wsound (name-with-var "drums/pulse_evolving_original" k)
    (fplay 0 48
      (rhythm .05)
      (hits k)
      (metrum (* rhythm 3))
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
      (degree 0 90))))

;; *** Sub
(loop for k in '(8 9 11) do
  (wsound (name-with-var "drums/sub_evolving" k)
    (let ((sounds (data (gethash :recov *soundfiles*))))
      (fplay 0 48
	(rhythm .05)
	(hits k)
	(metrum (* rhythm 3))
	(accent (- 1 (/ (get-beat-prox (/ time hits metrum) 6) 6)))
	(sound (nth-mod 38 sounds))
	(on (cond ((>= accent 5/6) 1)
		  ((>= accent 3/6) (if (>= (mod time .3) .1) 1 0))
		  (t (if (>= (mod time .5) .25) 1 0))))
	(start (mod (cond ((>= accent 5/6) 0)
			  ((>= accent 3/6) 2)
			  (t 5))
		    (soundfile-duration (path sound))))
	(duration (* rhythm 4))
	(amp (* (expt accent 2) on))
	(amp-env '(0 0  1 1  33 1  100 0))
	;;(out-channels 4)
	(degree 0 90)))))

;; *** game evolving
(wsound "drums/game_evolving_7"
  (fplay 0 48
    (rhythm .05)
    (hits 7)
    (metrum (* rhythm 3))
    (accent (- 1 (/ (get-beat-prox (/ time hits metrum) 6) 6)))
    (file (format nil "~a~a" *bleeps-src-dir* "pads/game_2_0.wav"))
    (on (cond ((>= accent 5/6) 1)
	      ((>= accent 3/6) (if (>= (mod time .3) .1) 1 0))
	      (t (if (>= (mod time .5) .25) 1 0))))
    (start (mod (cond ((>= accent 5/6) 0)
		      ((>= accent 3/6) (/ time 2))
		      (t time))
		(soundfile-duration file)))
    (duration (* rhythm 8))
    (amp (* (expt accent 2) on))
    (amp-env '(0 0  1 1  33 1  100 0))
    ;;(out-channels 4)
    (degree 0 90)))

;; ** noise variations

;; *** noise
(loop for f in '(1 2 4) do
  (loop for k in '(7 8 9 10 11) do
    (wsound (name-with-var "drums/noise_evolving" f k)
      (let ((files '("/E/code/new/stille.wav"
		     "/E/code/new/pads/groove__RECOV5_50.wav"
		     "/E/code/new/pads/groove__RECOV5_40.wav"
		     "/E/code/new/pads/groove__RECOV5_30.wav"
		     "/E/code/new/pads/groove__RECOV5_20.wav"
		     "/E/code/new/pads/groove__RECOV5_10.wav")))
	(fplay 0 48
	  (rhythm .1)			; 0.5
	  (hits k)
	  (metrum (* rhythm 3))
	  (accent (- 1 (/ (get-beat-prox (/ time hits metrum) 6) 6)))
	  (file (nth-mod f files))
	  (on (cond ((>= accent 5/6) 1)
		    ((>= accent 3/6) (if (>= (mod time .3) .1) 1 0))
		    (t (if (>= (mod time .5) .25) 1 0))))
	  (start (mod (cond ((>= accent 5/6) 0)
			    ((>= accent 3/6) 2)
			    (t 5))
		      (soundfile-duration file)))
	  (duration (* rhythm 1))	; 4
	  (amp (* 1 on))
	  (amp-env '(0 0  1 1  33 1  100 0))
	  (out-channels 1)
	  (degree 0))))))

;; *** Sub 2
(loop for k in '(3 4 6 7) do
  (wsound (name-with-var "drums/sub2_evolving" k)
    (let ((sounds (data (gethash :recov *soundfiles*))))
      (fplay 0 48
	(rhythm .1)			; 0.5
	(hits k)
	(metrum (* rhythm 3))
	(accent (- 1 (/ (get-beat-prox (/ time hits metrum) 6) 6)))
	(sound (nth-mod 38 sounds))
	(on (cond ((>= accent 5/6) 1)
		  ((>= accent 3/6) (if (>= (mod time .3) .1) 1 0))
		  (t (if (>= (mod time .5) .25) 1 0))))
	(start (mod (cond ((>= accent 5/6) 0)
			  ((>= accent 3/6) 2)
			  (t 5))
		    (soundfile-duration (path sound))))
	(duration (* rhythm 1))		; 4
	(amp (* 1 on))
	(amp-env '(0 0  1 1  33 1  100 0))
	(out-channels 1)
	(degree 0)))))

;; *** drums
(loop for k in '(7 8 9 10 11) do
  (wsound (name-with-var "drums/drums_evolving" k)
    (let ((sounds (data (gethash :loops *soundfiles*))))
      (fplay 0 48
	(rhythm .1)
	(hits k)
	(metrum (* rhythm 3))
	(accent (- 1 (/ (get-beat-prox (/ time hits metrum) 6) 6)))
	(sound (nth-mod (nth-mod i (procession 20 (round (dry-wet 4 17 line)))) sounds))
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
	(out-channels 1)
	(degree 0 90)))))

;; *** pulse

(loop for k in '(7 8 9 10 11) do
  (wsound (name-with-var "drums/noise_pulse_evolving" k)
    (fplay 0 48
      (rhythm .1)			; 0.5
      (hits k)
      (metrum (* rhythm 3))
      (accent (- 1 (/ (get-beat-prox (/ time hits metrum) 6) 6)))
      (sound (nth-mod 11 (data (gethash :recov *soundfiles*))))
      (on (cond ((>= accent 5/6) 1)
		((>= accent 3/6) (if (>= (mod time .3) .1) 1 0))
		(t (if (>= (mod time .5) .25) 1 0))))
      (start (mod (cond ((>= accent 5/6) 0)
			((>= accent 3/6) 2)
			(t 5))
		  (soundfile-duration (path sound))))
      (duration 0.001)
      (amp (* 1 on))
      (amp-env '(0 0  1 1  33 1  100 0))
      (out-channels 1)
      (degree 0))))

;; ** build-up

;; *** simple drums build-up
(loop for len in '(15 25) do
  (wsound (name-with-var "drums/drums_build" len)
    (let ((sounds (data (gethash :loops *soundfiles*))))
      (fplay 0 len
	(rhythm (dry-wet .005 .05 (expt line 5)))
	(hits 8)
	(metrum (* rhythm 3))
	(accent (- 1 (/ (get-beat-prox (/ time hits metrum) 6) 6)))
	(sound (nth-mod (nth-mod i (procession 20 (round (dry-wet 4 17 (- 1 line))))) sounds)
	       (nth-mod (nth-mod i (procession 19 (round (dry-wet 4 17 (- 1 line))))) sounds)
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
	(duration (* 0.05 3))
	(amp (* (expt accent 2) on))
	(amp-env '(0 0  1 1  33 1  100 0))
	;;(out-channels 4)
	(degree 0 90)))))

;; *** drums variations
(wsound "drums/drums_variations"
  (let ((sounds (data (gethash :loops *soundfiles*))))
    (fplay 0 24
      (rand (dry-wet 0.01 0 line))
      (rhythm (if (> rand 0)
		  ;; fixed "random"
		  (+ .05 (- (mod (* (+ time .1) 47357.253) rand) (/ rand 2)))
		  .05))
      (hits 8)
      (metrum (* rhythm 3))
      (accent (- 1 (/ (get-beat-prox (/ time hits metrum) 6) 6)))
      (sound (nth-mod (nth-mod i (procession 20 (round (dry-wet 4 17 (- 1 line))))) sounds)
	     (nth-mod (nth-mod i (procession 19 (round (dry-wet 4 17 (- 1 line))))) sounds)
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

(loop for nr in '(.01 .005 .001 .0001) do
  (wsound (name-with-var "drums/drums_variations" nr)
    (let ((sounds (data (gethash :loops *soundfiles*))))
      (fplay 0 5
	(rand nr)
	(rhythm (if (> rand 0)
		    ;; fixed "random"
		    (+ .05 (- (mod (* (+ time .1) 47357.253) rand) (/ rand 2)))
		    .05))
	(hits 8)
	(metrum (* rhythm 3))
	(accent (- 1 (/ (get-beat-prox (/ time hits metrum) 6) 6)))
	(sound (nth-mod (nth-mod i (procession 20 (round (dry-wet 4 17 (- 1 line))))) sounds)
	       (nth-mod (nth-mod i (procession 19 (round (dry-wet 4 17 (- 1 line))))) sounds)
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
	(degree 0 90)))))

(wsound "drums/drums_variations_2"
  (let ((sounds (data (gethash :loops *soundfiles*))))
    (fplay 0 24
      (rhythm 0.05)
      (hits (dry-wet 8 11 (min (* line 1.2) 1)))
      (metrum (* rhythm 3))
      (accent (- 1 (/ (get-beat-prox (/ time hits metrum) 6) 6)))
      (sound (nth-mod (nth-mod i (procession 20 (round (dry-wet 4 17 (- 1 line))))) sounds)
	     (nth-mod (nth-mod i (procession 19 (round (dry-wet 4 17 (- 1 line))))) sounds)
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

;; *** simple drums 
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



;; EOF drums.lsp
