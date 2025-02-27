(define (equal? a b)
  (cond ((and (not (pair? a)) (not (pair? b))) (eq? a b))
        ((and (pair? a) (pair? b)) 
         (and (equal? (car a) (car b)) (equal? (cdr a) (cdr b))))
        (else #f)))

(newline) (display (equal? '(this is a list) '(this is a list))) ; #t
(newline) (display (equal? '(this is a list) '(this (is a) list))) ; #f
