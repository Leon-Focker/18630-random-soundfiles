;; * Soundfile-helpers
;;; a few functions and macros to avoid boilerplate code within the soundfiles.lsp file

(in-package :ly)

(defparameter *soundfiles* (make-hash-table))

;; ** candy
;; = syntactic sugar

(defun name-txt (name)
  (if (keywordp name)
      (intern (format nil "~a~a" name '-txt) :keyword)
      (intern (format nil "~a~a" name '-txt))))

;; *** create-sfl
;;; create two key-value pairs and store them in *soundfiles*:
;;;  name     - sfl
;;;  name-txt - path to the .txt file for #'store-in-text-file
(defmacro create-sfl (name)
  `(progn
     (setf (gethash ,name *soundfiles*)
	   (make-stored-file-list ,name nil))
     (setf (gethash (name-txt ,name) *soundfiles*)
	   (format nil "~a~a~a" *bleeps-src-dir*
		   (string-downcase (format nil "~a" ,name))
		   ".txt"))))

;; *** probe-analyse-store
;;; Probe wheter we need to re-analyse the soundfiles (either because the
;;; name-txt file does not exist or *re-analyse-soundfiles* is set to T
;;; If re-analysis is needed, evaluate body and store result in .txt file.
;;; Else load from .txt file.
(defmacro probe-analyse-store (name &body body)
  `(if (or *re-analyse-soundfiles*
	   (not (probe-file (gethash (name-txt ,name) *soundfiles*))))
       ;; (re-)analyse and store in .txt file
       (progn
	 ,@body
	 (store-in-text-file (gethash ,name *soundfiles*)
			     (gethash (name-txt ,name) *soundfiles*)))
       ;; get from .txt file
       (setf (gethash ,name *soundfiles*)
	     (load-from-file (gethash (name-txt ,name) *soundfiles*)))))

;; EOF soundfile-helpers.lsp
