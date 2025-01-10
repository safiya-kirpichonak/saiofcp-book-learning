(define (adjoin-term term term-list) 
  (if (=zero? (coeff term)) term-list (cons term term-list)))

(define (the-empty-termlist) '())

(define (first-term term-list) (car term-list)) 

(define (rest-terms term-list) (cdr term-list)) 

(define (empty-termlist? term-list) (null? term-list))

(define (make-term order coeff) (list order coeff)) 

(define (order term) (car term))

(define (coeff term) (cadr term))

(define (div-terms L1 L2)
  (if (empty-termlist? L1)
      (list (the-empty-termlist) (the-empty-termlist))
      (let ((t1 (first-term L1))
            (t2 (first-term L2)))
        (if (> (order t2) (order t1))
            (list (the-empty-termlist) L1)
            (let ((new-c (div (coeff t1) (coeff t2)))
                  (new-o (- (order t1) (order t2))))
              (let ((rest-of-result
                     ‹рекурсивно вычислить оставшуюся часть результата›))
                ‹сформировать окончательный результат›))))))