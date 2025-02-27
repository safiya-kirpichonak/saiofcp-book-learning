(define (double a)
  (+ a a))

(define (halve a)
  (/ a 2))

(define (even? n)
  (= (remainder n 2) 0))

(define (fast-multiply base degree)
    (fast-multiply-iter base degree 0)
)

(define (fast-multiply-iter base counter result)
    (cond ((= counter 0) result)
        ((even? counter) (fast-multiply-iter (double base) (/ counter 2) result))
        (else (fast-multiply-iter base (- counter 1) (+ base result)))
    )
)

(newline)
(display (fast-multiply 2 3))
(newline)
(display (fast-multiply 2 4))
(newline)