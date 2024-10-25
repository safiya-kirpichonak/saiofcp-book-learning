#|
p2 - (10,0)     p3 - (10,5)
+------+
|      |
|      |
|      |
|      |
|      |
+------+
p1 - (0,0)      p4 - (0,5)
|#

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

(define (get-length segment)
  (define x1 (x-point (start-segment segment)))
  (define y1 (y-point (start-segment segment)))
  (define x2 (x-point (end-segment segment)))
  (define y2 (y-point (end-segment segment)))
  (sqrt (+ (expt (- x2 x1) 2) (expt (- y2 y1) 2))))

(define (make-rectangle-1 p1 p2 p3 p4) (list p1 p2 p3 p4))

(define (make-rectangle-2 p1 p3)
    (define p2 (make-point (x-point p1) (y-point p3)))
    (define p4 (make-point (x-point p3) (y-point p1)))
    (list p1 p2 p3 p4))

(define (perimeter rectangle) 
    (define side-1 (make-segment (list-ref rectangle 0) (list-ref rectangle 1)))
    (define side-2 (make-segment (list-ref rectangle 1) (list-ref rectangle 2)))
    (define side-length-1 (get-length side-1))
    (define side-length-2 (get-length side-2))
    (+ (* side-length-1 2) (* side-length-2 2)))

(define (area rectangle) 
    (define side-1 (make-segment (list-ref rectangle 0) (list-ref rectangle 1)))
    (define side-2 (make-segment (list-ref rectangle 1) (list-ref rectangle 2)))
    (define side-length-1 (get-length side-1))
    (define side-length-2 (get-length side-2))
    (* side-length-1 side-length-2))

(define p1 (make-point 0 0))
(define p2 (make-point 10 0))
(define p3 (make-point 10 5))
(define p4 (make-point 0 5))

; test get-length
(define s1 (make-segment p1 p2))
(newline)
(display (get-length s1)) ; 10

; test perimeter 1
(define rectangle-1 (make-rectangle-1 p1 p2 p3 p4))
(newline)
(display (perimeter rectangle-1)) ; 30

; test area 1
(newline)
(display (area rectangle-1)) ; 50

; test perimeter 2
(define rectangle-2 (make-rectangle-2 p1 p3))
(newline)
(display (perimeter rectangle-2)) ; 30

; test area 2
(newline)
(display (area rectangle-2)) ; 50