#|
1.000.000.000:
1000000007 *** 0.02 ::: 1000000007 *** 0.01
1000000009 *** 0.03 ::: 1000000009 *** 0.02
1000000021 *** 0.03 ::: 1000000021 *** 0.01

10.000.000.000:
10000000019 *** 0.08 ::: 10000000019 *** 0.05
10000000033 *** 0.08 ::: 10000000033 *** 0.05
10000000061 *** 0.08 ::: 10000000061 *** 0.05

100.000.000.000:
100000000003 *** 0.27 ::: 100000000003 *** 0.16
100000000019 *** 0.26 ::: 100000000019 *** 0.17
100000000057 *** 0.26 ::: 100000000057 *** 0.16

1.000.000.000.000:
1000000000039 *** 0.76 ::: 1000000000039 *** 0.48
1000000000061 *** 0.78 ::: 1000000000061 *** 0.48
1000000000063 *** 0.76 ::: 1000000000063 *** 0.48

1. Does this modification, which halves the number of verification steps, 
result in the expected twofold speedup?

No, the modification is not exactly in 2 times faster, but it much faster
than first version of algorithm.

2. If not, what is the observed speed ratio of the two algorithms, and how 
do you explain it differs from 2?

The observed speedup ratio is between 2.5 and 3.0. This deviation from the
expected twofold speedup can be attributed to additional operations or overhead
that are not evenly distributed in both versions of the algorithm.
|#

(define (smallest-divisor n) 
    (find-divisor n 2)
)

(define (next n)
    (if (= n 2)
        3
        (+ n 2)
    )
)

(define (find-divisor n test-divisor) 
    (cond ((> (square test-divisor) n) n)
          ((divides? test-divisor n) test-divisor) 
          (else (find-divisor n (next test-divisor)))
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
