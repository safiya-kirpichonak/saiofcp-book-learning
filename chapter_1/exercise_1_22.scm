#|
- first 3 after 1000:
1009 *** 0.
1013 *** 0.
1019 *** 0.

- first 3 after 10000:
10007 *** 0.
10009 *** 0.
10037 *** 0.

- first 3 after 100000:
100003 *** 0.
100019 *** 0.
100043 *** 0.

- first 3 after 1000000:
1000003 *** 0.
1000033 *** 0.
1000037 *** 0.

For my laptop this calculations are too fast, so I don't see the difference and runtime = 0 every time.
That is why I tried bigger numbers:

1.000.000.000:
1000000007 *** 0.02
1000000009 *** 0.03
1000000021 *** 0.03

10.000.000.000:
10000000019 *** 0.08
10000000033 *** 0.08
10000000061 *** 0.08

100.000.000.000:
100000000003 *** 0.27
100000000019 *** 0.26
100000000057 *** 0.26

1.000.000.000.000:
1000000000039 *** 0.76
1000000000061 *** 0.78
1000000000063 *** 0.76

1. Should checking the primality of numbers near 10.000.000.000 take √10 times longer than for 
numbers near 1.000.000.000? Do your measurements confirm this?

√10 is like 3.1, So yes the difference between (0.02 || 0.03) and (0.08) like 3 or 4. The next 
references are also in range between 3 and 4 time bigger.

2. Do the data for 100.000.000.000 and 1.000.000.000.000 support the √n prediction well?

Yes, it is fine, but much slower than the initial calculations. I noticed that the difference 
between the next pair of numbers will take about 3 times longer, so I suppose this algorithm can be improved.

3. Is your result consistent with the assumption that programs on your machine take time proportional 
to the number of steps?

Yes, the program takes proportional number of time when I increase number.
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
