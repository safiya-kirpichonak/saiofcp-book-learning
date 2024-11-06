(define a (list 1 3 (list 5 7) 9))
(define b (list (list 7)))
(define c (list 1 (list 2 (list 3 (list 4 (list 5 (list 6 7)))))))

(newline) (display a) ; (1 3 (5 7) 9)
(newline) (display b) ; ((7))
(newline) (display c) ; (1 (2 (3 (4 (5 (6 7))))))

(newline) (display (car (cdr (car (cdr (cdr a)))))) ; 7
(newline) (display (car (car b))) ; 7
(newline) (display (car (cdr (car (cdr (car (cdr (car (cdr (car (cdr (car (cdr c))))))))))))) ; 7