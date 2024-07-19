;;; Lisa will receive infinity recursive, because LISP uses applicative-order evaluation (AOE). It means
;;; that in new-if both options (then and else cases) will be processed even if (good-enough? guess x) will be true.

(define (new-if predicate then-cause else-cause)
    (cond 
        (predicate then-cause)
        (else else-cause)
    )
)

(newline)
(display (new-if (= 2 3) 0 5))
(newline)
(display (new-if (= 1 1) 0 5))

(define (sqrt-iter guess x)
    (new-if 
        (good-enough? guess x)
        guess
        (sqrt-iter 
            (improve guess x) 
            x
        )
    )
)