(define (=zero? term-coefficient) (= term-coefficient 0))

(define (make-term order coeff) (list order coeff)) 

(define (order term) (car term))

(define (coeff term) (cadr term))

(define term-1 (make-term 0 0))
(define term-2 (make-term 0 1))

(newline) (display (=zero? (coeff term-1))) ; #t
(newline) (display (=zero? (coeff term-2))) ; #f