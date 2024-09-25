;; * midi

(in-package :ly)

;; *** origin for htdycwalp bass sample
;;; just a lot of ascending and descending notes with the right start-times
;;; to feed slicex and fake the bass ending of Htdycwalp.
(lists-to-midi (loop for i from 50 to 150 collect (mirrors i 50 80))
	       (ml 1/9 100)
	       (get-start-times (ml 2/9 100))
	       :file (format nil "~a~a" *bleeps-src-dir* "midi/Htdycwalp_bass.mid"))

;; *** accent
;;; first bleep, this midi file isn't used...
(lists-to-midi '(e5)
	       '(.25)
	       (get-start-times (ml (* 24 4/9) 10))
	       :file (format nil "~a~a" *bleeps-src-dir* "midi/bleep1.mid"))

(lists-to-midi '(e5 d6)
	       '(.25)
	       (get-start-times (morph-patterns '((16/9 8/9 8/3) (4/9 2/9 2/3)) (* 240 4/9)
						nil nil nil nil (fibonacci-transition 100)))
	       :file (format nil "~a~a" *bleeps-src-dir* "midi/accent2.mid"))

;; ** light

;; *** polyphonic-to-linear-triggers
(defun polyphonic-to-linear-triggers (input-midi-file black-note new-notes)
  (let* ((midi-data (midi-to-list input-midi-file))
	 (sorted-midi-data '())
	 (start-and-end-times '())
	 (known-notes '())
	 (result '()))
    ;; sort input midi data by start-time
    (setf sorted-midi-data
	  (sort midi-data #'(lambda (x y) (< (car x) (car y)))))
    ;; collect start and end-times of all notes
    (setf start-and-end-times
	  (sort (remove-duplicates
		 (loop for note in sorted-midi-data
		       collect (first note)
		       collect (sixth note)))
		#'<))
    ;; go through all the times and check which notes are playing
    ;; then identify the group
    ;; TODO find-notes-with-cursor gets sorted list, does not need to search through all
    (loop for time in start-and-end-times and end in (cdr start-and-end-times)
	  for duration = (- end time)
	  ;; offset by 0.001 so thath the note ending here is not detected
	  for playing = (find-notes-with-cursor (+ time 0.001) sorted-midi-data)
	  ;; first case: no note playing, insert black-note
	  ;; second case: one note playing
	  ;; third case: multiple notes playing
	  do (cond ((not playing) (push (list time black-note duration) result))
		   ((not (cdr playing))
		    (push (list time (cadar playing) duration) result))
		   (t (let* ((all-notes (sort (loop for i in playing collect (cadr i)) #'<)))
			(unless (find all-notes known-notes :test #'equal)
			  (push all-notes known-notes))
			(let* ((note-index (1- (length
						(member all-notes known-notes
							:test #'equal))))
			       (note (cond ((> note-index (length new-notes))
					    (error "polyphonic-to-linear-triggers did something that shouldn't ever happen"))
					   ((= note-index (length new-notes))
					    (setf new-notes (append new-notes (list (1+ (car (last new-notes))))))
					    (nth note-index new-notes))
					   (t (nth note-index new-notes)))))
			  (push (list time note duration) result))))))
    ;; reverse result and make midi file
    (loop for note in (reverse result)
	  collect (first note) into starts
	  collect (second note) into notes
	  collect (third note) into durs
	  finally (lists-to-midi notes durs starts
				 :file (format nil "~a~a" input-midi-file "-linear.mid")))))

(lists-to-midi '(e4 e4 e5) '(.75) '(0 1 .5)
	       :file (format nil "~a~a" *bleeps-src-dir* "midi/test.mid"))


;; EOF midi.lsp
