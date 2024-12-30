
#|
a. This code uses type dispatching. Everything remains the same, but instead of using a regular 
"if" to determine which operation to apply, the code uses a table where columns represent 
operations (such as sum or product), and rows represent operations like "make" and selectors. 
It cannot be included because it is meaningless. We have a table designed to work with a 
specific set of data types (sum or product), and the operations "variable?" and "number?" do not 
belong to this set and are not operations on these data types.
|#

(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp) (if (same-variable? exp var) 1 0))
        (else ((get 'deriv (operator exp)) (operands exp) var))))

(define (operator exp) (car exp))

(define (operands exp) (cdr exp))


