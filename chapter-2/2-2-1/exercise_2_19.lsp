#|
The order of items in the coin-values list does not affect the result. 
This is because the cc function considers all possible combinations 
regardless of the coin order in the list. It simply sums up the number 
of ways to get the desired amount, going through all possible breakdowns, 
so that the result will be the same regardless of the order of the 
items in the coin-values list.
|#

(define (first-denomination coin-values) (car coin-values))

(define (except-first-denomination coin-values) (cdr coin-values))

(define (no-more? coin-values) (null? coin-values))

(define (cc amount coin-values)
  (cond ((= amount 0) 1)
        ((or (< amount 0) (no-more? coin-values)) 0)
        (else
         (+ (cc amount
                (except-first-denomination coin-values))
            (cc (- amount
                   (first-denomination coin-values))
                coin-values)))))

(define us-coins-1 (list 50 25 10 5 1))
(define us-coins-2 (list 1 5 10 25 50))
(define us-coins-3 (list 1 50 5 25 10))

(newline) (display (cc 100 us-coins-1)) ; 292
(newline) (display (cc 100 us-coins-2)) ; 292
(newline) (display (cc 100 us-coins-3)) ; 292