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

(define (add-terms L1 L2)
    (cond ((empty-termlist? L1) L2)
          ((empty-termlist? L2) L1) 
          (else
            (let ((t1 (first-term L1)) (t2 (first-term L2))) 
                 (cond ((> (order t1) (order t2)) (adjoin-term t1 (add-terms (rest-terms L1) L2)))
                       ((< (order t1) (order t2)) (adjoin-term t2 (add-terms L1 (rest-terms L2)))) 
                       (else (adjoin-term 
                                    (make-term (order t1) (add (coeff t1) (coeff t2))) 
                                    (add-terms (rest-terms L1) (rest-terms L2)))))))))

(define (div-terms L1 L2)
  (if (empty-termlist? L1)
      (list (the-empty-termlist) (the-empty-termlist))
      (let ((t1 (first-term L1))
            (t2 (first-term L2)))
        (if (> (order t2) (order t1))
            (list (the-empty-termlist) L1)

            ; in every step we take dividend and divisor and calculate current term of quotient
            (let ((new-coeff (/ (coeff t1) (coeff t2)))
                  (new-order (- (order t1) (order t2))))

            ; then we multiply every term of L2 on "current term of quotient"
            ; then we subtract from dividend result of multiplication
            ; so the formula is: "new term of dividend" = current dividend - (divisor * "current term of quotient")
            (let ((new-term-of-dividend (rest-terms 
                (map (lambda (term) (make-term (+ (order term) new-order) (* (- (coeff term)) new-coeff))) L2))))

            ; so we check current the highest term of dividend and move to the next
            (let ((rest-of-result (div-terms (add-terms (rest-terms L1) new-term-of-dividend) L2)))

                 ; we can't just return rest-of-result, because we need to include current new term
                 ; so we add first current term in the beginning of the quotient part of rest-of-result
                 ; and than we add remainder part of rest-of-result as second term or result
                 (list (adjoin-term (make-term new-order new-coeff) (car rest-of-result)) (cadr rest-of-result)))))))))

(define term-1-1 (make-term 5 1))
(define term-1-2 (make-term 0 -1))
(define term-2-1 (make-term 2 1))
(define term-2-2 (make-term 0 -1))
(define term-list-1 (adjoin-term term-1-1 (adjoin-term term-1-2 (the-empty-termlist))))
(define term-list-2 (adjoin-term term-2-1 (adjoin-term term-2-2 (the-empty-termlist))))

(define p1 (make-poly 'x term-list-1)) ; (x (5 1) (0 -1))
(define p2 (make-poly 'x term-list-2)) ; (x (2 1) (0 -1))

(newline) (display (div-poly p1 p2)) ; (x ((3 1) (1 1)) ((1 1) (0 -1)))