;; * Soundfiles
;;; collect and analyse soundfiles, store them as ly::stored-file-list objects
;;; within a hashtable. This table can be accessed with the global variable
;;; *soundfiles*

(in-package :ly)

;; ** stille

(setf (gethash :stille *soundfiles*)
      (make-stored-file 'stille "samples/stille.wav"
			:directory *bleeps-src-dir*))

;; ** percussive sounds

(create-sfl :percussive)

(probe-analyse-store :percussive
  (folder-to-stored-file-list
   (gethash :percussive *soundfiles*)
   (format nil "~a~a" *bleeps-src-dir* "samples/percussive/")
   :analyse t
   :auto-map nil
   :auto-scale-mapping nil
   :remap nil
   ;;:fft-size 4096
   :f1 #'(lambda (sf) (/ (log (/ (+ (dominant-frequency sf)
			       (centroid sf))
			    2))
		    12000))
   :f2 #'(lambda (sf) (* (expt (transient sf) 0.7)
		    0.6))
   :f3 #'(lambda (sf) (- 1 (expt (smoothness sf)
			    0.5)))))

;; ** distorted sounds

(create-sfl :distorted)

(probe-analyse-store :distorted
  (folder-to-stored-file-list
   (gethash :distorted *soundfiles*)
   (format nil "~a~a" *bleeps-src-dir* "samples/distorted/")
   :analyse t
   :auto-map nil
   :auto-scale-mapping nil
   :remap nil
   ;;:fft-size 4096
   :f1 #'(lambda (sf) (/ (log (/ (+ (dominant-frequency sf)
			       (centroid sf))
			    2))
		    12000))
   :f2 #'(lambda (sf) (* (expt (transient sf) 0.7)
		    0.6))
   :f3 #'(lambda (sf) (- 1 (expt (smoothness sf)
			    0.5)))))

;; ** harmonic sounds

(create-sfl :harmonics)

(probe-analyse-store :harmonics
  (folder-to-stored-file-list
   (gethash :harmonics *soundfiles*)
   (format nil "~a~a" *bleeps-src-dir* "samples/harmonics/")
   :analyse t
   :auto-map nil
   :auto-scale-mapping nil
   :remap nil
   ;;:fft-size 4096
   :f1 #'(lambda (sf) (/ (log (/ (+ (dominant-frequency sf)
			       (centroid sf))
			    2))
		    12000))
   :f2 #'(lambda (sf) (* (expt (transient sf) 0.7)
		    0.6))
   :f3 #'(lambda (sf) (- 1 (expt (smoothness sf)
			    0.5)))))

;; ** drum loops

(create-sfl :loops)

(probe-analyse-store :loops
  (folder-to-stored-file-list
   (gethash :loops *soundfiles*)
   (format nil "~a~a" *bleeps-src-dir* "samples/loops/")
   :analyse t
   :auto-map nil
   :auto-scale-mapping nil
   :remap nil
   ;;:fft-size 4096
   :f1 #'(lambda (sf) (/ (log (/ (+ (dominant-frequency sf)
			       (centroid sf))
			    2))
		    12000))
   :f2 #'(lambda (sf) (* (expt (transient sf) 0.7)
		    0.6))
   :f3 #'(lambda (sf) (- 1 (expt (smoothness sf)
			    0.5)))))

;; ** kicks

(create-sfl :kicks)

(probe-analyse-store :kicks
  (folder-to-stored-file-list
   (gethash :kicks *soundfiles*)
   (format nil "~a~a" *bleeps-src-dir* "samples/kicks/")
   :analyse t
   :auto-map nil
   :auto-scale-mapping nil
   :remap nil
   ;;:fft-size 4096
   :f1 #'(lambda (sf) (/ (log (/ (+ (dominant-frequency sf)
			       (centroid sf))
			    2))
		    12000))
   :f2 #'(lambda (sf) (* (expt (transient sf) 0.7)
		    0.6))
   :f3 #'(lambda (sf) (- 1 (expt (smoothness sf)
			    0.5)))))

;; ** snares

(create-sfl :snares)

(probe-analyse-store :snares
  (folder-to-stored-file-list
   (gethash :snares *soundfiles*)
   (format nil "~a~a" *bleeps-src-dir* "samples/snares/")
   :analyse t
   :auto-map nil
   :auto-scale-mapping nil
   :remap nil
   ;;:fft-size 4096
   :f1 #'(lambda (sf) (/ (log (/ (+ (dominant-frequency sf)
			       (centroid sf))
			    2))
		    12000))
   :f2 #'(lambda (sf) (* (expt (transient sf) 0.7)
		    0.6))
   :f3 #'(lambda (sf) (- 1 (expt (smoothness sf)
			    0.5)))))

;; ** hats

(create-sfl :hats)

(probe-analyse-store :hats
  (folder-to-stored-file-list
   (gethash :hats *soundfiles*)
   (format nil "~a~a" *bleeps-src-dir* "samples/hats/")
   :analyse t
   :auto-map nil
   :auto-scale-mapping nil
   :remap nil
   ;;:fft-size 4096
   :f1 #'(lambda (sf) (/ (log (/ (+ (dominant-frequency sf)
			       (centroid sf))
			    2))
		    12000))
   :f2 #'(lambda (sf) (* (expt (transient sf) 0.7)
		    0.6))
   :f3 #'(lambda (sf) (- 1 (expt (smoothness sf)
			    0.5)))))

;; ** pads

(create-sfl :pads)

(probe-analyse-store :pads
  (folder-to-stored-file-list
   (gethash :pads *soundfiles*)
   (format nil "~a~a" *bleeps-src-dir* "samples/pads/")
   :analyse t
   :auto-map nil
   :auto-scale-mapping nil
   :remap nil
   ;;:fft-size 4096
   :f1 #'(lambda (sf) (/ (log (/ (+ (dominant-frequency sf)
			       (centroid sf))
			    2))
		    12000))
   :f2 #'(lambda (sf) (* (expt (transient sf) 0.7)
		    0.6))
   :f3 #'(lambda (sf) (- 1 (expt (smoothness sf)
			    0.5)))))


;; ** recov

(create-sfl :recov)

(setf (gethash :recov *soundfiles*)
      (load-from-file "/E/recov/store-F0899456.txt"))

(create-sfl :recov2)

(setf (gethash :recov2 *soundfiles*)
      (load-from-file "/E/recov/store-F12402176.txt"))

(create-sfl :recov3)

(setf (gethash :recov3 *soundfiles*)
      (load-from-file "/E/recov/store-F12508040.txt"))

(create-sfl :recov4)

(setf (gethash :recov4 *soundfiles*)
      (load-from-file "/E/recov/store-F14068992.txt"))

(create-sfl :recov5)

(setf (gethash :recov5 *soundfiles*)
      (load-from-file "/E/recov/store-F17415896.txt"))

(create-sfl :recov6)

(setf (gethash :recov6 *soundfiles*)
      (load-from-file "/E/recov/store-F17820512.txt"))

(create-sfl :recov7)

(setf (gethash :recov7 *soundfiles*)
      (load-from-file "/E/recov/store-F19562768.txt"))

(create-sfl :recov8)

(setf (gethash :recov8 *soundfiles*)
      (load-from-file "/E/recov/store-F20566936.txt"))

(create-sfl :recov9)

(setf (gethash :recov9 *soundfiles*)
      (load-from-file "/E/recov/store-F120043520.txt"))

(create-sfl :recov10)

(setf (gethash :recov10 *soundfiles*)
      (load-from-file "/E/recov/store-F169254232.txt"))

;; EOF soundfiles.lsp
