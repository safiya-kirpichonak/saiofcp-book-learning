#|
1000000007 *** .45
1000000009 *** .42
1000000021 *** .41
1000000033 *** .41
1000000087 *** .44
1000000093 *** .43
1000000097 *** .41

1000000000039 *** .6
1000000000061 *** .62
1000000000063 *** .61
1000000000091 *** .61

So Fermat's test has Θ(log n) speed, so if the n = 1.000 and n = 1.000.000 the 
difference will be like:

log2(1000) = 9.97
log2(1000000) = 19.93

So the difference should be in twice more, but I didn't see the difference...

TODO
|#

(define (expmod base exp mod)
  (cond ((= exp 0) 1)
        ((even? exp) 
         (let ((half-exp (expmod base (/ exp 2) mod)))
           (modulo (* half-exp half-exp) mod)))
        (else (modulo (* base (expmod base (- exp 1) mod)) mod))))

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) #t)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else #f)))

(define (prime? n)
    (fast-prime? n 10000)
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
(prepare-period 1000000000000 1000000000100)
