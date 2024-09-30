;; * mashup

(in-package :ly)

(wsound "mashup_1"
  (mashup 0 30 '("/E/code/new/pads/groove__RECOV9_50.wav"
		 "/E/code/new/pads/groove__RECOV9_10.wav"
		 "/E/code/new/pads/groove_recov_10.wav"
		 "/E/code/new/pads/groove_recov_20.wav"
		 "/E/code/new/stille.wav"
		 "/E/code/new/pads/groove_recov_20.wav"
		 "/E/code/new/stille.wav"
		 "/E/code/new/stille.wav"
		 "/E/code/new/stille.wav")
      `(,(* 1 .1) ,(* 2 .1) ,(* 1 .1) ,(* 2 .1) ,(* 1 .1) ,(* 1 .1) ,(* 1 .1))
      (procession 300 '(0 1 2 3 4 5 6 7 8))
      '(0 90)
      '(.5 .8 1 1 1)))

(wsound "mashup_2"
  (mashup 0 45 '("/E/code/new/pads/groove__RECOV5_50.wav"
		 "/E/code/new/pads/groove__RECOV5_40.wav"
		 "/E/code/new/pads/groove__RECOV5_30.wav"
		 "/E/code/new/pads/groove__RECOV5_20.wav"
		 "/E/code/new/stille.wav"
		 "/E/code/new/pads/groove__RECOV5_10.wav"
		 "/E/code/new/stille.wav"
		 "/E/code/new/stille.wav"
		 "/E/code/new/stille.wav"
		 "/E/code/new/stille.wav")
      (morph-patterns `((,(* 1 .1) ,(* 2 .1) ,(* 1 .1) ,(* 2 .1) ,(* 1 .1) ,(* 1 .1) ,(* 1 .1))
			(.05 .05 .1)
			(.05 .02))
		      45
		      nil nil nil nil
		      (fibonacci-transitions 50 3))
      (procession 1000 '(0 1 2 3 4 5 6 7 8 9))
      '(0 90)
	  '(1)))

(wsound "mashup_3"
  (mashup 0 45 '("/E/code/new/drums_bounced_1.wav"
		 "/E/code/new/pulse_bounced_1.wav"
		 "/E/code/new/pulse_bounced_2.wav"
		 "/E/code/new/grizzle/dreamy_jingle_1.wav"
		 "/E/code/new/grizzle/dreamy_jingle_3.wav"
		 "/E/code/new/grizzle/dreamy_jingle_5.wav"
		 "/E/code/new/grizzle/dreamy_jingle_9.wav"
		 "/E/code/new/grizzle/dreamy_jingle_13.wav"
		 "/E/code/new/grizzle/dreamy_jingle_17.wav")
      (morph-patterns `((.3 .3 .2)
			(.05 .05 .1)
			(.05 .02))
		      45
		      nil nil nil nil
		      (fibonacci-transitions 50 3))
      (procession 1000 '(0 1 2 3 4 5 6 7 8 9))
      '(0 90)
      '(1)))

;; ** chaos to rhythmic

(let* ((len 35)
       (rthms (morph-patterns `(,(loop repeat 20 collect (+ .02 (random 1)))
				(.1 .1 .2 .2 .2))
			      len
			      nil nil nil nil
			      (fibonacci-transitions 50 2)))
       (order (loop repeat (length rthms)
		    for i from 0
		    for line = (/ i (length rthms))
		    collect (if (< (random 1.0) (expt line 4))
				(1+ (random 5))
				0))))
  (wsound "mashup_evolving"
    (mashup 0 len '("/E/code/new/stille.wav"
		    "/E/code/new/pads/groove__RECOV5_50.wav"
		    "/E/code/new/pads/groove__RECOV5_40.wav"
		    "/E/code/new/pads/groove__RECOV5_30.wav"
		    "/E/code/new/pads/groove__RECOV5_20.wav"
		    "/E/code/new/pads/groove__RECOV5_10.wav")
	rthms
	order
	'(0 90)
	'(1 1 1 1 1 1))))


(let ((k 20))
  (wsound (name-with-var "mashup_groove" k)
    (let* ((start-time 0)
	   (end-time 20)
	   (sounds (data (gethash :recov5 *soundfiles*))))
      (fplay start-time end-time
;;;;  rhythm 
	(duration .5)
	(rhythm 6/12)
	(hits (section-val (- time start-time) 0 8 4 7 8 5 15 2))
;;;;  blackbox
	(accent (/ (get-beat-prox (/ (- time start-time) hits rhythm) 4) 4))
	(sound (cond ((> accent .7) (nth-mod (+ k 19) sounds))
		     ((> accent .5) (nth-mod (+ k 17) sounds))
		     (t (nth-mod (+ k 15) sounds))))
	(amp (- 1 accent))
	(amp-env '(0 0  1 1  99 1  100 0))
	(degree 0 90)))))

;; EOF mashup.lsp
