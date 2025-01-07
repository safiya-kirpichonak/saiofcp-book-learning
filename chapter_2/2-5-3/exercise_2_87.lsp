(define (=zero? term-coefficient) 
    (= term-coefficient 0))

(define (adjoin-term term term-list) 
  (if (=zero? (coefficient term)) term-list (cons term term-list)))

(define (coefficient term) (cadr term))