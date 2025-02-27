(define (accumulate op initial sequence)
    (if (null? sequence) initial
        (op (car sequence)
            (accumulate op initial (cdr sequence)))))

; my solution:
(define (leaves tree)
  (cond ((number? tree) (list tree))
        ((null? tree) (list))
        (else (append (leaves (car tree)) (leaves (cdr tree))))))

(define (count-leaves tree)
    (accumulate (lambda (x y) (+ 1 y)) 0 (leaves tree)))

; better solution:
; (define (count-leaves tree)
;   (accumulate + 
;               0 
;               (map 
;                 (lambda (subtree) (if (pair? subtree) (count-leaves subtree) 1)) 
;                 tree)))

(define tree (list 1 2 (list 3 4 (list 5 6)) 7 8))
(newline) (display (count-leaves tree)) ; 8
