#|
1. Faster, because we don;t need to check uniqueness.
2. Yes, if I need lists with copies, for example, "user's orders in delivery app".
|#

(define (element-of-set? x set)
  (cond ((null? set) false)
        ((equal? x (car set)) true)
        (else (element-of-set? x (cdr set)))))

(define (adjoin-set x set) (cons x set))

(define (union-set set1 set2) (append set1 set2))

(define (remove-element set x)
  (define (iter result set)
    (if (null? set)
        result
        (if (equal? x (car set))
            (iter result (cdr set))
            (iter (append result (list (car set))) (cdr set)))))
  (iter '() set))

(define (intersection-set set1 set2)
  (define (iter set1 result)
    (cond
      ((null? set1) result)
      ((and (element-of-set? (car set1) set2) 
            (not (element-of-set? (car set1) result)))
       (iter (cdr set1) (append result (list (car set1)))))
      (else (iter (cdr set1) result))))
  (iter set1 '()))

(newline) (display (remove-element '(1 3 2 2) 2)) ; (1 3)

(newline) (display (intersection-set '(1 1 2 5 6) '(1 2 2 3 4))) ; (1 2)
