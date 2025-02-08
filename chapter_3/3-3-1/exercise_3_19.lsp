(define (is-infinite structure max-size)
  (let ((visited '()))

    (define (is-infinite-helper pair)
      (cond
        ((null? pair) #f)
        ((not (pair? pair)) #f)
        ((member pair visited eq?) #t)
        ((eq? pair (cdr pair)) #t)
        ((>= (length visited) max-size) #t)
        (else
         (begin
           (set! visited (cons pair visited))
           (or (is-infinite-helper (car pair))
               (is-infinite-helper (cdr pair)))))))

    (is-infinite-helper structure)))

(define (make-cycle x)
  (set-cdr! (last-pair x) x)
  x)

(define (last-pair x)
  (if (null? (cdr x))
      x
      (last-pair (cdr x))))

(define x (list 'a 'b 'c))
(define z (make-cycle x))

(newline) (display (is-infinite (cons 1 (cons 2 (cons 3 4))) 100)) ; #f
(newline) (display (is-infinite z 100)) ; #t