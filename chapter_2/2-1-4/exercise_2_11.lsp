#|
The main idea: if we have an interval x = [a, b] and y = [c, d], then the product of these intervals 
x * y should cover all products of the boundary values: a * c, a * d, b * c, and b * d. The lower
and upper bounds of the result are the minimum and maximum values among these products. However, 
depending on the signs of a, b, c, and d, some of these products may be unnecessary and can 
be excluded, allowing us to simplify the calculations.
|#

(define (make-interval a b) (cons a b))

(define (lower-bound interval) (car interval))

(define (upper-bound interval) (cdr interval))

; 0 - positive interval a >= 0 and b >= 0
; 1 - negative interval a <= 0 and b <= 0
; 2 - intersect zero a <= 0 and b <= 0

(define (find-interval-type interval)
      (define a (lower-bound interval))
      (define b (upper-bound interval))
      (cond 
            ((and (>= a 0) (>= b 0)) 0)
            ((and (<= a 0) (<= b 0)) 1)
            ((and (<= a 0) (>= b 0)) 2)
            (else (error "Incorrect interval!"))))

(define (mul-interval x y)
  (define type-x (find-interval-type x))
  (define type-y (find-interval-type y))
  (define a (lower-bound x))
  (define b (upper-bound x))
  (define c (lower-bound y))
  (define d (upper-bound y))
  (cond 
    ((and (= type-x 0) (= type-y 0)) (make-interval (* a c) (* b d)))
    ((and (= type-x 0) (= type-y 1)) (make-interval (* b c) (* a d)))
    ((and (= type-x 0) (= type-y 2)) (make-interval (* b c) (* b d)))
    ((and (= type-x 2) (= type-y 0)) (make-interval (* a d) (* b d)))
    ((and (= type-x 2) (= type-y 2)) (make-interval (min (* a d) (* b c)) (max (* a c) (* a d) (* b c) (* b d))))
    ((and (= type-x 2) (= type-y 1)) (make-interval (* b c) (* a c)))
    ((and (= type-x 1) (= type-y 0)) (make-interval (* a d) (* b d)))
    ((and (= type-x 1) (= type-y 2)) (make-interval (* a d) (* a c)))
    ((and (= type-x 1) (= type-y 1)) (make-interval (* b d) (* a c)))
    (else (error "Incorrect combination!"))))

(define (display-interval interval)
      (newline)
      (display "(")
      (display (lower-bound interval))
      (display " ; ")
      (display (upper-bound interval))
      (display ")"))

(define interval1 (make-interval 1 2))
(define interval2 (make-interval -2 -1))
(define interval3 (make-interval -1 1))

(newline)
(display (find-interval-type interval1)) ; 0
(newline)
(display (find-interval-type interval2)) ; 1
(newline)
(display (find-interval-type interval3)) ; 2

(display-interval (mul-interval interval1 interval1)) ; (1 ; 4)
(display-interval (mul-interval interval1 interval2)) ; (-4 ; -1)
(display-interval (mul-interval interval2 interval3)) ; (-2 ; 2)
