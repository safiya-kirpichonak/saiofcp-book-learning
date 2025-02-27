(define (make-point x y) (cons x y))

(define (x-point point) (car point))

(define (y-point point) (cdr point))

(define (make-segment point1 point2) 
    (cons point1 point2))

(define (start-segment segment)
   (car segment))

(define (end-segment segment)
   (cdr segment))

(define (midpoint-segment segment)
    (make-point 
        (/ (+ (x-point (start-segment segment)) (x-point (end-segment segment))) 2)
        (/ (+ (y-point (start-segment segment)) (y-point (end-segment segment))) 2)))

(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")"))

(define p1 (make-point 0 0))
(define p2 (make-point 0 10))
(print-point p1) ; (0,0)
(print-point p2) ; (0,10)
(define segment (make-segment p1 p2))
(define p3 (midpoint-segment segment))
(print-point p3) ; (0,5)