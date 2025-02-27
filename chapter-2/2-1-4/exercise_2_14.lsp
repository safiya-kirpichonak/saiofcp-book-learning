; basic intervals selectors

(define (make-interval a b) (cons a b))

(define (lower-bound interval) (car interval))

(define (upper-bound interval) (cdr interval))

; operations with interval

(define (add-interval x y)
    (make-interval (+ (lower-bound x) (lower-bound y))
                   (+ (upper-bound x) (upper-bound y))))

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

(define (display-interval interval)
      (newline)
      (display "(")
      (display (lower-bound interval))
      (display " ; ")
      (display (upper-bound interval))
      (display ")"))

; 3.5 ± 0.15 - 3.5 is center, 0.15 is width
; basic center/width selectors

(define (make-interval-by-center-width c w) 
    (make-interval (- c w) (+ c w)))

(define (center interval)
    (/ (+ (lower-bound interval) (upper-bound interval)) 2))

(define (width interval)
    (/ (- (upper-bound interval) (lower-bound interval)) 2))

; tests operations

(define (par1 r1 r2)
    (div-interval (mul-interval r1 r2) 
                  (add-interval r1 r2)))

(define (par2 r1 r2)
        (let ((one (make-interval 1 1)))
            (div-interval one
                (add-interval (div-interval one r1)
                              (div-interval one r2)))))

(define interval1 (make-interval-by-center-width 3.0 0.1))
(define interval2 (make-interval-by-center-width 4.0 0.2))

(display-interval (par1 interval1 interval2)) ; (1.5095890410958903 ; 1.9432835820895527)
(display-interval (par2 interval1 interval2)) ; (1.6447761194029853 ; 1.7835616438356166)