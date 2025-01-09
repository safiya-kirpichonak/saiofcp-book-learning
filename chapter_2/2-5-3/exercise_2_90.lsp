; +-------------------------------------+
; type tag
; +-------------------------------------+

(define (attach-tag type-tag contents)
  (cons type-tag contents))

(define (type-tag datum)
  (if (pair? datum) 
        (car datum) 
        (error "Incorrect tag -- TYPE-TAG" datum)))

(define (contents datum)
  (if (pair? datum) 
        (cdr datum) 
        (error "Incorrect content -- CONTENTS" datum)))

(define (dense? term)
  (eq? (type-tag term) 'dense))

(define (sparse? term)
  (eq? (type-tag term) 'sparse))

; +-------------------------------------+
; functions for the dense polynomial
; +-------------------------------------+

(define (make-term-dense order coeff) 
    (attach-tag 'dense (list order coeff))) 

(define (order-dense term) (car (contents term)))

(define (coeff-dense term) (cadr (contents term)))

(define (is-zero-dense term) (= (coeff-dense term) 0))

(define (adjoin-term-dense term term-list) 
    (if (is-zero-dense term) term-list (cons term term-list)))

; +-------------------------------------+
; functions for the sparse polynomial
; +-------------------------------------+

(define (make-term-sparse coeff) 
    (attach-tag 'sparse (list coeff)))

(define (coeff-sparse term) 
    (car (contents term)))

(define (is-zero-sparse term) 
    (= (coeff-sparse term) 0))

(define (adjoin-term-sparse term term-list) 
    (cons term term-list))

; +-------------------------------------+
; general selectors
; +-------------------------------------+

(define (coeff term)
    (cond ((dense? term) (coeff-dense term))
          ((sparse? term) (coeff-sparse term))
          (else (error "Unknown type -- COEFF"))))

(define (order terms)
    (cond ((dense? (first-term terms)) (order-dense (first-term terms)))
          ((sparse? (first-term terms)) (length terms))
          (else (error "Unknown type -- ORDER"))))

(define (is-zero term)
    (cond ((dense? term) (is-zero-dense term))
          ((sparse? term) (is-zero-sparse term))
          (else (error "Unknown type -- IS-ZERO"))))

(define (adjoin-term term term-list) 
    (cond ((dense? term) (adjoin-term-dense term term-list))
          ((sparse? term) (adjoin-term-sparse term term-list))
          (else (error "Unknown type -- ADJOIN-TERM"))))

(define (the-empty-termlist) '())

(define (first-term term-list) (car term-list)) 

(define (rest-terms term-list) (cdr term-list)) 

(define (is-empty-termlist term-list) (null? term-list))

(define (sum-terms t1 t2)
    (cond ((dense? t1) 
                (make-term-dense (order-dense t1) (+ (coeff-dense t1) (coeff-dense t2))))
          ((sparse? t2) 
                (make-term-sparse (+ (coeff-sparse t1) (coeff-sparse t2))))
          (else (error "Unknown type -- SUM-TERMS"))))

; +-------------------------------------+
; general operations
; +-------------------------------------+

(define (add-terms L1 L2)
    (cond ((is-empty-termlist L1) L2)
          ((is-empty-termlist L2) L1) 
          (else
            (let ((t1 (first-term L1)) 
                  (t2 (first-term L2))) 
                 (cond ((> (order L1) (order L2)) (adjoin-term t1 (add-terms (rest-terms L1) L2)))
                       ((< (order L1) (order L2)) (adjoin-term t2 (add-terms L1 (rest-terms L2)))) 
                       (else (adjoin-term (sum-terms t1 t2) (add-terms (rest-terms L1) (rest-terms L2)))))))))

; +-------------------------------------+
; Tests
; +-------------------------------------+

(define dense-term1 (make-term-dense 3 3))
(define dense-term2 (make-term-dense 1 5))
(define dense-list (adjoin-term dense-term1 (adjoin-term dense-term2 (the-empty-termlist))))
(newline) (display dense-list) ; ((dense 3 3) (dense 1 5))
(newline) (display (add-terms dense-list dense-list)) ; ((dense 3 6) (dense 1 10))

(define sparse-term1 (make-term-sparse 4))
(define sparse-term2 (make-term-sparse 6))
(define sparse-list (adjoin-term sparse-term1 (adjoin-term sparse-term2 (the-empty-termlist))))
(newline) (display sparse-list) ; ((sparse 4) (sparse 6))
(newline) (display (add-terms sparse-list sparse-list)) ; ((sparse 8) (sparse 12))