(define (reverse items)
    (if (null? items) 
        (list)
        (append (reverse (cdr items)) (list (car items)))))

(define (deep-reverse items)
  (cond ((null? items) (list))
        ((not (pair? items)) items)
        (else (append (deep-reverse (cdr items))
                      (list (deep-reverse (car items))))))) 

(define x (list (list 1 2) (list 3 4)))
(newline) (display (reverse x)) ; ((3 4) (1 2))
(newline) (display (deep-reverse x)) ; ((4 3) (2 1))