(define (make-interval a b) (cons a b))

(define (lower-bound interval) (car interval))

(define (upper-bound interval) (cdr interval))

(define (mul-interval x y)
    (let ((p1 (* (lower-bound x) (lower-bound y)))
          (p2 (* (lower-bound x) (upper-bound y))) 
          (p3 (* (upper-bound x) (lower-bound y))) 
          (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4) (max p1 p2 p3 p4))))

(define (div-interval x y)
    (if (or (= (upper-bound y) 0) (= (lower-bound y) 0))
            (error "This operation cannot be applied because the interval contains 0.")
            (mul-interval x (make-interval (/ 1.0 (upper-bound y)) (/ 1.0 (lower-bound y))))))

(define interval1 (make-interval 1 1))
(define interval2 (make-interval 5 5))
(define interval3 (make-interval 0 5))

(define result (div-interval interval1 interval2))

(newline)
(display (lower-bound result)) ; 0.2
(newline)
(display (upper-bound result)) ; 0.2

(define result (div-interval interval1 interval3)) 
; error: ";This operation cannot be applied because the interval contains 0."
