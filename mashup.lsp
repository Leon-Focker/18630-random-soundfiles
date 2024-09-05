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

;; EOF mashup.lsp
