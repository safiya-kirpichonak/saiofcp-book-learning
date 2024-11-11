#|
operation - a function that connect results.
initial - start parameter, for example (list) or 0.
sequence - list of values.
|#
(define (accumulate operation initial sequence)
    (if (null? sequence) initial
        (operation (car sequence) (accumulate operation initial (cdr sequence)))))

#|
operation - operation to run sequence with map before accumulate.
sequence - list of values.
returns result from accumulate where operation is append.
|#
(define (flatmap operation sequence)
  (accumulate append (list) (map operation sequence)))

#|
low - begin of the interval.
high - end of the interval.
returns the new new interval from low to high.
|#
(define (enumerate-interval low high) 
    (if (> low high) (list)
        (cons low (enumerate-interval (+ low 1) high))))

#|
n - the final number of future sequence.
returns the list of unique pairs.
|#
(define (unique-pairs n)
    (flatmap
        (lambda (i) (map (lambda (j) (list i j)) (enumerate-interval 1 (- i 1))))
        (enumerate-interval 1 n)))

#|
Implimintation of new function:

(define (prime-sum-pairs n)
  (map make-pair-sum
       (filter prime-sum? (unique-pairs n))))
|#

; ((2 1) (3 1) (3 2) (4 1) (4 2) (4 3) (5 1) (5 2) (5 3) (5 4) (6 1) (6 2) (6 3) (6 4) (6 5))
(newline) (display (unique-pairs 6))
