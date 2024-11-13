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

(newline) (display (trio-by-sum 4 6)) ; ((3 2 1))
