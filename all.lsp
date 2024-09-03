;; * all
;; todo
;;; - create sample pack, then sfl
;;;
;;; constant pulse of clicks, only their volume and timbre make the rhythm
;;; - using the layers indispensebility function and morphing the velocity lists
;;; then modulate speed of pulse and time signature synchronous with indispensibility
;;; modulate speed asynchronous to indispensibility

(ql:quickload 'layers)

(in-package :ly)

(import '(clm::with-sound
	  clm::with-mix
	  ;;clm::mix
	  clm::sound-let
	  clm::*CLM-MIX-CALLS*
	  clm::*CLM-MIX-OPTIONS*
	  clm::add-sound
	  ))

;; path to this directory
(defparameter *bleeps-src-dir* (path-from-same-dir))

;; set this to true, if you want to re-analyse all soundfiles, even if their
;; analysis data was saved to a text-file.
(defparameter *re-analyse-soundfiles* nil)

;; for the generation of spatial audio files with reaper:
(set-sc-config 'reaper-files-for-windows t)

;; ** load
(dolist (file '("soundfile-helpers.lsp"
		"soundfiles.lsp"
		"struct.lsp"
		"structure.lsp"
		"helpers.lsp"
		;;"midi.lsp"
		;;"pads.lsp"
		;;"pulse.lsp"
		;;"clicks.lsp"
		))
  (load (probe-file (format nil "~a~a" *bleeps-src-dir* file))))

;; YAY :)
(format t "~&done loading!")

;; EOF all.lsp
