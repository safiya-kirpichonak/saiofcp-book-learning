(define (count-pairs structure)
  (let ((visited (make-hash-table)))
    (define (count-helper pair)
      (cond
        ((null? pair) 0)
        ((not (pair? pair)) 0)
        ((hash-table-contains? visited pair) 0)
        (else
         (hash-table-set! visited pair #t)
         (+ 1 (count-helper (car pair))
              (count-helper (cdr pair))))))
    (count-helper structure)))

(newline) (display (count-pairs (cons 1 2))) ; 1
(newline) (display (count-pairs (cons 1 (cons 2 3)))) ; 2
(newline) (display (count-pairs (cons 1 (cons 2 (cons 3 4))))) ; 3