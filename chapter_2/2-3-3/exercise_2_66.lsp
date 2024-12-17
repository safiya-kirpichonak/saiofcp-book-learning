(define (entry tree) (car tree))

(define (left-branch tree) (cadr tree))

(define (right-branch tree) (caddr tree))

(define (make-tree entry left right)
  (list entry left right))

(define (lookup key records)
  (cond ((null? records) (error "No data by this key!"))
        ((= key (entry records)) records)
        ((< key (entry records)) (lookup key (left-branch records)))
        ((> key (entry records)) (lookup key (right-branch records)))))

(newline) (display (lookup 5 '(7 (5 (2 () ()) (6 () ())) (8 () ())))) ; (5 (2 () ()) (6 () ()))
(newline) (display (lookup 10 '(7 (5 (2 () ()) (6 () ())) (8 () ())))) ; No data by this key!