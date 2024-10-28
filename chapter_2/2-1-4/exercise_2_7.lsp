(define (make-interval a b) (cons a b))

(define (lower-bound interval) (car interval))

(define (upper-bound interval) (cdr interval))

(define interval (make-interval 4 8))

(newline)
(display (lower-bound interval)) ; 4
(newline)
(display (upper-bound interval)) ; 8
