;; * Soundfiles
;;; collect and analyse soundfiles, store them as ly::stored-file-list objects
;;; within a hashtable. This table can be accessed with the global variable
;;; *soundfiles*

(in-package :ly)

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

;; ** recov

(create-sfl :recov)

(setf (gethash :recov *soundfiles*)
      (load-from-file "/E/recov/store-F0899456.txt"))

(create-sfl :recov2)

(setf (gethash :recov2 *soundfiles*)
      (load-from-file "/E/recov/store-F12402176.txt"))

;; EOF soundfiles.lsp
