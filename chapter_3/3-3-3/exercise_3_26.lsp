(define (entry table) (car table))

(define (left-branch table) (cadr table))

(define (right-branch table) (caddr table))

(define (make-table entry left right)
  (list entry left right))

(define (lookup key records)
  (cond ((null? records) (error "No data by this key!"))
        ((= key (entry records)) records)
        ((< key (entry records)) (lookup key (left-branch records)))
        ((> key (entry records)) (lookup key (right-branch records)))))

(define (insert key record records)
  (cond ((null? records) (make-table key record '()))
        ((= key (entry records)) records)
        ((< key (entry records))
         (make-table (entry records)
                     (insert key record (left-branch records))
                     (right-branch records)))
        ((> key (entry records))
         (make-table (entry records)
                     (left-branch records)
                     (insert key record (right-branch records))))))

(define table
  (insert 7 'data
    (insert 5 'data
      (insert 2 'data '())
      (insert 6 'data '())))
    (insert 8 'data '())))

(newline) (display table)
