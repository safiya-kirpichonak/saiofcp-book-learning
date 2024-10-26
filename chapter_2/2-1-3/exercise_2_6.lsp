(define zero (lambda (f) (lambda (x) x)))

(define one (lambda (f) (lambda (x) (f x))))

(define two (lambda (f) (lambda (x) (f (f x)))))

(define (add-1 n) (lambda (f) (lambda (x) (f ((n f) x)))))

(define (sum a b) (lambda (f) (lambda (x) ((a f) ((b f) x)))))

(define inc (lambda (x) (+ x 1)))

(newline)
(display ((one inc) 0)) ; 1
(newline)
(display ((two inc) 0)) ; 2
(newline)
(display (((add-1 one) inc) 0)) ; 2
(newline)
(display (((sum one two) inc) 0)) ; 3