#|

Doesn't work, check JavaScript version. Results:

560 : true
559 : true
558 : true
557 : true
...
561 : false
560 : false
559 : false
558 : false
...
1104 : true
1103 : true
1102 : true
1101 : true
...
1728 : true
1727 : true
1726 : true
1725 : true
...
2464 : true
2463 : true
2462 : true
2461 : true
...
2820 : true
2819 : true
2818 : true
2817 : true
...
6600 : true
6599 : true
6598 : true
6597 : true
...

|#

(define (do-exponentiation-modulo number exponent modulo)
  (cond ((= exponent 0) 1)
        ((even? exponent)
         (let ((half-exponent (do-exponentiation-modulo number (/ exponent 2) modulo)))
           (modulo (* half-exponent half-exponent) modulo)))
        (else
         (let ((even-exponent (do-exponentiation-modulo number (- exponent 1) modulo)))
           (modulo (* number even-exponent) modulo)))))

(define (do-fermat-test n randomNumber)
  (if (= (- n randomNumber) 5)
      (display "...")
      (begin
        (display (list randomNumber
                       (= (do-exponentiation-modulo randomNumber n n) randomNumber)))
        (newline)
        (do-fermat-test n (- randomNumber 1)))))

(define (check-carmichael-number n)
  (do-fermat-test n (- n 1)))

(check-carmichael-number 561)
(check-carmichael-number 562) ; Not Carmichael number
(check-carmichael-number 1105)
(check-carmichael-number 1729)
(check-carmichael-number 2465)
(check-carmichael-number 2821)
(check-carmichael-number 6601)