; +-------------------------------------+
; type tag
; +-------------------------------------+

(define (attach-tag type-tag contents)
  (cons type-tag contents))

(define (type-tag datum)
  (if (pair? datum) (car datum) (error "Incorrect tag -- TYPE-TAG" datum)))

(define (contents datum)
  (if (pair? datum) (cdr datum) (error "Incorrect content -- CONTENTS" datum)))

(define (dense? z)
  (eq? (type-tag z) 'dense))

(define (sparse? z)
  (eq? (type-tag z) 'sparse))

; +-------------------------------------+
; functions for the dense polynomial
; +-------------------------------------+
; ('dense (1 2))
(define (make-term-dense order coeff) 
    (attach-tag 'dense (list order coeff))) 

(define (order-dense term) 
    (if (dense? term) 
        (car (contents term)) 
        (error "Incorrect term type -- ORDER-DENSE")))

(define (coeff-dense term) 
    (if (dense? term) 
        (cadr (contents term)) 
        (error "Incorrect term type -- COEFF-DENSE")))

(define (is-zero-dense term) 
    (if (dense? term)
        (= (coeff-dense term) 0)
        (error "Incorrect term type -- IS-ZERO-DENSE")))

; (('dense (2 2)) ('dense (1 3)) ('dense (0 4)))
(define (adjoin-term-dense term term-list) 
    (if (=zero? (coeff term)) term-list (cons term term-list)))

; +-------------------------------------+
; functions for the sparse polynomial
; +-------------------------------------+

; (('sparse 4) ('sparse 0) ('sparse 0))
(define (make-term-sparse order coeff) 
    (if (= order 0) 
        (attach-tag 'sparse coeff)
        (cons 
            (attach-tag 'sparse coeff) 
            (make-term-sparse (- order 1) 0))))

(define (coeff-sparse term) 
    (if (sparse? term) 
        (contents term)
        (error "Incorrect term type -- COEFF-SPARSE")))

(define (is-zero-sparse term) 
    (if (sparse? term)
        (= (coeff-sparse term) 0)
        (error "Incorrect term type -- IS-ZERO-SPARSE")))

; (('sparse 4) ('sparse 2) ('sparse 55))
(define (adjoin-term-sparse coeff order term-list) 
    (define (insert-at lst index value)
        (if (zero? index)
            (cons value lst)
            (cons (car lst) (insert-at (cdr lst) (- index 1) value))))

    (let ((term-length (length term-list))) 
       (cond  ((= order term-length) (cons (make-term-sparse order coeff) term-list))
              ((> order term-length) (append (make-term-sparse (- order term-length) coeff) term-list))
              ((and (< order term-length) (> order -1)) 
                    (insert-at term-list (- term-length order) (make-term-sparse 0 coeff)))
              (error "Unknow position -- ADJOIN-TERM"))))

; +-------------------------------------+
; general selectors
; +-------------------------------------+

(define (coeff term)
    (cond ((dense? term) (coeff-dense term))
          ((sparse? term) (sparse-dense term))
          (else (error "Unknown type -- COEFF"))))

(define (order term)
    (cond ((dense? term) (order-dense term))
          ((sparse? term) (...))
          (else (error "Unknown type -- ORDER"))))

(define (is-zero term) 
    (cond ((dense? term) (is-zero-dense term))
          ((sparse? term) (is-zero-sparse term))
          (else (error "Unknown type -- IS-ZERO"))))

(define (adjoin-term coeff order term-list) 
    (cond ((dense? term) (adjoin-term-dense (make-term-dense order coeff) term-list))
          ((sparse? term) (adjoin-term-sparse coeff order term-list))
          (else (error "Unknown type -- ADJOIN-TERM"))))

(define (the-empty-termlist) '())

(define (first-term-sparse term-list) (car term-list)) 

(define (rest-terms-sparse term-list) (cdr term-list)) 

(define (is-empty-termlist term-list) (null? term-list))

; +-------------------------------------+
; general operations
; +-------------------------------------+


