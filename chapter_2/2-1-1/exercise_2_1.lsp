(define (abs x)
  (if (>= x 0) x (- x)))

(define (make-rat n d) 
  (if (> (* n d) 0) 
    (cons (abs n) (abs d))
    (cons (* (abs n) -1) (abs d))))

(define (numer x) (car x))

(define (denom x) (cdr x))

(define (print-rat x) 
    (newline)
    (display (numer x)) 
    (display "/") 
    (display (denom x)))

(define (add-rat x y)
  (make-rat (+ (* (numer x) (denom y))
               (* (numer y) (denom x)))
            (* (denom x) (denom y))))

(define (sub-rat x y)
  (make-rat (- (* (numer x) (denom y))
               (* (numer y) (denom x)))
            (* (denom x) (denom y))))

(define (mul-rat x y)
  (make-rat (* (numer x) (numer y))
            (* (denom x) (denom y))))

(define (div-rat x y)
  (make-rat (* (numer x) (denom y))
            (* (denom x) (numer y))))

(define (equal-rat? x y)
  (= (* (numer x) (denom y))
     (* (numer y) (denom x))))

(newline)
(display (make-rat 1 2)) ; (1 2)
(newline)
(display (make-rat -1 2)) ; (-1 2)
(newline)
(display (make-rat 1 -2)) ; (-1 2)
(newline)
(display (make-rat -1 -2)) ; (1 2)

(define one-half (make-rat -1 2)) 
(define one-third (make-rat -1 3))

(print-rat (add-rat one-half one-third)) ; -5/6
(print-rat (mul-rat one-half one-third)) ; 1/6