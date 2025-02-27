(define (make-mobile left right) 
    (list left right))

(define (make-branch length structure) 
    (list length structure))

(define (left-branch mobile)
  (list-ref mobile 0))

(define (right-branch mobile)
  (list-ref mobile 1))

(define (branch-length branch)
  (list-ref branch 0))

(define (branch-structure branch)
  (list-ref branch 1))

(define (balanced? structure)
  (define (recursion structure)
      (cond ((number? structure) structure)
            ((pair? structure)
            (let* ((left (left-branch structure))
                    (right (right-branch structure))
                    (left-length (branch-length left))
                    (right-length (branch-length right))
                    (left-structure (recursion (branch-structure left)))
                    (right-structure (recursion (branch-structure right))))
              (cond ((and (boolean? left-structure) (eq? left-structure #f)) #f)
                    ((and (boolean? right-structure) (eq? right-structure #f)) #f)
                    ((and (number? left-structure) (number? right-structure))
                      (let ((left-weight (* left-length left-structure))
                            (right-weight (* right-length right-structure)))
                        (newline) (display "Left weight: ") (display left-weight)
                        (newline) (display "Right weight: ") (display right-weight) (newline)
                        (if (= left-weight right-weight)
                            (+ left-weight right-weight)
                            #f)))
                    (else (error "Something went wrong.")))))
            (else (error "Something went wrong."))))
  (number? (recursion structure)))

#|
    mobile1
   5|       \3
    mobile2  10
   2|    |1
    4    8

Left weight: 8
Right weight: 8

Left weight: 80
Right weight: 30
#f

    mobile3
   3|     |3
    10    10

Left weight: 30
Right weight: 30
#t
|#

(define mobile2-right-branch (make-branch 1 8))
(define mobile2-left-branch (make-branch 2 4))
(define mobile2 (make-mobile mobile2-left-branch mobile2-right-branch))
(define mobile1-left-branch (make-branch 5 mobile2))
(define mobile1-right-branch (make-branch 3 10))
(define mobile1 (make-mobile mobile1-left-branch mobile1-right-branch))

(define mobile3-right-branch (make-branch 3 10))
(define mobile3-left-branch (make-branch 3 10))
(define mobile3 (make-mobile mobile3-left-branch mobile3-right-branch))

(newline) (display (balanced? mobile1)) ; #f
(newline) (display (balanced? mobile3)) ; #t