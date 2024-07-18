;;; If Ben uses applicative-order evaluation (AOE), he will get an error because the program will
;;; try to evaluate all arguments before applying the function. In this case, evaluating (p) leads
;;; to an infinite recursion. and Scheme Lisp uses applicative-order evaluation, so it will result
;;; in an error due to the recursive call in (p).

;;; If Ben uses normal-order evaluation (NOE), he will get 0. This is because, with NOE, arguments
;;; are only evaluated when needed. Since x is 0, the if condition will return 0 without evaluating (p).

(define (p) (p))

(define (test x y)
    (
        if (= x 0)
        0
        y
    )
)

(display (test 0 (p)))