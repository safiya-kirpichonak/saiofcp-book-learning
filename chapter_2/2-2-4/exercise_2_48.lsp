(define (make-vect x y) (cons x y))

(define (xcor-vect v) (car v))

(define (ycor-vect v) (cdr v))

(define (add-vect v1 v2) 
  (make-vect 
    (+ (xcor-vect v1) (xcor-vect v2)) 
    (+ (ycor-vect v1) (ycor-vect v2))))

(define (sub-vect v1 v2)
  (make-vect 
    (- (xcor-vect v1) (xcor-vect v2)) 
    (- (ycor-vect v1) (ycor-vect v2))))

(define (scale-vect v n)
  (make-vect 
    (* (xcor-vect v) n) 
    (* (ycor-vect v) n)))

(define (make-segment start-segment end-segment)
    (cons start-segment end-segment))

(define (start-segment segment) (car segment))

(define (end-segment segment) (cdr segment))