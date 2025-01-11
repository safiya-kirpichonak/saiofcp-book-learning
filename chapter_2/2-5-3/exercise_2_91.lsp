; +--------------------------+
; polynomial functions
; +--------------------------+

(define (make-poly variable term-list) 
  (cons variable term-list))

(define (variable p) (car p))
  
(define (term-list p) (cdr p))

(define (variable? x) (symbol? x))

(define (same-variable? v1 v2) 
    (and (variable? v1) (variable? v2) (eq? v1 v2)))

(define (div-poly p1 p2)
  (if (same-variable? (variable p1) (variable p2))
      (make-poly (variable p1) (div-terms (term-list p1) (term-list p2)))
      (error "Polynomials are from different variables -- DIV-POLY" (list p1 p2))))

; +--------------------------+
; terms functions
; +--------------------------+

(define (make-term order coeff) (list order coeff)) 

(define (adjoin-term term term-list) 
  (if (=zero? (coeff term)) term-list (cons term term-list)))

(define (=zero? term-coeff) (= term-coeff 0))

(define (the-empty-termlist) '())

(define (first-term term-list) (car term-list)) 

(define (rest-terms term-list) (cdr term-list)) 

(define (empty-termlist? term-list) (null? term-list))

(define (order term) (car term))

(define (coeff term) (cadr term))

; (define (div-terms L1 L2)
;   (if (empty-termlist? L1)
;       (list (the-empty-termlist) (the-empty-termlist))
;       (let ((t1 (first-term L1))
;             (t2 (first-term L2)))
;             (if (> (order t2) (order t1))
;                 (list (the-empty-termlist) L1)
;                 (let ((new-c (div (coeff t1) (coeff t2)))
;                       (new-o (- (order t1) (order t2))))
;                 (let ((rest-of-result
;                      ‹рекурсивно вычислить оставшуюся часть результата›))
;                 ‹сформировать окончательный результат›))))))

(define term-1-1 (make-term 5 1))
(define term-1-2 (make-term 0 -1))
(define term-2-1 (make-term 2 1))
(define term-2-2 (make-term 0 -1))
(define term-list-1 (adjoin-term term-1-1 (adjoin-term term-1-2 (the-empty-termlist))))
(define term-list-2 (adjoin-term term-2-1 (adjoin-term term-2-2 (the-empty-termlist))))

(define p1 (make-poly 'x term-list-1))
(define p2 (make-poly 'x term-list-2))

(newline) (display p1)
(newline) (display p2)