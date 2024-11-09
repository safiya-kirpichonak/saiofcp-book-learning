(define (accumulate op initial sequence)
    (if (null? sequence) initial
        (op (car sequence)
            (accumulate op initial (cdr sequence)))))

(define (accumulate-n op init sequence)
    (if (null? (car sequence)) (list)
        (cons (accumulate op init (map (lambda (s) (car s)) sequence))
              (accumulate-n op init (map (lambda (s) (cdr s)) sequence)))))

(define tree (list (list 1 2 3) (list 4 5 6) (list 7 8 9) (list 10 11 12)))
(newline) (display (accumulate-n + 0 tree))