(define (make-interval a b) (cons a b))

(define (lower-bound interval) (car interval))

(define (upper-bound interval) (cdr interval))

(define (make-center-width c w) 
    (make-interval (- c w) (+ c w)))

(define (center interval)
    (/ (+ (lower-bound interval) (upper-bound interval)) 2))

(define (width interval)
    (/ (- (upper-bound interval) (lower-bound interval)) 2))

(define (percent interval) 
    (define width-value (width interval))
    (* (/ width-value (center interval)) 100))

(define (make-center-percent center uncertainty)
    (define width (* (/ uncertainty 100) center))
    (make-center-width center width))

(define interval (make-center-percent 100 10))

(newline)
(display "Center: ")
(display (center interval)) ; 100

(newline)
(display "Width: ")
(display (width interval)) ; 10

(newline)
(display "Percent uncertainty: ") ; 10
(display (percent interval))
