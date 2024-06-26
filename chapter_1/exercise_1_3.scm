(define (max_multiplicate x1 x2 x3)
  (cond ((and (> x1 x3) (> x2 x3)) (+ (* x1 x1) (* x2 x2)))
        ((and (> x1 x2) (> x3 x2)) (+ (* x1 x1) (* x3 x3)))
        (else (+ (* x2 x2) (* x3 x3)))
  )
)

;;; 13
(newline)
(display (max_multiplicate 1 2 3))
;;; 61
(newline)
(display (max_multiplicate 6 5 4))
;;; 145
(newline)
(display (max_multiplicate 8 7 9))