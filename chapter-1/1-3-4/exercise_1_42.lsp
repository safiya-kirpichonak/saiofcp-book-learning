(define (compose f g)
    (lambda (x) (f (g x))))

(define (square x) (* x x))
(define (inc x) (+ x 1))

(newline)
(display ((compose square inc) 6)) ; 49
