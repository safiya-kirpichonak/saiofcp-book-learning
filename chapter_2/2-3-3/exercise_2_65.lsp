(define (entry tree) (car tree))

(define (left-branch tree) (cadr tree))

(define (right-branch tree) (caddr tree))

(define (make-tree entry left right) 
    (list entry left right))

(define (union set1 set2)
    (define (iter result set1 set2)
        (cond ((null? set1) (append result set2))
              ((null? set2) (append result set1))
              ((< (car set1) (car set2)) (iter (append result (list (car set1))) (cdr set1) set2))
              ((> (car set1) (car set2)) (iter (append result (list (car set2))) set1 (cdr set2)))
              (else (iter (append result (list (car set1))) (cdr set1) (cdr set2)))))
    (iter '() set1 set2))

(define (intersection set1 set2)
  (if (or (null? set1) (null? set2)) '()
      (let ((x1 (car set1)) (x2 (car set2)))
        (cond ((= x1 x2) (cons x1 (intersection (cdr set1) (cdr set2))))
              ((< x1 x2) (intersection (cdr set1) set2))
              ((< x2 x1) (intersection set1 (cdr set2)))))))

(define (tree->list tree)
  (define (copy-to-list tree result-list)
    (if (null? tree) result-list
        (copy-to-list (left-branch tree)
                      (cons (entry tree)
                            (copy-to-list (right-branch tree)
                                          result-list)))))
  (copy-to-list tree '()))

(define (list->tree elements)
  (car (partial-tree elements (length elements))))

(define (partial-tree elements n)
  (if (= n 0)
      (cons '() elements)
      (let ((left-size (quotient (- n 1) 2)))
        (let ((left-result (partial-tree elements left-size)))
          (let ((left-tree (car left-result))
                (non-left-elements (cdr left-result)))
            (let ((right-size (- n (+ left-size 1))))
              (let ((this-entry (car non-left-elements))
                    (right-result (partial-tree (cdr non-left-elements) right-size)))
                (let ((right-tree (car right-result))
                      (remaining-elements (cdr right-result)))
                  (cons (make-tree this-entry left-tree right-tree) remaining-elements)))))))))

(define (union-set tree1 tree2)
    (list->tree (union (tree->list tree1) (tree->list tree2))))

(define (intersection-set tree1 tree2)
    (list->tree (intersection (tree->list tree1) (tree->list tree2))))

(newline) (display (union-set '(7 (3 (1 () ()) ()) (11 () (13 () ()))) '(5 (2 () ()) (6 () ()))))
; Result:
; (5
;     (2
;         (1 () ())
;         (3 () ()))
;     (7
;         (6 () ())
;         (11
;             () 
;             (13 () ()))))
(newline) (display (intersection-set '(7 (3 (1 () ()) ()) (11 () (13 () ()))) '(5 (3 (1 () ()) ()) (11 () ()))))
; Result:
; (3
;   (1 () ())
;   (11 () ()))