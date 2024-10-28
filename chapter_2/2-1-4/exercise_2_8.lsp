(define (make-interval a b) (cons a b))

(define (lower-bound interval) (car interval))

(define (upper-bound interval) (cdr interval))

(define (add-interval x y)
    (make-interval (+ (lower-bound x) (lower-bound y))
                   (+ (upper-bound x) (upper-bound y))))

(define (sub-interval x y)
    (make-interval (- (lower-bound x) (lower-bound y))
                   (- (upper-bound x) (upper-bound y))))

(define interval1 (make-interval 1 3))
(define interval2 (make-interval 4 6))

(define sum-result (add-interval interval1 interval2))
(define sub-result (sub-interval interval1 interval2))

(newline)
(display (lower-bound sum-result)) ; 5
(newline)
(display (upper-bound sum-result)) ; 9
(newline)
(display (lower-bound sub-result)) ; -3
(newline)
(display (upper-bound sub-result)) ; -3
