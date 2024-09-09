;; * drums

(in-package :ly)

;; ** drum loops

;; *** stereo loops
(wsound "drums/loops"
  (let ((sounds (data (gethash :loops *soundfiles*))))
    (fplay 0 40
      (rhythm (/ .1 2))
      (metrum 0.15)
      (hits (section-val time 0 8  20 11  30 7))
      (accent (- 1 (/ (get-beat-prox (/ time hits metrum) 6) 6)))
      (sound (nth-mod (nth-mod i (procession 20 (round (dry-wet 4 17 line)))) sounds)
	     (nth-mod (nth-mod i (procession 19 (round (dry-wet 4 17 line)))) sounds))
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
      ;(out-channels 4)
      (degree 0 90))))

;; ** game loops
(wsound "drums/game_loops"
  (fplay 0 40
    (rhythm (/ .1 2))
    (metrum 0.15)
    (hits (section-val time 0 8  20 11  30 7))
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
