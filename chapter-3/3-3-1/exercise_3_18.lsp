(define (is-infinite structure)
  (let ((visited (make-eq-hash-table)))

    (define (is-infinite-helper pair)
      (cond
        ((null? pair) #f)
        ((not (pair? pair)) #f)
        ((hash-table-contains? visited pair) #t)
        ((eq? pair (cdr pair)) #t)
        (else
         (begin
           (hash-table-set! visited pair #t)
           (or (is-infinite-helper (car pair))
               (is-infinite-helper (cdr pair)))))))

    (is-infinite-helper structure)))

(define (make-cycle x)
  (set-cdr! (last-pair x) x) x)

(define (last-pair x)
  (if (null? (cdr x))
      x
      (last-pair (cdr x))))

(newline) (display (is-infinite (cons 1 (cons 2 (cons 3 4))))) ; #f

(define x (list 'a 'b 'c))
(define z (make-cycle x))
(newline) (display (is-infinite z)) ; #t