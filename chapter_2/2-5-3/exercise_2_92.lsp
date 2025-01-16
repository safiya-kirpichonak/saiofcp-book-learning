; +--------------------------+
; terms functions
; +--------------------------+

(define (make-term variable order coefficient) 
    (list variable order coefficient)) 

(define (variable term) (car term))

(define (order term) (cadr term))

(define (coefficient term) (caddr term))

(define (=zero? term-coefficient) 
    (= term-coefficient 0))

(define (the-empty-term-list) '())

(define (adjoin-term term term-list) 
  (if (=zero? (coefficient term)) 
        term-list 
        (cons term term-list)))

; (define (first-term term-list) (car term-list)) 

; (define (rest-terms term-list) (cdr term-list)) 

; (define (empty-termlist? term-list) (null? term-list))

; +--------------------------+
; tests
; +--------------------------+

(define term-1 (make-term 'x 5 1))
(define term-2 (make-term 'y 2 1))
(define term-3 (make-term 'x 0 -1))
(define term-4 (make-term 'y 0 -1))
(define term-list 
    (adjoin-term term-1
        (adjoin-term term-2 
            (adjoin-term term-3 
                (adjoin-term term-4 
                    (the-empty-term-list))))))

(newline) (display term-list) ; ((x 5 1) (y 2 1) (x 0 -1) (y 0 -1))
