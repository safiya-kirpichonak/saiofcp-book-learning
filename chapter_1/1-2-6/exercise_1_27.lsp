(define (do-exponentiation-modulo number exponent modulo)
  (cond
    ((= exponent 0) 1)
    ((even? exponent)
      (let ((half-exponent (do-exponentiation-modulo number (/ exponent 2) modulo)))
       (remainder (* half-exponent half-exponent) modulo)
      )
    )
    (else
      (let ((even-exponent (do-exponentiation-modulo number (- exponent 1) modulo)))
       (remainder (* number even-exponent) modulo)
      )
    )
  )
)

(define (do-fermat-test n random-number)
  (cond 
    ((= (- n random-number) 6) 
     (begin
       (newline)
       (display ".....")
       (newline)
      )
    )
    (else 
     (begin
       (display random-number)
       (display " : ")
       (display (= (do-exponentiation-modulo random-number n n) random-number))
       (newline)
       (do-fermat-test n (- random-number 1))
     )
    )
  )
)

(define (check-carmichael-number n)
  (do-fermat-test n (- n 1))
)

(check-carmichael-number 561)
(check-carmichael-number 562)  ; Not Carmichael number and not prime number
(check-carmichael-number 1019) ; Not Carmichael number, but prime number
(check-carmichael-number 1105)
(check-carmichael-number 1729)
(check-carmichael-number 2465)
(check-carmichael-number 2821)
(check-carmichael-number 6601)