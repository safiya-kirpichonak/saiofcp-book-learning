#|
This code only works with small numbers. If the numbers are large, calculating the
random number (a) raised to the power of the number checked (n) becomes very difficult
due to the size of the numbers. The version from Extension 1.24 calculates the modulus
from each intermediate result, keeping the numbers smaller and reducing system time.
In 1.25, the modulus is calculated only from the final result, so this algorithm performs
poorly with large numbers.
|#

(define (even? n)
    (= (remainder n 2) 0)
)

(define (fast-expt base degree)
    (expt-iter base degree 1)
)

(define (expt-iter base counter result)
    (cond ((= counter 0) result)
        ((even? counter) (expt-iter (* base base) (/ counter 2) result))
        (else (expt-iter base (- counter 1) (* base result)))
    )
)

(define (expmod base exp m) 
    (remainder (fast-expt base exp) m))

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) #t)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else #f)))

(define (prime? n)
    (fast-prime? n 1000)
)

(define (timed-prime-test n)
    (start-prime-test n (runtime))
)

(define (start-prime-test n start-time)
    (if (prime? n)
        (report-prime n (- (runtime) start-time))
        (display "")
    )
)

(define (round-to-precision n precision)
  (let* ((factor (expt 10 precision))
         (rounded (/ (round (* n factor)) factor)))
    (number->string rounded)
  )
)

(define (report-prime n elapsed-time)
    (display n)
    (display " *** ")
    (display (round-to-precision elapsed-time 4))
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

(newline)
(prepare-period 1000000 1000100)
(newline)
(prepare-period 1000000000 1000000100)
(newline)
(prepare-period 1000000000000 1000000000100)
(newline)
(prepare-period 1000000000000000 1000000000000100)