(define (square-list-1 items) 
    (if (null? items)
        (list)
        (cons (expt (car items) 2) (square-list-1 (cdr items)))))

(define (square-list-2 items) 
    (map (lambda (x) (* x x)) items))

(newline) (display (square-list-1 (list 1 2 3 4))) ; (1 4 9 16)
(newline) (display (square-list-2 (list 1 2 3 4))) ; (1 4 9 16)