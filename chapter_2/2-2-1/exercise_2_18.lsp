(define (reverse items)
    (if (null? items) 
        (list)
        (append (reverse (cdr items)) (list (car items)))))

(newline) (display (reverse (list 1 4 9 16 25))) ; (25 16 9 4 1)