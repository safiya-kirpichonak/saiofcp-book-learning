(define (make-interval a b) (cons a b))

(define (lower-bound interval) (car interval))

(define (upper-bound interval) (cdr interval))

(define (add-interval x y)
    (make-interval (+ (lower-bound x) (lower-bound y))
                   (+ (upper-bound x) (upper-bound y))))

(define (mul-interval x y)
    (let ((p1 (* (lower-bound x) (lower-bound y)))
          (p2 (* (lower-bound x) (upper-bound y))) 
          (p3 (* (upper-bound x) (lower-bound y))) 
          (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4) (max p1 p2 p3 p4))))

(define (find-radius-interval interval)
    (/ (- (upper-bound interval) (lower-bound interval)) 2))

(define interval1 (make-interval 1 3))
(define interval2 (make-interval 4 6))

(define sum-result (add-interval interval1 interval2))
(define mul-result (mul-interval interval1 interval2))

(define sum-result-radius (find-radius-interval sum-result))
(define mul-result-radius (find-radius-interval mul-result))

(define interval1-radius (find-radius-interval interval1))
(define interval2-radius (find-radius-interval interval2))

(newline)
(display sum-result-radius) ; 2
(newline)
(display (+ interval1-radius interval2-radius)) ; 2
(newline)
(display mul-result-radius) ; 7
(newline)
(display (* interval1-radius interval2-radius)) ; 1
