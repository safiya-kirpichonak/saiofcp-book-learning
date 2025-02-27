(define (make-product . items)
  (define (product result-product result-exp items)
    (cond 
      ((null? items) 
       (cond
         ((= result-product 0) 0)
         ((= (length result-exp) 1) result-product)
         ((and (= (length result-exp) 2) (not (= result-product 1))) (list '* (cadr result-exp) result-product))
         (else (if (= result-product 1) result-exp (append result-exp (list result-product))))))
      ((number? (car items)) (product (* result-product (car items)) result-exp (cdr items)))
      (else (product result-product (append result-exp (list (car items))) (cdr items)))))
  (if (= (length items) 1) (car items) (product 1 (list '*) items)))

(newline) (display (make-product 1 2 3 4 5))            ; 120
(newline) (display (make-product 1 'x 3 4 5))           ; (+ x 60)
(newline) (display (make-product 0 'x 1 2 'y))          ; 0
(newline) (display (make-product 1 'x 3 'y 4))          ; (+ x y 12)
(newline) (display (make-product 1 'x 1 1 1 'y 'z))     ; (+ x y z)
(newline) (display (make-product 1 'x 1 1 1))          ; (+ x)

(define (product? x) (and (pair? x) (eq? (car x) '*)))

(define (multiplier product) (cadr product))

(define (multiplicand product) (apply make-product (cdr (cdr product))))