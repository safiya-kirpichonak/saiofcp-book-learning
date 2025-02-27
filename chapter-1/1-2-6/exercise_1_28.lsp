#|
Let's take number = 7 (we will test it for primally using this algorithm):

1. If an even number is provided, return false immediately, because all 
even numbers are composite, except 2, which is prime.

2. Find number of divisions and remainder:
  1. Compute number(7) - 1 = 6.
  2. Keep dividing number(7) - 1 by 2 until you get an odd number and
  calculate divisions:
  6 / 2 = 3 => remainder = 3, divisions = 1.

3. Repeat this algorithm x times, let's say 100 times. If any iteration returns false, the number is composite:
  1. Pick a random number (randomNumber) from the range 2 to number - 2 (exclusive).
  2. Compute randomNumber ^ remainder mod number. If the result is 1 or number - 1, the number might be prime, and 
  we move to the next randomNumber.
  3. Otherwise, compute randomNumber ^ ((2 ^ exponentCoefficient) * remainder) mod number, where exponentCoefficient 
  goes from 0 to divisions - 1 inclusive. If any result equals number - 1, the number might be prime, so return true, 
  otherwise return false.

Result:
1001: #f
1002: #f
1003: #f
1004: #f
1005: #f
1009: #t
1013: #t
1019: #t
1021: #t
1031: #t
|#

(define (is-even? number)
  (= (remainder number 2) 0))

(define (get-random-between start end)
  (+ start (random (- end start))))

(define (do-exponentiation-modulo number exponent modulo)
  (cond
    ((= exponent 0) 1)
    ((is-even? exponent)
     (let ((half-exponent (do-exponentiation-modulo number (/ exponent 2) modulo)))
       (remainder (* half-exponent half-exponent) modulo)))
    (else
     (let ((even-exponent (do-exponentiation-modulo number (- exponent 1) modulo)))
       (remainder (* number even-exponent) modulo)))))

(define (do-miller-rabin-test number remainder divisions)
  (let ((random-number (get-random-between 2 (- number 2))))
    (let ((first-check (do-exponentiation-modulo random-number remainder number)))
      (if (or (= first-check (- number 1)) (= first-check 1))
          #t
        (check-exponent random-number remainder number divisions 0)))))

(define (check-exponent random-number remainder number divisions exponent-coefficient)
  (if (> exponent-coefficient divisions)
      #f
    (let* ((new-exponent (* (expt 2 exponent-coefficient) remainder))
           (second-check (do-exponentiation-modulo random-number new-exponent number)))
      (if (= second-check (- number 1))
          #t
        (check-exponent random-number remainder number divisions (+ exponent-coefficient 1))))))

(define (fast-prime number times remainder divisions)
  (if (= times 0)
      #t
    (if (do-miller-rabin-test number remainder divisions)
        (fast-prime number (- times 1) remainder divisions)
      #f)))

(define (get-division-information is-division remainder divisions)
  (if (not (is-even? remainder))
      (if is-division
          divisions
        remainder)
    (get-division-information is-division (/ remainder 2) (+ divisions 1))))

(define (is-prime number)
  (define TIMES 100)
  (cond
    ((= number 2) #t)
    ((is-even? number) #f)
    (else
     (let* ((divisions (get-division-information #t (- number 1) 0))
            (remainder (get-division-information #f (- number 1) 0)))
       (fast-prime number TIMES remainder divisions)))))

(newline)
(display "1001: ") (display (is-prime 1001)) (newline)
(display "1002: ") (display (is-prime 1002)) (newline)
(display "1003: ") (display (is-prime 1003)) (newline)
(display "1004: ") (display (is-prime 1004)) (newline)
(display "1005: ") (display (is-prime 1005)) (newline)

(display "1009: ") (display (is-prime 1009)) (newline) ; prime number
(display "1013: ") (display (is-prime 1013)) (newline) ; prime number
(display "1019: ") (display (is-prime 1019)) (newline) ; prime number
(display "1021: ") (display (is-prime 1021)) (newline) ; prime number
(display "1031: ") (display (is-prime 1031)) (newline) ; prime number
