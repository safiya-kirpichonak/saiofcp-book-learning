
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
(prepare-period 1000000000 1000000100)
(newline)
(prepare-period 10000000000 10000000100)
(newline)
(prepare-period 100000000000 100000000100)
(newline)
(prepare-period 1000000000000 1000000000100)
