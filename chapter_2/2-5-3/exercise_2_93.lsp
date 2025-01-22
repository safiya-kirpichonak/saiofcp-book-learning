; bad

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

(define (bigger-poly p1 p2)
  (if (< (order (first-term (term-list p1))) 
         (order (first-term (term-list p2))))
      p2
      p1))

(define (div-poly p1 p2)
  (if (same-variable? (variable p1) (variable p2))
      (make-poly (variable p1) (div-terms (term-list p1) (term-list p2)))
      (error "Polynomials are from different variables -- DIV-POLY" (list p1 p2))))

(define (is-empty-poly? poly)
    (newline) (display "is-empty-poly?")
    (newline) (display poly)
    (or (empty-termlist? (term-list poly))
        (= (order (first-term (term-list poly))) 0)))

(define (find-poly-gcd p1 p2) 
  (newline) (display "find-poly-gcd")
  (newline) (display p1)
  (newline) (display p2)
  (newline) (display (div-poly p1 p2))
  (cond ((is-empty-poly? p1) p2)
        ((is-empty-poly? p2) p1)
        (else (find-poly-gcd p2 (div-poly p1 p2)))))

; +--------------------------+
; terms operations
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

(define (add-terms L1 L2)
    (cond ((empty-termlist? L1) L2)
          ((empty-termlist? L2) L1) 
          (else
            (let ((t1 (first-term L1)) (t2 (first-term L2))) 
                 (cond ((> (order t1) (order t2)) (adjoin-term t1 (add-terms (rest-terms L1) L2)))
                       ((< (order t1) (order t2)) (adjoin-term t2 (add-terms L1 (rest-terms L2)))) 
                       (else (adjoin-term 
                                    (make-term (order t1) (+ (coeff t1) (coeff t2))) 
                                    (add-terms (rest-terms L1) (rest-terms L2)))))))))

(define (div-terms L1 L2)
  (if (empty-termlist? L1)
      (list (the-empty-termlist) (the-empty-termlist))
      (let ((t1 (first-term L1))
            (t2 (first-term L2)))
        (if (> (order t2) (order t1))
            (list (the-empty-termlist) L1)
            (let ((new-coeff (/ (coeff t1) (coeff t2)))
                  (new-order (- (order t1) (order t2))))
            (let ((new-term-of-dividend (rest-terms 
                (map (lambda (term) (make-term (+ (order term) new-order) (* (- (coeff term)) new-coeff))) L2))))
            (let ((rest-of-result (div-terms (add-terms (rest-terms L1) new-term-of-dividend) L2)))
                 (list (adjoin-term (make-term new-order new-coeff) (car rest-of-result)) (cadr rest-of-result)))))))))

; +--------------------------+
; rational operations
; +--------------------------+

(define p1 (make-poly 'x '((2 1)(0 1)))) ; x ^^ 2 + 1
(define p2 (make-poly 'x '((3 1)(0 1)))) ; x ^^ 3 + 1
(newline) (display (bigger-poly p1 p2)) ; (x (3 1) (0 1))
(newline) (display (find-poly-gcd p1 p2)) ; should be (x (1 1))