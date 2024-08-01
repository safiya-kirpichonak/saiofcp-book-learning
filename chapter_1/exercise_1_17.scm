#|
(define (multiply a b)
  (if (= b 0)
    0
    (+ a (multiply a (- b 1)))))
|#

(define (double a)
  (+ a a))

(define (halve a)
  (/ a 2))

(define (even? n)
  (= (remainder n 2) 0))

(define (fast-multiply a b)
  (cond ((= b 0) 0)
        ((even? b) (double (fast-multiply a (halve b))))
        (else (+ a (fast-multiply a (- b 1))))))

(newline)
(display (fast-multiply 2 3))
(newline)
