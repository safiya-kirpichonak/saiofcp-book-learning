; selectors
(define (adjoin-term term term-list) 
  (if (=zero? (coeff term)) term-list (cons term term-list)))

(define (=zero? term-coefficient) (= term-coefficient 0))

(define (the-empty-termlist) '())

(define (first-term term-list) (car term-list)) 

(define (rest-terms term-list) (cdr term-list)) 

(define (empty-termlist? term-list) (null? term-list))

(define (make-term order coeff) (list order coeff)) 

; ((100 1) (2 2) (0 1)) - orders are 100 2 and 0
(define (order term) (car term))

; ((100 1) (2 2) (0 1)) - coeff are 1 2 1
(define (coeff term) (cadr term))

; operations
(define (change-sign terms) 
      (if (null? terms) '() 
                        (cons 
                              (make-term 
                                    (order (first-term terms)) 
                                    (- (coeff (first-term terms)))) 
                              (change-sign (rest-terms terms)))))

(define (subtract-terms L1 L2)
    (cond ((empty-termlist? L1) (change-sign L2))
          ((empty-termlist? L2) L1)
          (else
            (let ((t1 (first-term L1))
                  (t2 (first-term L2)))
                 (cond ((> (order t1) (order t2)) (adjoin-term t1 (subtract-terms (rest-terms L1) L2)))
                       ((< (order t1) (order t2)) (adjoin-term t2 (subtract-terms L1 (rest-terms L2)))) 
                       (else (adjoin-term 
                                    (make-term (order t1) (- (coeff t1) (coeff t2))) 
                                    (subtract-terms (rest-terms L1) (rest-terms L2)))))))))

(define poly1 (list (make-term 2 3) (make-term 1 2) (make-term 0 1))) ; 3x ** 2 + 2x + 1
(define poly2 (list (make-term 2 1) (make-term 1 1) (make-term 0 1))) ; x ** 2 + x + 1

(newline) (display (subtract-terms poly1 poly2)) ; ((2 2) (1 1))