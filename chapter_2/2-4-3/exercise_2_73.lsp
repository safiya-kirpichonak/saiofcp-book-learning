
#|
You can't run this code.

a. This code uses type dispatching. Everything remains the same, but instead of using a regular 
"if" to determine which operation to apply, the code uses a table where columns represent 
operations (such as sum or product), and rows represent operations like "make" and selectors. 
It cannot be included because it is meaningless. We have a table designed to work with a 
specific set of data types (sum or product), and the operations "variable?" and "number?" do not 
belong to this set and are not operations on these data types.

d. ...
|#

(define (install-sum-operations)
    ;; internal procedures
    (define (make a1 a2)
        (cond ((=number? a1 0) a2)
              ((=number? a2 0) a1)
              ((and (number? a1) (number? a2)) (+ a1 a2))
              (else (list '+ a1 a2))))

    (define (addend sum) (cadr sum))

    (define (augend sum) (caddr sum))

    ;; external interface
    (define (tag x) (attach-tag '+ x))
    (put 'make '(+) make)
    (put 'first-operand '(+) (lambda (exponentiation) (addend exponentiation)))
    (put 'second-operand '(+) (lambda (exponentiation) (augend exponentiation)))
    done)

(define (install-product-operations)
    ;; internal procedures
    (define (make-product m1 m2)
        (cond ((or (=number? m1 0) (=number? m2 0)) 0)
              ((=number? m1 1) m2)
              ((=number? m2 1) m1)
              ((and (number? m1) (number? m2)) (* m1 m2))
              (else (list '* m1 m2))))
        
    (define (multiplier p) (cadr p))

    (define (multiplicand p) (caddr p))

    ;; external interface
    (define (tag x) (attach-tag '* x))
    (put 'make '(*) make)
    (put 'first-operand '(*) (lambda (exponentiation) (multiplier exponentiation)))
    (put 'second-operand '(*) (lambda (exponentiation) (multiplicand exponentiation)))
    done)

(define (install-exponential-operations)
    ;; internal procedures
    (define (make-exponentiation base exponent)
        (cond ((=number? exponent 0) 1)
              ((=number? exponent 1) base)
              (else (list '** base exponent))))

    (define (base exponentiation) (cadr exponentiation))

    (define (exponent exponentiation) (caddr exponentiation))

    ;; external interface
    (define (tag x) (attach-tag '** x))
    (put 'make '(**) make)
    (put 'first-operand '(**) (lambda (exponentiation) (base exponentiation)))
    (put 'second-operand '(**) (lambda (exponentiation) (exponent exponentiation)))
    done)

(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp) (if (same-variable? exp var) 1 0))
        (else (
                (get 'deriv (operator exp)) 
                (operands exp) 
                var))))

(define (operator exp) (car exp))

(define (operands exp) (cdr exp))
