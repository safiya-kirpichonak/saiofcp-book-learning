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

(define (reverse-right sequence)
    (fold-right (lambda (x y) (append y (list x))) (list) sequence))

(define (reverse-left sequence)
    (fold-left (lambda (x y) (append (list y) x)) (list) sequence))

(define numbers (list 1 2 3 4 5))
(newline) (display (reverse-right numbers)) ; (5 4 3 2 1)
(newline) (display (reverse-left numbers)) ; (5 4 3 2 1)