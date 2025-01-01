(define (make-from-mag-ang r a)
  (define (dispatch operation)
    (cond ((eq? operation 'real-part) (* r (cos a)))
          ((eq? operation 'imag-part) (* r (sin a)))
          ((eq? operation 'magnitude) r)
          ((eq? operation 'angle) a)
          (else (error "Неизвестная операция. -- MAKE-FROM-MAG-ANG" operation))))
  dispatch)

(define z (make-from-mag-ang 5 (/ 3.14 4))) ; module = 5, angle = 45
(newline) (display (z 'real-part)) ; 3.5369413458359986
(newline) (display (z 'imag-part)) ; 3.53412590552683
(newline) (display (z 'magnitude)) ; 5
(newline) (display (z 'angle)) ; 0.785