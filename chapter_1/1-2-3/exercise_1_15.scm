#|
    a. How many steps?
    1) size 12.15 => 12.15 / 3 => 4.05
    2) size 4.05 => 4.05 / 3 => 1.35
    3) size 1.35 => 1.35 / 3 => 0.45
    4) size 0.45 => 0.45 / 3 => 0.15
    5) size 0.15 => 0.15 / 3 => 0.05
    0.05 < 0.1 => result 0.05
    Answer: 5 times.

    b. Memory and steps order:
    - by step O(log3(a))
    - by memory O(log3(a))
|#

(define (cube x) 
    (* x x x)
)

(define (p x) 
    (- 
        (* 3 x) 
        (* 4 (cube x))
    )
)

(define (sine angle)
    (if 
        (not (> (abs angle) 0.1))
        angle
        (p (sine (/ angle 3.0)))
    )
)

(newline)
(display (sine 12.15))
(newline)
