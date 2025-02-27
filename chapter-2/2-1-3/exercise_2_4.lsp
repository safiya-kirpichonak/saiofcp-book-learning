#|
Yes, it will always work this way because the cons procedure returns a lambda that 
takes a procedure m and applies it to two arguments, and the car and cdr functions 
simply pass another lambda to this lambda, which returns either the second or the 
first argument.
|#

(define (cons x y) 
    (lambda (m) (m x y)))

(define (car z)
    (z (lambda (p q) p)))

(define (cdr z)
    (z (lambda (p q) q)))

(define pair (cons 10 20))
(newline)
(display (car pair))
(newline)
(display (cdr pair))