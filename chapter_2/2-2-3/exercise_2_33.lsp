(define (accumulate op initial sequence)
    (if (null? sequence) initial
        (op (car sequence)
            (accumulate op initial (cdr sequence)))))

(define (map p sequence)
    (accumulate (lambda (x y) (cons (p x) y)) (list) sequence))

(define (append base-seq additional-seq) 
    (accumulate cons additional-seq base-seq))

(define (length sequence) 
    (accumulate (lambda (x y) (+ 1 y)) 0 sequence))

(define (square x) (* x x))
(newline) (display (length (list 1 2 3 4 5))) ; 5
(newline) (display (map square (list 1 2 3))) ; (1 4 9)
(newline) (display (append (list 1 2 3) (list 4 5 6))) ; (1 2 3 4 5 6)