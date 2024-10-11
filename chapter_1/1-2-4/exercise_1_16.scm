#|
recursive way:

(define (even? n)
    (= (remainder n 2) 0)
)

(define (fast-expt b n) 
    (cond ((= n 0) 1)
        ((even? n) (square (fast-expt b (/ n 2)))) 
        (else (* b (fast-expt b (- n 1))))
    )
)
|#

(define (even? n)
    (= (remainder n 2) 0)
)

(define (expt base degree)
    (expt-iter base degree 1)
)

(define (expt-iter base counter result)
    (cond ((= counter 0) result)
        ((even? counter) (expt-iter (* base base) (/ counter 2) result))
        (else (expt-iter base (- counter 1) (* base result)))
    )
)

(newline)
(display (expt 4 2))
(newline)