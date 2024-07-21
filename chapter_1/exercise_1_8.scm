(define (improve guess x)
    (/ 
        (+
            (/ x (* guess guess))
            (* 2 guess)
        )
        3.0
    )
)

(define (good-enough? guess x)
    (< 
        (abs
            (-
                guess
                (improve guess x)
            )
        )
        0.001
    )
)

(define (sqrt-iter guess x)
    (if 
        (good-enough? guess x)
        guess
        (sqrt-iter 
            (improve guess x) 
            x
        )
    )
)

(define (sqrt x)
    (sqrt-iter 1.0 x)
)

(newline)
(display (sqrt 27))
(newline)
(display (sqrt 8))
(newline)