(define (fringe x) 
    (cond ((null? x) (list))
          ((not (pair? x)) (list x))
          (else (append (fringe (car x)) (fringe (cdr x))))))

(define x (list (list 1 2) (list 3 4)))
(newline) (display (fringe x)) ; (1 2 3 4)
(newline) (display (fringe (list x x))) ; (1 2 3 4 1 2 3 4)