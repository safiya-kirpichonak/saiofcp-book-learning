(define (accumulate operation initial sequence)
    (if (null? sequence) initial
        (operation (car sequence) (accumulate operation initial (cdr sequence)))))

(define (enumerate-interval low high) 
    (if (> low high) (list)
        (cons low (enumerate-interval (+ low 1) high))))

(define (filter-empty tree)
  (cond ((and 
            (not (null? tree)) 
            (number? (car tree))) (list tree))
        ((null? tree) tree)
        (else (append 
                (filter-empty (car tree)) 
                (filter-empty (cdr tree))))))

(define (unique-trio n)
    (filter-empty
        (map 
            (lambda (i) 
                (map 
                    (lambda (j) 
                        (map 
                            (lambda (k) (list i j k))
                            (enumerate-interval 1 (- j 1)))) 
                    (enumerate-interval 1 (- i 1)))) 
            (enumerate-interval 1 n))))

(define (trio-by-sum n sum)
    (filter (lambda (sequence) (= sum (accumulate + 0 sequence))) 
            (unique-trio n)))

#|
(1, 2, 3): sum = 6
(1, 2, 4): sum = 7
(1, 3, 4): sum = 8
(2, 3, 4): sum = 9
|#
(newline) (display (unique-trio 4)) ; ((3 2 1) (4 2 1) (4 3 1) (4 3 2))

#|
(1, 2, 3): sum = 6
(1, 2, 4): sum = 7
(1, 3, 4): sum = 8
(2, 3, 4): sum = 9
(1, 2, 5): sum = 8
(1, 3, 5): sum = 9
(2, 3, 5): sum = 10
(1, 4, 5): sum = 10
(2, 4, 5): sum = 11
(3, 4, 5): sum = 12
|#
(newline) (display (unique-trio 5)) ; ((3 2 1) (4 2 1) (4 3 1) (4 3 2) (5 2 1) (5 3 1) (5 3 2) (5 4 1) (5 4 2) (5 4 3))

#| 
(1, 2, 3): sum = 6
(1, 2, 4): sum = 7
(1, 3, 4): sum = 8
(2, 3, 4): sum = 9
(1, 2, 5): sum = 8
(1, 3, 5): sum = 9
(2, 3, 5): sum = 10
(1, 4, 5): sum = 10
(2, 4, 5): sum = 11
(3, 4, 5): sum = 12
(1, 2, 6): sum = 9
(1, 3, 6): sum = 10
(2, 3, 6): sum = 11
(1, 4, 6): sum = 11
(2, 4, 6): sum = 12
(3, 4, 6): sum = 13
(1, 5, 6): sum = 12
(2, 5, 6): sum = 13
(3, 5, 6): sum = 14
(4, 5, 6): sum = 15
|#
(newline) (display (unique-trio 6))
; ((3 2 1) (4 2 1) (4 3 1) (4 3 2) (5 2 1) (5 3 1) (5 3 2) (5 4 1) (5 4 2) (5 4 3) 
; (6 2 1) (6 3 1) (6 3 2) (6 4 1) (6 4 2) (6 4 3) (6 5 1) (6 5 2) (6 5 3) (6 5 4))

(newline) (display (trio-by-sum 4 6)) ; ((3 2 1))
(newline) (display (trio-by-sum 5 10)) ; ((5 3 2) (5 4 1))
(newline) (display (trio-by-sum 6 12)) ; ((5 4 3) (6 4 2) (6 5 1))