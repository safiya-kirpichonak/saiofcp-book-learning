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

(define (first-term term-list) (car term-list)) 

(define (rest-terms term-list) (cdr term-list)) 

(define (empty-termlist? term-list) (null? term-list))

; +------------------------------------+
; term's operations for only 1 variable
; +------------------------------------+

(define (add-terms-one-variable L1 L2)
    (cond ((empty-termlist? L1) L2)
          ((empty-termlist? L2) L1) 
          (else
            (let ((t1 (first-term L1)) 
                  (t2 (first-term L2))) 
                 (cond ((> (order t1) (order t2)) 
                              (adjoin-term t1 (add-terms-one-variable (rest-terms L1) L2)))
                       ((< (order t1) (order t2)) 
                              (adjoin-term t2 (add-terms-one-variable L1 (rest-terms L2)))) 
                       (else (adjoin-term
                                    (make-term (variable t1) (order t1) (+ (coefficient t1) (coefficient t2))) 
                                    (add-terms-one-variable (rest-terms L1) (rest-terms L2)))))))))

(define (mul-terms-one-variable L1 L2) 
  (if (empty-termlist? L1) 
          (the-empty-term-list)
          (add-terms-one-variable
                  (mul-term-by-all-terms (first-term L1) L2) 
                  (mul-terms-one-variable (rest-terms L1) L2))))

(define (mul-term-by-all-terms t1 L) 
  (if (empty-termlist? L) 
      (the-empty-term-list)
      (let ((t2 (first-term L)))
           (adjoin-term
                      (make-term 
                            (variable t1)
                            (+ (order t1) (order t2)) 
                            (* (coefficient t1) (coefficient t2))) 
                      (mul-term-by-all-terms t1 (rest-terms L))))))

; +-----------------------------------+
; term's operations for many variables
; +-----------------------------------+

(define (add-to-group term groups)
  (let* ((key (car term))
         (existing-group (assoc key groups)))
        (if existing-group
            (cons 
                (cons key (append (cdr existing-group) (list term)))
                (filter (lambda (g) (not (equal? g existing-group))) groups))
            (cons (list key term) groups))))

(define (group-by-first-element terms)
  (define (iter terms groups)
    (if (null? terms) 
        groups 
        (iter (cdr terms) (add-to-group (car terms) groups))))
  (iter terms '()))

; ((y (y 2 1) (y 0 -1)) (x (x 5 1) (x 0 -1)))
; (newline) (display (group-by-first-element '((x 5 1) (y 2 1) (x 0 -1) (y 0 -1))))

; how loop construction works ???
(define (combine-groups L1 L2 operation)
  (let ((L1-mapped (map (lambda (group) (cons (car group) (cdr group))) L1))
        (L2-mapped (map (lambda (group) (cons (car group) (cdr group))) L2)))
    (let loop ((remaining-L1 L1-mapped)
               (remaining-L2 L2-mapped)
               (result '()))
      (cond
        ((null? remaining-L1) (append result remaining-L2))
        ((null? remaining-L2) (append result remaining-L1))
        (else
            (let* ((group1 (car remaining-L1))
                   (group2 (find (lambda (g) (eqv? (car g) (car group1))) remaining-L2)))
                  (if group2
                    (loop (cdr remaining-L1)
                        (remove (lambda (g) (eqv? (car g) (car group1))) remaining-L2)
                        (cons (cons (car group1) (operation (cdr group1) (cdr group2))) result))
                    (loop (cdr remaining-L1)
                        remaining-L2
                        (cons group1 result)))))))))

; ((x (x 5 2) (x 0 -2)) (y (y 2 2) (y 0 -2)) (z (z 3 0) (z 1 1)))
; (define L1 '((y (y 2 1) (y 0 -1)) (x (x 5 1) (x 0 -1))))
; (define L2 '((y (y 2 1) (y 0 -1)) (x (x 5 1) (x 0 -1)) (z (z 3 0) (z 1 1))))
; (newline) (display (combine-groups L1 L2 add-terms-one-variable))



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

; ((x 5 1) (y 2 1) (x 0 -1) (y 0 -1))
; (newline) (display term-list) 

; ((x 3 10) (x 0 8))
; (newline) (display (add-terms-one-variable '((x 3 5) (x 0 4)) '((x 3 5) (x 0 4))))

; ((x 6 25) (x 3 40) (x 0 16))
; (newline) (display (mul-terms-one-variable '((x 3 5) (x 0 4)) '((x 3 5) (x 0 4))))
