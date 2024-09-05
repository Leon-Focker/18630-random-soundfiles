;; * sub

(in-package :ly)

;; ** Sub 1

(let* ((start-time 200)
       (end-time 240)		    
       (sounds (data (gethash :recov *soundfiles*))))
  (multiple-value-bind (starts durs hit-list rthm-list)
      (struct-section *struct* start-time end-time)
    (declare (ignore durs))
    
    (wsound "sub/sub_1"
      (fplay start-time end-time
;;;;  rhythm 
	(duration .5)
	(rhythm (apply #'section-val time
		       (special-interleave starts rthm-list)))
	(hits (apply #'section-val time
		     (special-interleave starts hit-list)))
;;;;  blackbox
	(accent (/ (get-beat-prox (/ (- time start-time) hits rhythm) 4) 4))
	(sound (nth-mod 38 sounds))
	(amp (if (> accent .7) (- 1 accent) 0))
	(amp-env '(0 0  1 1  99 1  100 0))
	(degree 45)))))

;; ** Sub 2
(let* ((start-time 240)
       (end-time 272)	    
       (sounds (data (gethash :recov *soundfiles*))))
  (multiple-value-bind (starts durs hit-list rthm-list)
      (struct-section *struct* start-time end-time)
    (declare (ignore durs))
    
    (wsound "sub/sub_2"
      (fplay start-time end-time
;;;;  rhythm 
	(duration .5)
	(rhythm (apply #'section-val time
		       (special-interleave starts rthm-list 2)))
	(hits (apply #'section-val time
		     (special-interleave starts hit-list 1)))
;;;;  blackbox
	(accent (/ (get-beat-prox (/ (- time start-time) hits rhythm) 4) 4))
	(sound (nth-mod 38 sounds))
	(amp (if (> accent .7) (- 1 accent) 0))
	(amp-env '(0 0  1 1  99 1  100 0))
	(degree 45)))))

;; ** Sub 3

(let* ((start-time 272)
       (end-time 322.5)	    
       (sounds (data (gethash :recov *soundfiles*))))
  (multiple-value-bind (starts durs hit-list rthm-list)
      (struct-section *struct* start-time end-time)
    (declare (ignore durs))
    
    (wsound "sub/sub_3"
      (fplay start-time end-time
;;;;  rhythm 
	(duration (dry-wet 1 0.5 line))
	(rhythm (apply #'section-val time
		       (special-interleave starts rthm-list 0)))
	(hits (apply #'section-val time  
		     (special-interleave starts hit-list 3)))
;;;;  blackbox
	(accent (/ (get-beat-prox (/ (- time start-time) hits rhythm) 4) 4))
	(sound (nth-mod 38 sounds))
	(amp (if (> accent .5) (- 1 accent) 0))
	(amp-env '(0 0  1 1  99 1  100 0))
	(degree 45)))))


;; EOF sub.lsp
