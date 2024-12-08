; BAD

(define (variable? x) (symbol? x))

(define (same-variable? v1 v2)
    (and (variable? v1) (variable? v2) (eq? v1 v2)))

; sum

(define (make-sum . items)
  (define (sum result-sum result-exp items)
    (cond 
      ((null? items)
       (cond
         ((= (length result-exp) 1) result-sum)
         ((and (= (length result-exp) 2) (not (= result-sum 0))) (list '+ (cadr result-exp) result-sum))
         ((and (= (length result-exp) 2) (= result-sum 0)) (cadr result-exp))
         (else (if (= result-sum 0) result-exp (append result-exp (list result-sum))))))
      ((number? (car items)) (sum (+ result-sum (car items)) result-exp (cdr items)))
      (else (sum result-sum (append result-exp (list (car items))) (cdr items)))))
  (sum 0 (list '+) items))

(define (sum? x) (and (pair? x) (eq? (car x) '+)))

(define (addend sum) (cadr sum))

(define (augend sum) (apply make-sum (cdr (cdr sum))))

; product

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
  (product 1 (list '*) items))

(define (product? x) (and (pair? x) (eq? (car x) '*)))

(define (multiplier product) (cadr product))

(define (multiplicand product) (apply make-product (cdr (cdr product))))

; deriv

(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp) (if (same-variable? exp var) 1 0))
        ((sum? exp) 
            (make-sum (deriv (addend exp) var) 
                      (deriv (augend exp) var)))
        ((product? exp) 
            (make-sum
                (make-product (multiplier exp)
                              (deriv (multiplicand exp) var))
                (make-product (deriv (multiplier exp) var) 
                              (multiplicand exp))))
        (else (error "strange type of expression -- DERIV" exp))))

(newline) (display (deriv '(+ x 3) 'x)) ; 1
(newline) (display (deriv '(* x y) 'x)) ; (* (* y))
(newline) (display (deriv '(* (* x y) (+ x 3)) 'x)) ; (+ (* (* x y)) (* (* (* y)) (* (+ x 3))))
