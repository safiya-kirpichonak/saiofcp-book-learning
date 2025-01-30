#|
This code reverse the list.
Iteration 1: a -> b -> c -> d
Iteration 2: a -> null - so after that interaction new list was created with (temp (cdr x))
and that is why (newline) (display v) is (a) because next iteration use temp and x is used
like y.
|#

(define (mystery x) 
    (define (loop x y)
        (newline) (display x) (display " : ") (display y)
        (if (null? x)
            y
            (let ((temp (cdr x))) 
                 (set-cdr! x y) 
                 (loop temp x))))
    (loop x '()))

(define v (list 'a 'b 'c 'd))
(newline) (display v) ; (a b c d)

; (a b c d) : ()
; (b c d) : (a)
; (c d) : (b a)
; (d) : (c b a)
; () : (d c b a)
(define w (mystery v))
(newline) (display v) ; (a)
(newline) (display w) ; (d c b a)