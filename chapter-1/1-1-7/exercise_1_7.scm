(define (improve guess x)
    (/ 
        (+ 
            guess 
            (/ x guess)
        ) 
        2.0
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
(display (sqrt 9))
(newline)
(display (sqrt 2))
(newline)
(display (sqrt 0.0004))
(newline)
(display (sqrt 1000000))