#|
operation - a function that connect results.
initial - start parameter, for example (list) or 0.
sequence - list of values.
|#
(define (accumulate operation initial sequence)
    (if (null? sequence) initial
        (operation (car sequence) (accumulate operation initial (cdr sequence)))))

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

Process (n = 6):
first map:
(enumerate-interval 1 n) => (1 2 3 4 5 6)
(lambda (i)) = 1 => (enumerate-interval 1 (- 1 1)) = () => map works 0 time
(lambda (i)) = 2 => (enumerate-interval 1 (- 2 1)) = (1) => map returns ((2 1))
(lambda (i)) = 3 => (enumerate-interval 1 (- 3 1)) = (1 2) => map returns ((3 1) (3 2))
(lambda (i)) = 4 => (enumerate-interval 1 (- 4 1)) = (1 2 3) => map returns ((4 1) (4 2) (4 3))
(lambda (i)) = 5 => (enumerate-interval 1 (- 5 1)) = (1 2 3 4) => map returns ((5 1) (5 2) (5 3) (5 4))
(lambda (i)) = 6 => (enumerate-interval 1 (- 6 1)) = (1 2 3 4 5) => map returns ((6 1) (6 2) (6 3) (6 4) (6 5))
|#

(define (unique-pairs n)
    (accumulate 
        append 
        (list)
        (map 
            (lambda (i) 
                (map 
                    (lambda (j) (list i j)) 
                    (enumerate-interval 1 (- i 1)))) 
            (enumerate-interval 1 n))))

#|
Implimintation of new function:

(define (prime-sum-pairs n)
  (map make-pair-sum
       (filter prime-sum? (unique-pairs n))))
|#

; ((2 1) (3 1) (3 2) (4 1) (4 2) (4 3) (5 1) (5 2) (5 3) (5 4) (6 1) (6 2) (6 3) (6 4) (6 5))
(newline) (display (unique-pairs 6))
