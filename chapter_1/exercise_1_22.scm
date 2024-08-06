#|
- first 3 after 1000:
1009
1013
1019

- first 3 after 10000:
10007
10009
10037

- first 3 after 100000:
100003
100019
100043
|#

(define (smallest-divisor n) 
    (find-divisor n 2)
)

(define (find-divisor n test-divisor) 
    (cond ((> (square test-divisor) n) n)
          ((divides? test-divisor n) test-divisor) 
          (else (find-divisor n (+ test-divisor 1)))
    )
)

(define (divides? a b) 
    (= (remainder b a) 0)
)

(define (prime? n)
    (= n (smallest-divisor n))
)

(define (timed-prime-test n)
    (newline)
    (display n)
    (start-prime-test n (runtime))
)

(define (start-prime-test n start-time)
    (if (prime? n)
        (report-prime 
            (- (runtime) start-time)
        )
        (display "")
    )
)

(define (report-prime elapsed-time)
    (display " *** ")
    (display elapsed-time)
    (newline)
)

(define (prepare-period start end)
  (if (or (> start end) (< start 0) (< end 0))
      (error "Invalid input: start must be less than end and both must be non-negative"))
  (if (even? start)
      (search-for-primes (+ start 1) end)
      (search-for-primes start end)))

(define (search-for-primes start end)
    (if (> start end)
            start
            (begin
                (timed-prime-test start)
                (search-for-primes (+ start 2) end)
            )
    )
)

(prepare-period 100000 100100)
(newline)
