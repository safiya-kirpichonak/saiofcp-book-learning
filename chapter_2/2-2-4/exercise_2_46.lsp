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

(define vector1 (make-vect 1 6))
(define vector2 (make-vect 2 5))

(newline) (display (xcor-vect vector1)) ; 1
(newline) (display (ycor-vect vector1)) ; 6

(newline) (display (add-vect vector1 vector2)) ; (3 . 11)
(newline) (display (sub-vect vector1 vector2)) ; (-1 . 1)
(newline) (display (scale-vect vector1 3)) ; (3 . 18)
