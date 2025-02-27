#|
Answer: 

These functions (op) should use operations for which the order of execution 
is not important, such as addition and multiplication.
|#

(define (fold-right op initial sequence)
    (if (null? sequence) initial
        (op (car sequence)
            (fold-right op initial (cdr sequence)))))

(define (fold-left op initial sequence) 
    (define (iter result rest)
        (if (null? rest) result
            (iter (op result (car rest)) 
                  (cdr rest))))
(iter initial sequence))

(newline) (display (fold-right / 1 (list 1 2 3))) ; 3/2
(newline) (display (fold-left / 1 (list 1 2 3))) ; 1/6
(newline) (display (fold-right list (list) (list 1 2 3))) ; (1 (2 (3 ())))
(newline) (display (fold-left list (list) (list 1 2 3))) ; (((() 1) 2) 3)