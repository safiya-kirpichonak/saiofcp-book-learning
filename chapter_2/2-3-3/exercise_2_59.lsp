(define (element-of-set? x set)
  (cond ((null? set) false)
        ((equal? x (car set)) true)
        (else (element-of-set? x (cdr set)))))

(define (union-set set1 set2) 
    (define (iter result items)
        (cond ((null? items) result)
              ((not (element-of-set? (car items) result))
               (iter (append result (list (car items))) (cdr items)))
              (else (iter result (cdr items)))))
    (iter '() (append set1 set2)))

(newline) (display (union-set '(1 2 3 5 6) '(1 2 3 4))) ; (1 2 3 4)