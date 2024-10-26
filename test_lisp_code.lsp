(define (cons x y) 
    (define (dispatch m)
        (cond ((= m 0) x)
              ((= m 1) y)
              (else (error "Аргумент не 0 или 1 -- CONS" m)))) 
    dispatch)

(define (car z) (z 0))

(define (cdr z) (z 1))

(define pair (cons 10 20))

(newline)
(display (car pair))
(newline)
(display (cdr pair))
